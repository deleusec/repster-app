import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/features/session/domain/workout_set.dart';

part 'workout_exercise.freezed.dart';
part 'workout_exercise.g.dart';

/// Exercise variant frozen at session start to allow quick swaps without
/// re-fetching. Carries its own `exerciseId`: switching variant switches
/// exercise, so it switches history too.
@freezed
class WorkoutVariant with _$WorkoutVariant {
  const factory WorkoutVariant({
    required String name,
    required int sets,
    required int reps,
    required String tempo,
    required int restTime,
    required String notes,
    @Default(false) bool isTimeBased,
    int? durationSeconds,
    String? exerciseId,
  }) = _WorkoutVariant;

  const WorkoutVariant._();

  factory WorkoutVariant.fromJson(Map<String, Object?> json) =>
      _$WorkoutVariantFromJson(json);
}

@freezed
class WorkoutExercise with _$WorkoutExercise {
  const factory WorkoutExercise({
    required String id,
    required String name,
    required String notes,
    required String tempo,
    required int restTime,
    required List<WorkoutSet> sets,
    @Default(false) bool isTimeBased,

    /// Catalog identity, when known. `null` for an exercise typed by hand in
    /// session — the history lookup then falls back to the normalized name.
    String? exerciseId,
    String? slotId,
    String? originalName,
    @Default(false) bool sessionModified,
    List<WorkoutVariant>? variants,
    int? activeVariantIndex,
    String? supersetGroupId,
    int? supersetPosition,
    int? supersetSize,
  }) = _WorkoutExercise;

  const WorkoutExercise._();

  factory WorkoutExercise.fromJson(Map<String, Object?> json) =>
      _$WorkoutExerciseFromJson(json);

  bool get inSuperset => supersetGroupId != null;

  /// Number of completed sets.
  int get completedSetCount => sets.where((s) => s.completed).length;

  /// True when every set is completed (and there is at least one).
  bool get allSetsCompleted =>
      sets.isNotEmpty && sets.every((s) => s.completed);

  /// Exercise tonnage in kg (completed sets only), `0` for a hold — seconds
  /// and reps are not the same unit, so a hold reports [holdTime] instead.
  double get tonnage {
    if (isTimeBased) return 0;
    var t = 0.0;
    for (final s in sets) {
      if (!s.completed) continue;
      t += s.actualReps * s.weight;
    }
    return t;
  }

  /// Total seconds held (time-based exercise, completed sets only).
  int get holdTime {
    if (!isTimeBased) return 0;
    var total = 0;
    for (final s in sets) {
      if (s.completed) total += s.actualSeconds ?? 0;
    }
    return total;
  }
}
