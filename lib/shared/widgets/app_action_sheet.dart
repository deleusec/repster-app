import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';

/// An action shown in an [AppActionSheet].
///
/// [icon] is only used on Android; iOS action sheets are conventionally
/// centered text with no icons.
class AppSheetAction<T> {
  const AppSheetAction({
    required this.value,
    required this.label,
    required this.icon,
    this.isDestructive = false,
  });

  /// Value returned by [AppActionSheet.show] when this action is chosen.
  final T value;

  final String label;

  /// Icon shown to the left of the label (Android only).
  final IconData icon;

  /// Colors the action red and marks it destructive (e.g. deletion).
  final bool isDestructive;
}

/// Platform-adaptive action menu, like a "choose a photo source" prompt:
///
/// - **iOS** → native [CupertinoActionSheet] with a separate "Cancel" button;
/// - **Android** (and others) → Material bottom sheet ([AppDrawerSheet]).
///
/// Returns the chosen [AppSheetAction.value], or `null` if cancelled.
class AppActionSheet {
  const AppActionSheet._();

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<AppSheetAction<T>> actions,
  }) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return isIOS
        ? _showCupertino<T>(context, title: title, actions: actions)
        : _showMaterial<T>(context, title: title, actions: actions);
  }

  static Future<T?> _showCupertino<T>(
    BuildContext context, {
    required String title,
    required List<AppSheetAction<T>> actions,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(title),
        actions: [
          for (final action in actions)
            CupertinoActionSheetAction(
              isDestructiveAction: action.isDestructive,
              onPressed: () => Navigator.of(context).pop(action.value),
              child: Text(action.label),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
      ),
    );
  }

  static Future<T?> _showMaterial<T>(
    BuildContext context, {
    required String title,
    required List<AppSheetAction<T>> actions,
  }) {
    return AppDrawerSheet.show<T>(
      context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final action in actions) _MaterialSheetItem<T>(action: action),
        ],
      ),
    );
  }
}

class _MaterialSheetItem<T> extends StatelessWidget {
  const _MaterialSheetItem({required this.action});

  final AppSheetAction<T> action;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = action.isDestructive
        ? scheme.error
        : scheme.onSurface.withValues(alpha: 0.8);
    return InkWell(
      onTap: () => Navigator.of(context).pop(action.value),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        child: Row(
          children: [
            Icon(action.icon, size: 18, color: fg.withValues(alpha: 0.7)),
            const SizedBox(width: 14),
            Text(
              action.label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
