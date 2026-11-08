import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/core/emoji/fluent_emoji.dart';

part 'workout_session_summary.freezed.dart';

/// Lightweight summary of a completed session — used by the dashboard, history
/// and stats. Does not include individual sets.
@freezed
class WorkoutSessionSummary with _$WorkoutSessionSummary {
  const factory WorkoutSessionSummary({
    required String id,
    required String templateName,

    /// Template the session came from. Null once that template is deleted —
    /// only [templateName] survives.
    required String? templateId,
    required DateTime startedAt,
    required int durationSeconds,
    required double totalTonnageKg,
    required int totalSets,

    /// Picture snapshotted from the template at session start. Sessions
    /// older than the picker get one from their legacy tags when read.
    required FluentEmoji emoji,

    /// Seconds held on time-based exercises. Kept apart from the tonnage:
    /// seconds and reps are not the same unit.
    @Default(0) int timeUnderTensionSec,
  }) = _WorkoutSessionSummary;

  const WorkoutSessionSummary._();
}
