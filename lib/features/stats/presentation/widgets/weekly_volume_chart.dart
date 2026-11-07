import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/stats/domain/stats_data.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/stat_panel.dart';

/// Histogram of weekly aggregated volume (tonnage) — smoothed trend.
class WeeklyVolumeChart extends StatelessWidget {
  const WeeklyVolumeChart({required this.weeks, super.key});

  final List<WeeklyVolume> weeks;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final hasData = weeks.any((w) => w.tonnageKg > 0);

    return StatPanel(
      title: t.stats.weeklyVolume.title,
      icon: LucideIcons.chartColumn,
      child: !hasData
          ? Text(
              t.stats.weeklyVolume.empty,
              style: TextStyle(
                fontSize: 13,
                color: onSurface.withValues(alpha: 0.5),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceBetween,
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (_) => scheme.surfaceContainerHigh,
                          getTooltipItem: (group, _, rod, _) => BarTooltipItem(
                            formatTonnage(rod.toY),
                            TextStyle(
                              color: onSurface,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      barGroups: [
                        for (var i = 0; i < weeks.length; i++)
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: weeks[i].tonnageKg,
                                width: 10,
                                // The running week is drawn lighter: it is
                                // incomplete, not a collapse.
                                color: scheme.glow.withValues(
                                  alpha: weeks[i].isInProgress ? 0.35 : 0.85,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      shortDate(weeks.first.weekStart),
                      style: TextStyle(
                        fontSize: 11,
                        color: onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      weeks.last.isInProgress
                          ? t.stats.weeklyVolume.inProgress
                          : shortDate(weeks.last.weekStart),
                      style: TextStyle(
                        fontSize: 11,
                        color: onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
