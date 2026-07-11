import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/stats/domain/stats_data.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/icon_chip.dart';

/// 2×2 grid of range KPIs, each with its change (delta) vs the previous
/// period.
class StatsKpiGrid extends StatelessWidget {
  const StatsKpiGrid({required this.kpis, super.key});

  final StatKpis kpis;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _KpiCard(
                icon: LucideIcons.calendar,
                label: t.stats.kpi.sessions,
                value: '${kpis.sessions}',
                delta: kpis.sessionsDelta,
                tint: scheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _KpiCard(
                icon: LucideIcons.trendingUp,
                label: t.stats.kpi.volume,
                value: formatTonnage(kpis.volumeKg),
                delta: kpis.volumeDelta,
                tint: AppColors.accentEmerald,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _KpiCard(
                icon: LucideIcons.repeat,
                label: t.stats.kpi.sets,
                value: '${kpis.sets}',
                delta: kpis.setsDelta,
                tint: AppColors.accentOrange,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _KpiCard(
                icon: LucideIcons.clock,
                label: t.stats.kpi.avgDuration,
                value: kpis.avgDurationSec == 0
                    ? '–'
                    : formatDuration(kpis.avgDurationSec),
                delta: kpis.durationDelta,
                tint: AppColors.accentBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.delta,
    required this.tint,
  });

  final IconData icon;
  final String label;
  final String value;
  final double? delta;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: scheme.translucentCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconChip(icon: icon, color: tint, size: 26, iconSize: 13),
              const Spacer(),
              if (delta != null) _DeltaChip(delta: delta!),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeltaChip extends StatelessWidget {
  const _DeltaChip({required this.delta});

  final double delta;

  @override
  Widget build(BuildContext context) {
    final up = delta >= 0;
    final color = up ? AppColors.accentEmerald : AppColors.accentRose;
    final pct = (delta.abs() * 100).round();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            up ? LucideIcons.arrowUp : LucideIcons.arrowDown,
            size: 10,
            color: color,
          ),
          const SizedBox(width: 1),
          Text(
            '$pct%',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
