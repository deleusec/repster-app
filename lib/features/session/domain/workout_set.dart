import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_set.freezed.dart';
part 'workout_set.g.dart';

/// Fallback hold duration when nothing provides one (template without
/// `duration_seconds`, new set on a time-based exercise…).
const int kDefaultHoldSeconds = 30;

/// A set performed during a live session. If the parent exercise is
/// `isTimeBased`, `targetSeconds` / `actualSeconds` are filled instead of
/// `targetReps` / `actualReps`.
@freezed
class WorkoutSet with _$WorkoutSet {
  const factory WorkoutSet({
    required String id,
    required int setNumber,
    required int targetReps,
    required int actualReps,
    required double weight,
    required bool completed,
    int? targetSeconds,
    int? actualSeconds,
  }) = _WorkoutSet;

  const WorkoutSet._();

  factory WorkoutSet.fromJson(Map<String, Object?> json) =>
      _$WorkoutSetFromJson(json);
}
