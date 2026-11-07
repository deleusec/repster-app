import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/history/domain/history_stats.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/icon_chip.dart';

/// History summary banner: session count, cumulative volume (emerald accent)
/// and total time, as three tiles separated by hairlines.
class HistoryStatsPanel extends StatelessWidget {
  const HistoryStatsPanel({required this.stats, super.key});

  final HistoryStats stats;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return EdgeLitSurface(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: _Stat(
              icon: LucideIcons.dumbbell,
              value: '${stats.sessionCount}',
              label: t.history.panel.sessions,
              tint: scheme.glow,
            ),
          ),
          _VDivider(color: scheme.hairline),
          Expanded(
            child: _Stat(
              icon: LucideIcons.trendingUp,
              value: formatTonnage(stats.totalTonnageKg),
              label: t.history.panel.volume,
              tint: AppColors.accentEmerald,
              valueColor: AppColors.accentEmerald,
            ),
          ),
          _VDivider(color: scheme.hairline),
          Expanded(
            child: _Stat(
              icon: LucideIcons.clock,
              value: formatDuration(stats.totalDurationSeconds),
              label: t.history.panel.time,
              tint: AppColors.accentOrange,
            ),
          ),
        ],
      ),
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 64, color: color);
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.value,
    required this.label,
    required this.tint,
    this.valueColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color tint;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconChip(icon: icon, color: tint, size: 30),
        const SizedBox(height: 8),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppText.statValue.copyWith(
            fontSize: 18,
            letterSpacing: -0.5,
            color: valueColor ?? scheme.textPrimary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: AppText.caption.copyWith(
            fontSize: 11,
            color: scheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
