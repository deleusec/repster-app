import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/glass_surface.dart';

/// Helpers for confirmation dialogs in the design-system "glass" style (blur +
/// translucent surface + hairline), consistent with the sheets.
class AppDialog {
  const AppDialog._();

  /// Shows a centered confirmation dialog. Returns `true` if confirmed,
  /// `false`/`null` otherwise. [destructive] colors the action red (with a
  /// default warning icon).
  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool destructive = false,
    IconData? icon,
  }) {
    // Default to the shared, localized action labels.
    final confirmText = confirmLabel ?? t.common.actions.confirm;
    final cancelText = cancelLabel ?? t.common.actions.cancel;
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: kGlassScrimAlpha),
      builder: (context) {
        final scheme = Theme.of(context).colorScheme;
        final onSurface = scheme.onSurface;
        final accent = destructive ? scheme.error : scheme.primary;
        final headIcon =
            icon ?? (destructive ? LucideIcons.triangleAlert : null);

        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: GlassSurface(
              borderRadius: BorderRadius.circular(AppRadius.sheet),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (headIcon != null) ...[
                      Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(headIcon, size: 22, color: accent),
                      ),
                      const SizedBox(height: 14),
                    ],
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.3,
                        color: onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: _DialogButton(
                            label: cancelText,
                            color: onSurface.withValues(alpha: 0.85),
                            background: onSurface.withValues(alpha: 0.06),
                            onTap: () => Navigator.of(context).pop(false),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _DialogButton(
                            label: confirmText,
                            color: destructive ? accent : scheme.onPrimary,
                            background: destructive
                                ? accent.withValues(alpha: 0.15)
                                : accent,
                            border: destructive
                                ? accent.withValues(alpha: 0.3)
                                : null,
                            onTap: () => Navigator.of(context).pop(true),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.color,
    required this.background,
    required this.onTap,
    this.border,
  });

  final String label;
  final Color color;
  final Color background;
  final Color? border;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(AppRadius.control),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.control),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: border == null
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.control),
                  border: Border.all(color: border!),
                ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
