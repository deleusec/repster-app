import 'package:repster/features/dashboard/domain/workout_session_summary.dart';

/// Aggregated stats over the loaded history (the last 100 sessions).
/// Computed client-side from the summaries — no extra network call.
class HistoryStats {
  const HistoryStats({
    required this.sessionCount,
    required this.totalTonnageKg,
    required this.totalDurationSeconds,
    required this.totalSets,
  });

  factory HistoryStats.fromSessions(List<WorkoutSessionSummary> sessions) {
    var tonnage = 0.0;
    var duration = 0;
    var sets = 0;
    for (final s in sessions) {
      tonnage += s.totalTonnageKg;
      duration += s.durationSeconds;
      sets += s.totalSets;
    }
    return HistoryStats(
      sessionCount: sessions.length,
      totalTonnageKg: tonnage,
      totalDurationSeconds: duration,
      totalSets: sets,
    );
  }

  final int sessionCount;
  final double totalTonnageKg;
  final int totalDurationSeconds;
  final int totalSets;

  static const HistoryStats empty = HistoryStats(
    sessionCount: 0,
    totalTonnageKg: 0,
    totalDurationSeconds: 0,
    totalSets: 0,
  );
}
