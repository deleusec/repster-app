import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/i18n/translations.g.dart';

/// Dashboard section header: a small-caps title plus an optional "See all"
/// action.
class DashboardSectionHeader extends StatelessWidget {
  const DashboardSectionHeader({
    required this.title,
    this.onSeeAll,
    this.seeAllLabel,
    super.key,
  });

  final String title;
  final VoidCallback? onSeeAll;
  final String? seeAllLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = seeAllLabel ?? t.dashboard.seeAll;
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.8,
            color: scheme.onSurface.withValues(alpha: 0.50),
          ),
        ),
        const Spacer(),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.primary.withValues(alpha: 0.70),
                  ),
                ),
                const SizedBox(width: 2),
                Icon(
                  LucideIcons.chevronRight,
                  size: 14,
                  color: scheme.primary.withValues(alpha: 0.70),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
