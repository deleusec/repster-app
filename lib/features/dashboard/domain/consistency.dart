import 'dart:math' as math;

/// Number of weeks shown by the consistency heatmap (~4 months).
const int kHeatmapWeeks = 18;

/// Training consistency: active days, frequency, streaks and a daily activity
/// grid (heatmap). Lives on the dashboard — regularity is something you check
/// when you open the app, not while reading your stats.
///
/// Built from session dates alone, so it needs a single-column read rather than
/// the full history.
class Consistency {
  const Consistency({
    required this.trainingDays,
    required this.sessionsPerWeek,
    required this.currentStreakWeeks,
    required this.bestStreakWeeks,
    required this.dayCounts,
  });

  /// [dates] are session start dates, in any order. Only those inside the
  /// heatmap window are considered.
  factory Consistency.fromDates(List<DateTime> dates, {DateTime? now}) {
    final reference = now ?? DateTime.now();
    final today = dayKey(reference);
    final start = mondayOf(
      today,
    ).subtract(const Duration(days: 7 * (kHeatmapWeeks - 1)));

    final dayCounts = <DateTime, int>{};
    DateTime? earliest;
    for (final date in dates) {
      final key = dayKey(date);
      if (key.isBefore(start)) continue;
      dayCounts.update(key, (v) => v + 1, ifAbsent: () => 1);
      if (earliest == null || key.isBefore(earliest)) earliest = key;
    }

    final sessions = dayCounts.values.fold(0, (a, b) => a + b);
    // Averaged over the weeks the user has actually been around: a first week
    // of training should not read as 0.2 sessions a week.
    final spanDays = earliest == null
        ? 0
        : today.difference(earliest).inDays + 1;
    final weeks = math.max(1, spanDays / 7);

    final weekIndexes = <int>{for (final d in dates) weekIndex(d)};
    return Consistency(
      trainingDays: dayCounts.length,
      sessionsPerWeek: sessions == 0 ? 0 : sessions / weeks,
      currentStreakWeeks: _currentStreak(weekIndexes, reference),
      bestStreakWeeks: longestStreak(dates),
      dayCounts: dayCounts,
    );
  }

  static const empty = Consistency(
    trainingDays: 0,
    sessionsPerWeek: 0,
    currentStreakWeeks: 0,
    bestStreakWeeks: 0,
    dayCounts: {},
  );

  final int trainingDays;
  final double sessionsPerWeek;
  final int currentStreakWeeks;
  final int bestStreakWeeks;

  /// Local midnight → session count for that day (within the heatmap window).
  final Map<DateTime, int> dayCounts;

  /// Longest run of consecutive weeks with at least one session, all time.
  /// Exposed on its own because the stats page reports it as a record.
  static int longestStreak(List<DateTime> dates) {
    final weeks = <int>{for (final d in dates) weekIndex(d)}.toList()..sort();
    var best = 0;
    var run = 0;
    int? previous;
    for (final w in weeks) {
      run = (previous != null && w == previous + 1) ? run + 1 : 1;
      best = math.max(best, run);
      previous = w;
    }
    return best;
  }

  /// A still-empty current week does not break the streak: we probe last week
  /// before giving up.
  static int _currentStreak(Set<int> weeks, DateTime now) {
    final current = weekIndex(now);
    int? probe;
    if (weeks.contains(current)) {
      probe = current;
    } else if (weeks.contains(current - 1)) {
      probe = current - 1;
    }
    if (probe == null) return 0;
    var count = 0;
    var w = probe;
    while (weeks.contains(w)) {
      count++;
      w--;
    }
    return count;
  }

  static DateTime dayKey(DateTime d) => DateTime(d.year, d.month, d.day);

  static DateTime mondayOf(DateTime d) {
    final day = dayKey(d);
    return day.subtract(Duration(days: day.weekday - 1));
  }

  /// Monday→Sunday week index, computed in UTC on the date only so it is
  /// insensitive to timezone and DST.
  /// (1970-01-01 = Thursday; `+3` shifts the week start to Monday.)
  static int weekIndex(DateTime d) {
    final days = DateTime.utc(
      d.year,
      d.month,
      d.day,
    ).difference(DateTime.utc(1970)).inDays;
    return (days + 3) ~/ 7;
  }
}
