import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/dashboard/domain/weekly_stats.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';

/// Weekly stats panel in a 2-column grid (Sessions / Volume) with a vertical
/// divider.
///
/// No streak cell: the header badge already carries the current streak, and the
/// consistency panel below carries the best one.
class WeeklyStatsPanel extends StatelessWidget {
  const WeeklyStatsPanel({required this.stats, super.key});

  final WeeklyStats stats;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final border = scheme.onSurface.withValues(alpha: 0.08);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: border),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _StatCell(
                icon: LucideIcons.calendar,
                iconColor: scheme.primary,
                label: t.dashboard.stats.sessions,
                value: '${stats.sessionsThisWeek}',
                sub: t.dashboard.stats.thisWeek,
              ),
            ),
            _Divider(color: border),
            Expanded(
              child: _StatCell(
                icon: LucideIcons.trendingUp,
                iconColor: AppColors.accentEmerald,
                label: t.dashboard.stats.volume,
                value: formatTonnage(stats.volumeThisWeekKg),
                sub: t.dashboard.stats.thisWeek,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) => Container(width: 1, color: color);
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.sub,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String sub;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      color: onSurface.withValues(alpha: 0.03),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 13, color: iconColor),
              const SizedBox(width: 4),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: onSurface.withValues(alpha: 0.30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            style: TextStyle(
              fontSize: 10,
              color: onSurface.withValues(alpha: 0.25),
            ),
          ),
        ],
      ),
    );
  }
}
