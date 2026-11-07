import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/dashboard/domain/weekly_stats.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';

/// The week in three numbers — sessions, volume, streak — set as a strip
/// between hairlines rather than a card. The home page already carries the
/// hero card and the consistency panel; a third box would make it a stack of
/// boxes, so this one is just figures on the page.
class WeeklyStatsPanel extends StatelessWidget {
  const WeeklyStatsPanel({required this.stats, super.key});

  final WeeklyStats stats;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final streak = stats.streakWeeks;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _Figure(
              value: '${stats.sessionsThisWeek}',
              label: t.dashboard.stats.sessionsWeek,
            ),
          ),
          _Rule(color: scheme.hairline),
          Expanded(
            child: _Figure(
              value: formatTonnage(stats.volumeThisWeekKg),
              label: t.dashboard.stats.volumeWeek,
              color: stats.volumeThisWeekKg > 0
                  ? AppColors.accentEmerald
                  : null,
            ),
          ),
          _Rule(color: scheme.hairline),
          Expanded(
            child: _Figure(
              value: '$streak',
              label: t.dashboard.stats.streakLabel(n: streak),
              color: streak >= 3 ? AppColors.accentOrange : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    height: 40,
    margin: const EdgeInsets.symmetric(horizontal: 12),
    color: color,
  );
}

class _Figure extends StatelessWidget {
  const _Figure({required this.value, required this.label, this.color});

  final String value;
  final String label;

  /// A semantic colour for a figure that earned one (volume lifted, a streak
  /// worth noticing); plain text otherwise.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppText.statValue.copyWith(color: color ?? scheme.textPrimary),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          maxLines: 2,
          style: AppText.caption.copyWith(
            fontSize: 11,
            height: 1.25,
            color: scheme.textTertiary,
          ),
        ),
      ],
    );
  }
}
