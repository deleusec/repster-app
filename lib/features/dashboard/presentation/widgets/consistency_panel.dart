import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/features/dashboard/domain/consistency.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/stat_panel.dart';

/// Handle on the rendered grid, so its responsive width can be asserted.
const heatmapGridKey = Key('consistencyHeatmapGrid');

/// Consistency: mini-stats (active days / frequency / best streak) + a
/// GitHub-style daily activity heatmap over ~4 months.
///
/// Lives on the home page: regularity is what you check when you open the app.
class ConsistencyPanel extends StatelessWidget {
  const ConsistencyPanel({
    required this.consistency,
    this.hasHistory = true,
    super.key,
  });

  final Consistency consistency;

  /// Whether the user has ever completed a session. Distinguishes "nothing yet"
  /// from "nothing in the last four months" — the second is a real gap worth
  /// showing as an empty grid, the first is just noise.
  final bool hasHistory;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = consistency;
    return StatPanel(
      title: t.dashboard.consistency.title,
      icon: LucideIcons.flame,
      child: hasHistory
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _Mini(
                      value: '${c.trainingDays}',
                      label: t.dashboard.consistency.trainingDays,
                    ),
                    _Mini(
                      value: c.sessionsPerWeek.toStringAsFixed(1),
                      label: t.dashboard.consistency.perWeek,
                    ),
                    _Mini(
                      value: '${c.bestStreakWeeks}',
                      label: t.dashboard.consistency.bestStreak,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _Heatmap(dayCounts: c.dayCounts, primary: scheme.primary),
              ],
            )
          : const _NotYet(),
    );
  }
}

/// Before the first session: three zeros and 126 grey squares say nothing, so
/// the panel says what will appear here instead. No button — the card above
/// already carries the one action.
class _NotYet extends StatelessWidget {
  const _NotYet();

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Text(
      t.dashboard.consistency.notYet,
      style: TextStyle(
        fontSize: 13,
        height: 1.35,
        color: onSurface.withValues(alpha: 0.45),
      ),
    );
  }
}

class _Mini extends StatelessWidget {
  const _Mini({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: onSurface.withValues(alpha: 0.45),
            ),
          ),
        ],
      ),
    );
  }
}

class _Heatmap extends StatelessWidget {
  const _Heatmap({required this.dayCounts, required this.primary});

  final Map<DateTime, int> dayCounts;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thisMonday = today.subtract(Duration(days: today.weekday - 1));
    final start = thisMonday.subtract(
      const Duration(days: 7 * (kHeatmapWeeks - 1)),
    );

    Color cellColor(int count, {required bool future}) {
      if (future) return Colors.transparent;
      if (count <= 0) return onSurface.withValues(alpha: 0.05);
      if (count == 1) return primary.withValues(alpha: 0.45);
      return primary.withValues(alpha: 0.85);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Both the cell and the gap flex, each inside a narrow band, then
        // whatever width is left over is split around the grid.
        //
        // Growing the cells alone breaks down fast: the grid is seven rows
        // tall, so a wide window would make it tall as well. Leaving them
        // capped and packed to the left — what this did before — stranded a
        // 375 px grid against the left edge of a full-width card.
        final (cell, gap) = _fit(constraints.maxWidth);
        final gridWidth = kHeatmapWeeks * cell + (kHeatmapWeeks - 1) * gap;

        return Center(
          child: SizedBox(
            key: heatmapGridKey,
            width: gridWidth,
            child: Row(
              children: [
                for (var w = 0; w < kHeatmapWeeks; w++) ...[
                  if (w > 0) SizedBox(width: gap),
                  Column(
                    children: [
                      for (var d = 0; d < 7; d++) ...[
                        if (d > 0) SizedBox(height: gap),
                        Builder(
                          builder: (_) {
                            final day = start.add(Duration(days: 7 * w + d));
                            final future = day.isAfter(today);
                            final count = dayCounts[day] ?? 0;
                            return Container(
                              width: cell,
                              height: cell,
                              decoration: BoxDecoration(
                                color: cellColor(count, future: future),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  /// Cell size and gap for [width]. The cell takes the width first, within
  /// `[8, 18]`; the gap absorbs part of the remainder, within `[3, 7]`.
  static (double, double) _fit(double width) {
    const minCell = 8.0;
    const maxCell = 18.0;
    const minGap = 3.0;
    const maxGap = 7.0;
    const columns = kHeatmapWeeks;

    final cell = ((width - (columns - 1) * minGap) / columns).clamp(
      minCell,
      maxCell,
    );
    final gap = ((width - columns * cell) / (columns - 1)).clamp(
      minGap,
      maxGap,
    );
    return (cell, gap);
  }
}
