import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/features/templates/domain/muscle_group.dart';

part 'workout_session_summary.freezed.dart';

/// Lightweight summary of a completed session — used by the dashboard, history
/// and stats. Does not include individual sets.
@freezed
class WorkoutSessionSummary with _$WorkoutSessionSummary {
  const factory WorkoutSessionSummary({
    required String id,
    required String templateName,
    required DateTime startedAt,
    required int durationSeconds,
    required double totalTonnageKg,
    required int totalSets,
    required List<MuscleGroup> tags,
  }) = _WorkoutSessionSummary;

  const WorkoutSessionSummary._();
}
