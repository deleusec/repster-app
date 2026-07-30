import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

/// Maps a DB row → [WorkoutSessionSummary]. Aggregates tonnage, time under
/// tension and completed set count from the nested `session_exercises` /
/// `session_sets` relations. Shared by `dashboard_repository` and
/// `sessions_repository` (same expected `select` columns).
///
/// Holds contribute to [WorkoutSessionSummary.timeUnderTensionSec], never to
/// the tonnage: `seconds × load` and `reps × load` are not the same unit, and
/// adding them made a 60 s loaded plank outweigh a heavy set.
class WorkoutSessionSummaryDto {
  const WorkoutSessionSummaryDto._();

  static WorkoutSessionSummary fromRow(Map<String, dynamic> row) {
    var tonnage = 0.0;
    var tensionSec = 0;
    var totalSets = 0;
    final exercises = (row['session_exercises'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    for (final ex in exercises) {
      final isTimeBased = (ex['is_time_based'] as bool?) ?? false;
      final sets = (ex['session_sets'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>();
      for (final s in sets) {
        if (s['completed_at'] == null) continue;
        totalSets++;
        if (isTimeBased) {
          tensionSec += (s['duration_performed_seconds'] as num?)?.round() ?? 0;
        } else {
          final weight = (s['weight_kg'] as num?)?.toDouble() ?? 0;
          final reps = (s['reps_performed'] as num?)?.toDouble() ?? 0;
          tonnage += reps * weight;
        }
      }
    }
    return WorkoutSessionSummary(
      id: row['id'] as String,
      templateName: row['template_name'] as String? ?? '',
      templateId: row['template_id'] as String?,
      startedAt: DateTime.parse(row['started_at'] as String),
      durationSeconds: (row['duration_seconds'] as int?) ?? 0,
      totalTonnageKg: tonnage,
      timeUnderTensionSec: tensionSec,
      totalSets: totalSets,
      tags: MuscleGroup.listFromDb(row['tags'] as List<dynamic>?),
    );
  }
}
