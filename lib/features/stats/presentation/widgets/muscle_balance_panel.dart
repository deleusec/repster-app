import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/stats/domain/stats_data.dart';
import 'package:repster/features/stats/presentation/widgets/stat_panel.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/l10n/muscle_group_l10n.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';

/// Threshold (days) beyond which a group is flagged as neglected.
const int _neglectDays = 10;

/// Muscle balance: per-group frequency bars (over the range) + a soft alert
/// for groups not trained in a while.
class MuscleBalancePanel extends StatelessWidget {
  const MuscleBalancePanel({required this.loads, super.key});

  final List<MuscleLoad> loads;

  @override
  Widget build(BuildContext context) {
    if (loads.isEmpty) return const SizedBox.shrink();
    final maxSessions = loads.fold<int>(
      0,
      (m, l) => l.sessions > m ? l.sessions : m,
    );

    final neglected = [
      for (final l in loads)
        if ((l.daysSinceLast ?? 0) > _neglectDays) l,
    ]..sort((a, b) => (b.daysSinceLast ?? 0).compareTo(a.daysSinceLast ?? 0));

    return StatPanel(
      title: t.stats.muscleBalance.title,
      icon: LucideIcons.scale,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (neglected.isNotEmpty) ...[
            _NeglectAlert(load: neglected.first),
            const SizedBox(height: 14),
          ],
          for (final l in loads)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _MuscleRow(load: l, maxSessions: maxSessions),
            ),
        ],
      ),
    );
  }
}

class _NeglectAlert extends StatelessWidget {
  const _NeglectAlert({required this.load});

  final MuscleLoad load;

  @override
  Widget build(BuildContext context) {
    const color = AppColors.accentOrange;
    final days = load.daysSinceLast ?? 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.triangleAlert, size: 15, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${load.group.localizedLabel} '),
                  TextSpan(
                    text: t.stats.muscleBalance.neglected(
                      days: days,
                      emoji: load.group.emoji,
                    ),
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MuscleRow extends StatelessWidget {
  const _MuscleRow({required this.load, required this.maxSessions});

  final MuscleLoad load;
  final int maxSessions;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final accent = load.group.accent;
    final ratio = maxSessions == 0 ? 0.0 : load.sessions / maxSessions;
    final since = load.daysSinceLast;
    final neglected = (since ?? 0) > _neglectDays;

    return Row(
      children: [
        SizedBox(
          width: 96,
          child: Text(
            load.group.localizedLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: onSurface.withValues(alpha: 0.85),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 7,
              backgroundColor: onSurface.withValues(alpha: 0.06),
              valueColor: AlwaysStoppedAnimation<Color>(accent),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 22,
          child: Text(
            '${load.sessions}',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: onSurface,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 42,
          child: Text(
            _sinceLabel(since),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 11,
              fontWeight: neglected ? FontWeight.w700 : FontWeight.w500,
              color: neglected
                  ? AppColors.accentOrange
                  : onSurface.withValues(alpha: 0.4),
            ),
          ),
        ),
      ],
    );
  }

  String _sinceLabel(int? days) {
    if (days == null) return t.stats.muscleBalance.since.none;
    if (days == 0) return t.stats.muscleBalance.since.today;
    if (days == 1) return t.stats.muscleBalance.since.yesterday;
    return t.stats.muscleBalance.since.daysShort(n: days);
  }
}
