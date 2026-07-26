import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/features/dashboard/domain/consistency.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/stat_panel.dart';

/// Consistency: mini-stats (active days / frequency / best streak) + a
/// GitHub-style daily activity heatmap over ~4 months.
///
/// Lives on the home page: regularity is what you check when you open the app.
class ConsistencyPanel extends StatelessWidget {
  const ConsistencyPanel({required this.consistency, super.key});

  final Consistency consistency;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = consistency;
    return StatPanel(
      title: t.dashboard.consistency.title,
      icon: LucideIcons.flame,
      child: Column(
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
        const gap = 3.0;
        final cell =
            ((constraints.maxWidth - (kHeatmapWeeks - 1) * gap) / kHeatmapWeeks)
                .clamp(8.0, 18.0);
        return Row(
          children: [
            for (var w = 0; w < kHeatmapWeeks; w++) ...[
              if (w > 0) const SizedBox(width: gap),
              Column(
                children: [
                  for (var d = 0; d < 7; d++) ...[
                    if (d > 0) const SizedBox(height: gap),
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
        );
      },
    );
  }
}
