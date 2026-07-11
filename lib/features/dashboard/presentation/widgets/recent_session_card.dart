import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';

/// Recent session row: group thumbnail, name + date·duration, and tonnage in a
/// green accent on the right.
class RecentSessionCard extends StatelessWidget {
  const RecentSessionCard({required this.summary, this.onTap, super.key});

  final WorkoutSessionSummary summary;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final group = summary.tags.isNotEmpty
        ? summary.tags.first
        : MuscleGroup.custom;

    return Material(
      color: onSurface.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(AppRadius.card),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: onSurface.withValues(alpha: 0.07)),
          ),
          padding: const EdgeInsets.all(16),
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
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${shortDate(summary.startedAt)} · '
                      '${formatDuration(summary.durationSeconds)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: onSurface.withValues(alpha: 0.35),
                      ),
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
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentEmerald,
                    ),
                  ),
                  Text(
                    t.dashboard.recent.tonnage,
                    style: TextStyle(
                      fontSize: 10,
                      color: onSurface.withValues(alpha: 0.30),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
