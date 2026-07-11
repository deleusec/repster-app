import 'package:repster/features/dashboard/domain/workout_session_summary.dart';

/// Aggregated dashboard stats derived from recent sessions. Computed
/// client-side, so no dedicated query is needed.
class WeeklyStats {
  const WeeklyStats({
    required this.sessionsThisWeek,
    required this.volumeThisWeekKg,
    required this.streakWeeks,
  });

  factory WeeklyStats.fromSessions(
    List<WorkoutSessionSummary> sessions, {
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    final currentWeek = _weekIndex(reference);

    var count = 0;
    var volume = 0.0;
    final trainedWeeks = <int>{};
    for (final s in sessions) {
      final week = _weekIndex(s.startedAt);
      trainedWeeks.add(week);
      if (week == currentWeek) {
        count++;
        volume += s.totalTonnageKg;
      }
    }

    // Streak: start at the current week if trained, otherwise the previous one
    // (a still-empty current week doesn't break the streak), then walk back
    // while consecutive weeks were trained.
    var cursor = trainedWeeks.contains(currentWeek)
        ? currentWeek
        : currentWeek - 1;
    var streak = 0;
    while (trainedWeeks.contains(cursor)) {
      streak++;
      cursor--;
    }

    return WeeklyStats(
      sessionsThisWeek: count,
      volumeThisWeekKg: volume,
      streakWeeks: streak,
    );
  }

  static const empty = WeeklyStats(
    sessionsThisWeek: 0,
    volumeThisWeekKg: 0,
    streakWeeks: 0,
  );

  /// Number of sessions in the current ISO week.
  final int sessionsThisWeek;

  /// Cumulative tonnage for the current week (kg).
  final double volumeThisWeekKg;

  /// Consecutive weeks with at least one session (up to today).
  final int streakWeeks;

  /// Monday→Sunday week index, computed in UTC on the date only so it is
  /// insensitive to timezone and DST.
  /// (1970-01-01 = Thursday; `+3` shifts the week start to Monday.)
  static int _weekIndex(DateTime d) {
    final days = DateTime.utc(
      d.year,
      d.month,
      d.day,
    ).difference(DateTime.utc(1970)).inDays;
    return (days + 3) ~/ 7;
  }
}
