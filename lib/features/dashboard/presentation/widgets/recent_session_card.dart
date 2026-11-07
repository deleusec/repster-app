import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';

/// Recent session row: group thumbnail, name + date·duration, and the
/// tonnage on the right — the figure the session is remembered by.
class RecentSessionCard extends StatelessWidget {
  const RecentSessionCard({required this.summary, this.onTap, super.key});

  final WorkoutSessionSummary summary;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final group = summary.tags.isNotEmpty
        ? summary.tags.first
        : MuscleGroup.custom;

    return EdgeLitSurface(
      onTap: onTap,
      padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
      child: Row(
        children: [
          MuscleGroupBadge(group: group),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  summary.templateName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.cardTitle.copyWith(color: scheme.textPrimary),
                ),
                const SizedBox(height: 3),
                Text(
                  '${shortDate(summary.startedAt)} · '
                  '${formatDuration(summary.durationSeconds)}',
                  style: AppText.caption.copyWith(color: scheme.textTertiary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatTonnage(summary.totalTonnageKg),
                style: AppText.statValue.copyWith(
                  fontSize: 16,
                  color: AppColors.accentEmerald,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                t.dashboard.recent.tonnage,
                style: AppText.caption.copyWith(
                  fontSize: 10,
                  color: scheme.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
