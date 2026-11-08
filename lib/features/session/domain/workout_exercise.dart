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

    /// The user asked for this exercise, as it now stands, to be written back
    /// to the template when the session ends. Off by default: a change made
    /// mid-session is for today only unless said otherwise.
    @Default(false) bool keepInTemplate,
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

  /// The template variant this exercise was started from, `null` for an
  /// exercise added in session.
  WorkoutVariant? get templateOrigin {
    final list = variants;
    if (list == null || list.isEmpty) return null;
    final idx = (activeVariantIndex ?? 0).clamp(0, list.length - 1);
    return list[idx];
  }

  /// Whether the exercise no longer matches its template origin on anything
  /// the template records: identity, set count, target, rest, tempo, notes.
  /// An exercise added in session always differs. Loads are never compared —
  /// the template has none.
  bool get differsFromTemplate {
    final origin = templateOrigin;
    if (origin == null) return true;
    final originTarget = origin.isTimeBased
        ? (origin.durationSeconds ?? kDefaultHoldSeconds)
        : origin.reps;
    return name != origin.name ||
        exerciseId != origin.exerciseId ||
        isTimeBased != origin.isTimeBased ||
        sets.length != origin.sets ||
        (currentTarget ?? originTarget) != originTarget ||
        restTime != origin.restTime ||
        tempo != origin.tempo ||
        notes != origin.notes;
  }

  /// Reps (or seconds, for a hold) the exercise is aiming for today, read off
  /// its first set. Ranks its history: a 5-rep day and a 10-rep day on the same
  /// movement are not the same effort.
  int? get currentTarget => sets.isEmpty
      ? null
      : (isTimeBased ? sets.first.targetSeconds : sets.first.targetReps);

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
