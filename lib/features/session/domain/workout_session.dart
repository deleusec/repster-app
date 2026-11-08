import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/features/session/domain/workout_exercise.dart';

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
    required String notes,
  }) = _WorkoutSession;

  const WorkoutSession._();

  factory WorkoutSession.fromJson(Map<String, Object?> json) =>
      _$WorkoutSessionFromJson(json);

  /// Tonnage in kg: `reps × load`, over rep-based exercises only.
  ///
  /// Holds are deliberately excluded rather than counted as `seconds × load`:
  /// summing the two produced a number in no unit at all, where a 60 s plank
  /// with a 20 kg plate (1200) outweighed a 10 × 80 kg set (800). Time under
  /// tension is its own measure — see [timeUnderTensionSec].
  double get tonnageKg {
    var t = 0.0;
    for (final ex in exercises) {
      if (ex.isTimeBased) continue;
      for (final s in ex.sets) {
        if (!s.completed) continue;
        t += s.actualReps * s.weight;
      }
    }
    return t;
  }

  /// Seconds held over time-based exercises, completed sets only.
  int get timeUnderTensionSec {
    var seconds = 0;
    for (final ex in exercises) {
      if (!ex.isTimeBased) continue;
      for (final s in ex.sets) {
        if (!s.completed) continue;
        seconds += s.actualSeconds ?? 0;
      }
    }
    return seconds;
  }

  int get completedSets => exercises.fold(
    0,
    (n, ex) => n + ex.sets.where((s) => s.completed).length,
  );
}
