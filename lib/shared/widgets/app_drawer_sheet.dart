import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/shared/widgets/glass_surface.dart';

const _sheetTopRadius = Radius.circular(AppRadius.sheet);

/// Opens the app's dark "glass" bottom sheet: blurred translucent panel,
/// rounded top corners, hairline, pronounced scrim. The background reaches the
/// physical bottom of the screen (the content handles its own safe area /
/// handle).
///
/// Shared base for [AppDrawerSheet] and custom sheets (session, stats) so they
/// all render identically.
Future<T?> showGlassSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
}) {
  final topInset = MediaQuery.paddingOf(context).top;
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    // `useSafeArea` stays false (default): the glass reaches the physical
    // bottom, while the content stays above the home indicator via its own
    // SafeArea.
    backgroundColor: Colors.transparent,
    elevation: 0,
    barrierColor: Colors.black.withValues(alpha: kGlassScrimAlpha),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height - topInset - 12,
    ),
    builder: (context) => GlassSheetSurface(child: builder(context)),
  );
}

/// Dark "glass" surface for a bottom sheet: rounded top corners, background
/// blur, translucent tint and hairline. Provides neither handle nor title —
/// the supplied content is responsible for those.
class GlassSheetSurface extends StatelessWidget {
  const GlassSheetSurface({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassSurface(
      borderRadius: const BorderRadius.vertical(top: _sheetTopRadius),
      child: child,
    );
  }
}

/// Standard grabber handle, to place at the top of a sheet's content.
class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 4),
      width: 36,
      height: 4,
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

/// "Glass" bottom sheet with a handle + optional title + close button.
///
/// ```dart
/// await AppDrawerSheet.show(
///   context,
///   title: 'Details',
///   child: const MyContent(),
/// );
/// ```
class AppDrawerSheet {
  const AppDrawerSheet._();

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isScrollControlled = true,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(20, 12, 20, 16),
  }) {
    return showGlassSheet<T>(
      context,
      builder: (context) =>
          _DrawerContent(title: title, padding: padding, child: child),
    );
  }
}

class _DrawerContent extends StatelessWidget {
  const _DrawerContent({
    required this.child,
    required this.padding,
    this.title,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final title = this.title;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SheetHandle(),
            if (title != null)
              Padding(
                // Matches the content padding (20) so the title and close
                // button align with the drawer body.
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                          color: onSurface,
                        ),
                      ),
                    ),
                    _CloseButton(onTap: () => Navigator.of(context).maybePop()),
                  ],
                ),
              ),
            Flexible(
              child: Padding(padding: padding, child: child),
            ),
          ],
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    // Rounded square icon button (`controlSm` role), consistent with the rest
    // of the DS (cf. `_NavButton`). Circles are reserved for pills / badges.
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.controlSm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.controlSm),
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppRadius.controlSm),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: Icon(
            LucideIcons.x,
            size: 16,
            color: onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
