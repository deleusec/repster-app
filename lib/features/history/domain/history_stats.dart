import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

/// Aggregated stats over the loaded history (the last 100 sessions).
/// Computed client-side from the summaries — no extra network call.
class HistoryStats {
  const HistoryStats({
    required this.sessionCount,
    required this.totalTonnageKg,
    required this.totalDurationSeconds,
    required this.totalSets,
    required this.topGroup,
  });

  factory HistoryStats.fromSessions(List<WorkoutSessionSummary> sessions) {
    var tonnage = 0.0;
    var duration = 0;
    var sets = 0;
    final counts = <MuscleGroup, int>{};
    for (final s in sessions) {
      tonnage += s.totalTonnageKg;
      duration += s.durationSeconds;
      sets += s.totalSets;
      for (final g in s.tags) {
        counts[g] = (counts[g] ?? 0) + 1;
      }
    }

    MuscleGroup? top;
    var best = 0;
    for (final entry in counts.entries) {
      if (entry.value > best) {
        best = entry.value;
        top = entry.key;
      }
    }

    return HistoryStats(
      sessionCount: sessions.length,
      totalTonnageKg: tonnage,
      totalDurationSeconds: duration,
      totalSets: sets,
      topGroup: top,
    );
  }

  final int sessionCount;
  final double totalTonnageKg;
  final int totalDurationSeconds;
  final int totalSets;
  final MuscleGroup? topGroup;

  static const HistoryStats empty = HistoryStats(
    sessionCount: 0,
    totalTonnageKg: 0,
    totalDurationSeconds: 0,
    totalSets: 0,
    topGroup: null,
  );
}
