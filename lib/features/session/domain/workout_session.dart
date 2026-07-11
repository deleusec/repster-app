import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

part 'workout_session.freezed.dart';
part 'workout_session.g.dart';

@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required String templateId,
    required String templateName,
    required DateTime startedAt,
    required int duration,
    required List<WorkoutExercise> exercises,
    required List<MuscleGroup> tags,
    required String notes,
  }) = _WorkoutSession;

  const WorkoutSession._();

  factory WorkoutSession.fromJson(Map<String, Object?> json) =>
      _$WorkoutSessionFromJson(json);

  double get totalTonnage {
    var t = 0.0;
    for (final ex in exercises) {
      for (final s in ex.sets) {
        if (!s.completed) continue;
        if (ex.isTimeBased) {
          t += (s.actualSeconds ?? 0) * s.weight;
        } else {
          t += s.actualReps * s.weight;
        }
      }
    }
    return t;
  }

  int get completedSets => exercises.fold(
    0,
    (n, ex) => n + ex.sets.where((s) => s.completed).length,
  );
}
