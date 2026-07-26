import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/profile/domain/profile_stats.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';

/// Three-cell summary row: sessions, tonnage, sets.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({required this.stats, super.key});

  final ProfileStats stats;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final divider = scheme.hairline;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: scheme.translucentCard,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _StatCell(
                icon: LucideIcons.dumbbell,
                tint: scheme.primary,
                label: t.profile.stats.sessions,
                value: '${stats.sessionCount}',
              ),
            ),
            Container(width: 1, color: divider),
            Expanded(
              child: _StatCell(
                icon: LucideIcons.trendingUp,
                tint: AppColors.accentEmerald,
                label: t.profile.stats.tonnage,
                value: formatTonnage(stats.totalTonnageKg),
              ),
            ),
            Container(width: 1, color: divider),
            Expanded(
              child: _StatCell(
                icon: LucideIcons.flame,
                tint: AppColors.accentAmber,
                label: t.profile.stats.sets,
                value: '${stats.totalSets}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.tint,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color tint;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 13, color: tint),
            const SizedBox(width: 5),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: onSurface.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            height: 1,
            color: onSurface,
          ),
        ),
      ],
    );
  }
}
