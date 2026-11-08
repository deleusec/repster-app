import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/profile/domain/profile_stats.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';

/// Three-cell summary row: sessions, tonnage, sets.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({required this.stats, super.key});

  final ProfileStats stats;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final divider = scheme.hairline;
    return EdgeLitSurface(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: _StatCell(
              icon: LucideIcons.dumbbell,
              tint: scheme.glow,
              label: t.profile.stats.sessions,
              value: '${stats.sessionCount}',
            ),
          ),
          Container(width: 1, height: 40, color: divider),
          Expanded(
            child: _StatCell(
              icon: LucideIcons.trendingUp,
              tint: AppColors.accentEmerald,
              label: t.profile.stats.tonnage,
              value: formatTonnage(stats.totalTonnageKg),
            ),
          ),
          Container(width: 1, height: 40, color: divider),
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
    final scheme = Theme.of(context).colorScheme;
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
              style: AppText.microLabel.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: scheme.textTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppText.statValue.copyWith(
            letterSpacing: -0.5,
            color: scheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
