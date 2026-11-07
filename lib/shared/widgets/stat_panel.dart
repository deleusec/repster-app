import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';

/// Section card for the Stats page: lit surface + title (optional icon) + a
/// trailing action.
class StatPanel extends StatelessWidget {
  const StatPanel({
    required this.title,
    required this.child,
    this.icon,
    this.trailing,
    this.padding = const EdgeInsets.all(16),
    super.key,
  });

  final String title;
  final Widget child;
  final IconData? icon;
  final Widget? trailing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return EdgeLitSurface(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 15, color: scheme.textSecondary),
                const SizedBox(width: 7),
              ],
              Expanded(
                child: Text(
                  title,
                  style: AppText.bodyStrong.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                    color: scheme.textPrimary,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
