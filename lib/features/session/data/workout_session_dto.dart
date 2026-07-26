import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

/// Maps a DB row to a full [WorkoutSession] (with exercises + sets) from a
/// `workout_sessions` row joined with `session_exercises` / `session_sets`.
/// Used for history and session detail.
class WorkoutSessionDto {
  const WorkoutSessionDto._();

  static WorkoutSession fromRow(Map<String, dynamic> row) {
    final exRows =
        (row['session_exercises'] as List<dynamic>? ?? const [])
            .cast<Map<String, dynamic>>()
          ..sort(
            (a, b) => (a['position'] as int).compareTo(b['position'] as int),
          );
    final exercises = exRows.map(_exerciseFromRow).toList(growable: false);
    return WorkoutSession(
      id: row['id'] as String,
      templateId: row['template_id'] as String? ?? '',
      templateName: row['template_name'] as String? ?? '',
      startedAt: DateTime.parse(row['started_at'] as String),
      duration: (row['duration_seconds'] as int?) ?? 0,
      exercises: exercises,
      tags: MuscleGroup.listFromDb(row['tags'] as List<dynamic>?),
      notes: row['notes'] as String? ?? '',
    );
  }

  static WorkoutExercise _exerciseFromRow(Map<String, dynamic> row) {
    final isTimeBased = (row['is_time_based'] as bool?) ?? false;
    final sets =
        ((row['session_sets'] as List<dynamic>? ?? const [])
                .cast<Map<String, dynamic>>()
              ..sort(
                (a, b) =>
                    (a['set_number'] as int).compareTo(b['set_number'] as int),
              ))
            .map(
              (s) => WorkoutSet(
                id: s['id'] as String,
                setNumber: s['set_number'] as int,
                targetReps: (s['reps_target'] as int?) ?? 0,
                actualReps: (s['reps_performed'] as int?) ?? 0,
                weight: ((s['weight_kg'] as num?) ?? 0).toDouble(),
                completed: s['completed_at'] != null,
                targetSeconds: s['duration_target_seconds'] as int?,
                actualSeconds: s['duration_performed_seconds'] as int?,
              ),
            )
            .toList(growable: false);
    return WorkoutExercise(
      id: row['id'] as String,
      name: row['name'] as String? ?? '',
      notes: row['notes'] as String? ?? '',
      tempo: '2-0-2-0',
      restTime: 90,
      sets: sets,
      isTimeBased: isTimeBased,
      slotId: row['slot_id'] as String?,
      exerciseId: row['exercise_id'] as String?,
    );
  }
}
