import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';

/// Standard dark design-system card (equivalent to shadcn's `<Card>`).
///
/// `surfaceContainer` background, 1px translucent border, 2xl radius (18px).
/// [padding] defaults to 16px. [onTap] enables a splash when provided.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.onLongPress,
    this.borderColor,
    this.background,
    this.margin = EdgeInsets.zero,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? borderColor;
  final Color? background;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = background ?? scheme.surfaceContainer;
    final border = borderColor ?? scheme.outline;

    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: border),
      ),
      child: child,
    );

    if (onTap == null && onLongPress == null) {
      return Padding(padding: margin, child: content);
    }

    return Padding(
      padding: margin,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          child: content,
        ),
      ),
    );
  }
}
