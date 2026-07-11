import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';

enum AppButtonVariant { primary, secondary, ghost, destructive, outline }

enum AppButtonSize { sm, md, lg }

/// Generic button with variants (primary / secondary / ghost / destructive /
/// outline) and sizes (sm / md / lg). Equivalent to shadcn's `<Button>`.
///
/// Handles the [loading] state (spinner + disabled) and [icon] (before the
/// label).
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.icon,
    this.iconSize,
    this.trailingIcon,
    this.loading = false,
    this.expand = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;

  /// Overrides the leading [icon] size. Defaults to `fontSize + 4`. Useful for
  /// Material glyphs (e.g. a filled play) that read smaller than Lucide ones at
  /// the same nominal size because of their built-in padding.
  final double? iconSize;
  final IconData? trailingIcon;
  final bool loading;

  /// If true, the button fills the available width.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDisabled = loading || onPressed == null;

    final (height, fontSize, hPad) = switch (size) {
      AppButtonSize.sm => (36.0, 13.0, 14.0),
      AppButtonSize.md => (44.0, 14.0, 20.0),
      AppButtonSize.lg => (52.0, 15.0, 24.0),
    };

    final (bg, fg, borderColor) = switch (variant) {
      AppButtonVariant.primary => (scheme.primary, scheme.onPrimary, null),
      AppButtonVariant.secondary => (
        scheme.surfaceContainerHigh,
        scheme.onSurface,
        null,
      ),
      AppButtonVariant.ghost => (Colors.transparent, scheme.onSurface, null),
      AppButtonVariant.destructive => (scheme.error, scheme.onError, null),
      AppButtonVariant.outline => (
        Colors.transparent,
        scheme.onSurface,
        scheme.outline,
      ),
    };

    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading)
          SizedBox(
            width: fontSize + 2,
            height: fontSize + 2,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: fg.withValues(alpha: 0.8),
            ),
          )
        else if (icon != null) ...[
          Icon(icon, size: iconSize ?? fontSize + 4),
          const SizedBox(width: 8),
        ],
        if (!loading)
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.1,
                color: fg,
              ),
            ),
          ),
        if (!loading && trailingIcon != null) ...[
          const SizedBox(width: 6),
          Icon(trailingIcon, size: fontSize + 2),
        ],
      ],
    );

    final button = Material(
      color: bg.withValues(alpha: isDisabled ? 0.5 : 1.0),
      borderRadius: BorderRadius.circular(AppRadius.xxl),
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: hPad),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            border: borderColor != null ? Border.all(color: borderColor) : null,
          ),
          alignment: Alignment.center,
          child: DefaultTextStyle.merge(
            style: TextStyle(color: fg),
            child: IconTheme.merge(
              data: IconThemeData(color: fg, size: fontSize + 4),
              child: child,
            ),
          ),
        ),
      ),
    );

    if (expand) return SizedBox(width: double.infinity, child: button);
    return button;
  }
}
