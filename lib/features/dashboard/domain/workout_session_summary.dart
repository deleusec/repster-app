import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/core/emoji/fluent_emoji.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/session_emoji.dart';

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
    required List<MuscleGroup> tags,

    /// Seconds held on time-based exercises. Kept apart from the tonnage:
    /// seconds and reps are not the same unit.
    @Default(0) int timeUnderTensionSec,

    /// Picture snapshotted from the template at session start; `null` for
    /// sessions older than the picker or started from the PWA.
    FluentEmoji? emoji,
  }) = _WorkoutSessionSummary;

  const WorkoutSessionSummary._();

  FluentEmoji get displayEmoji => sessionEmoji(emoji, tags);
}
