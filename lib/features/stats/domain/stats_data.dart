import 'dart:math' as math;

import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/stats/domain/stats_range.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

/// Estimated 1RM via the Epley formula. Returns 0 when not applicable
/// (zero weight or reps).
double estimatedOneRm(double weight, int reps) {
  if (weight <= 0 || reps <= 0) return 0;
  return weight * (1 + reps / 30);
}

/// Number of weeks shown by the consistency heatmap (~4 months).
const int kHeatmapWeeks = 18;

/// KPIs for the selected range, with the change vs the previous window of the
/// same length (`null` when not computable: "All" range or no data).
class StatKpis {
  const StatKpis({
    required this.sessions,
    required this.volumeKg,
    required this.sets,
    required this.avgDurationSec,
    this.sessionsDelta,
    this.volumeDelta,
    this.setsDelta,
    this.durationDelta,
  });

  final int sessions;
  final double volumeKg;
  final int sets;
  final int avgDurationSec;
  final double? sessionsDelta;
  final double? volumeDelta;
  final double? setsDelta;
  final double? durationDelta;
}

/// Training consistency: active days, frequency, streaks and a daily activity
/// grid (heatmap).
class Consistency {
  const Consistency({
    required this.trainingDays,
    required this.sessionsPerWeek,
    required this.currentStreakWeeks,
    required this.bestStreakWeeks,
    required this.dayCounts,
  });

  final int trainingDays;
  final double sessionsPerWeek;
  final int currentStreakWeeks;
  final int bestStreakWeeks;

  /// Local midnight → session count for that day (within the heatmap window).
  final Map<DateTime, int> dayCounts;
}

/// Weekly aggregated volume (tonnage), for the trend histogram.
class WeeklyVolume {
  const WeeklyVolume({required this.weekStart, required this.tonnageKg});

  final DateTime weekStart;
  final double tonnageKg;
}

/// Load per muscle group: session count within the range + time since the
/// last workout (across all ranges).
class MuscleLoad {
  const MuscleLoad({
    required this.group,
    required this.sessions,
    required this.daysSinceLast,
  });

  final MuscleGroup group;
  final int sessions;
  final int? daysSinceLast;
}

/// One progression point for an exercise (best set of a session).
class ExercisePoint {
  const ExercisePoint({
    required this.date,
    required this.estimatedOneRm,
    required this.topWeight,
    required this.repsAtTop,
  });

  final DateTime date;
  final double estimatedOneRm;
  final double topWeight;
  final int repsAtTop;
}

/// Progression time series for a given exercise.
class ExerciseProgress {
  const ExerciseProgress({required this.name, required this.points});

  final String name;
  final List<ExercisePoint> points;

  int get sessionCount => points.length;
}

class BestSession {
  const BestSession({
    required this.name,
    required this.date,
    required this.tonnageKg,
  });

  final String name;
  final DateTime date;
  final double tonnageKg;
}

class HeaviestLift {
  const HeaviestLift({
    required this.exercise,
    required this.weight,
    required this.reps,
    required this.date,
  });

  final String exercise;
  final double weight;
  final int reps;
  final DateTime date;
}

class BestOneRm {
  const BestOneRm({
    required this.exercise,
    required this.oneRm,
    required this.date,
  });

  final String exercise;
  final double oneRm;
  final DateTime date;
}

/// Highlights / records for the range.
class Records {
  const Records({
    this.bestSession,
    this.heaviestLift,
    this.bestOneRm,
    this.bestStreakWeeks = 0,
  });

  final BestSession? bestSession;
  final HeaviestLift? heaviestLift;
  final BestOneRm? bestOneRm;
  final int bestStreakWeeks;

  bool get isEmpty =>
      bestSession == null && heaviestLift == null && bestOneRm == null;
}

/// Full aggregate for the Stats page, computed client-side from the complete
/// sessions (exercises + sets).
class StatsData {
  const StatsData({
    required this.kpis,
    required this.consistency,
    required this.weeklyVolume,
    required this.muscleLoads,
    required this.exercises,
    required this.records,
  });

  factory StatsData.compute({
    required List<WorkoutSession> all,
    required StatsRange range,
    required DateTime now,
  }) {
    final window = range.window;
    bool inCurrent(DateTime d) => window == null || now.difference(d) <= window;
    bool inPrevious(DateTime d) {
      if (window == null) return false;
      final age = now.difference(d);
      return age > window && age <= window * 2;
    }

    final current = all.where((s) => inCurrent(s.startedAt)).toList();
    if (current.isEmpty) return StatsData.empty;
    final previous = all.where((s) => inPrevious(s.startedAt)).toList();

    return StatsData(
      kpis: _kpis(current, previous, hasWindow: window != null),
      consistency: _consistency(all, current, window, now),
      weeklyVolume: _weeklyVolume(current, window, now),
      muscleLoads: _muscleLoads(all, current, now),
      exercises: _exerciseProgress(current),
      records: _records(current, _bestStreak(all)),
    );
  }

  final StatKpis kpis;
  final Consistency consistency;
  final List<WeeklyVolume> weeklyVolume;
  final List<MuscleLoad> muscleLoads;
  final List<ExerciseProgress> exercises;
  final Records records;

  bool get isEmpty => kpis.sessions == 0;

  static const StatsData empty = StatsData(
    kpis: StatKpis(sessions: 0, volumeKg: 0, sets: 0, avgDurationSec: 0),
    consistency: Consistency(
      trainingDays: 0,
      sessionsPerWeek: 0,
      currentStreakWeeks: 0,
      bestStreakWeeks: 0,
      dayCounts: {},
    ),
    weeklyVolume: [],
    muscleLoads: [],
    exercises: [],
    records: Records(),
  );

  // ── Internal aggregations ──────────────────────────────────────────────

  static StatKpis _kpis(
    List<WorkoutSession> cur,
    List<WorkoutSession> prev, {
    required bool hasWindow,
  }) {
    double vol(List<WorkoutSession> l) =>
        l.fold(0, (a, s) => a + s.totalTonnage);
    int setsOf(List<WorkoutSession> l) =>
        l.fold(0, (a, s) => a + s.completedSets);
    int durOf(List<WorkoutSession> l) => l.fold(0, (a, s) => a + s.duration);

    final sessions = cur.length;
    final avgDur = sessions == 0 ? 0 : (durOf(cur) / sessions).round();
    final hasPrev = hasWindow && prev.isNotEmpty;

    double? delta(num c, num p) {
      if (!hasPrev || p == 0) return null;
      return (c - p) / p;
    }

    final prevSessions = prev.length;
    final prevAvgDur = prevSessions == 0
        ? 0
        : (durOf(prev) / prevSessions).round();

    return StatKpis(
      sessions: sessions,
      volumeKg: vol(cur),
      sets: setsOf(cur),
      avgDurationSec: avgDur,
      sessionsDelta: delta(sessions, prevSessions),
      volumeDelta: delta(vol(cur), vol(prev)),
      setsDelta: delta(setsOf(cur), setsOf(prev)),
      durationDelta: delta(avgDur, prevAvgDur),
    );
  }

  static Consistency _consistency(
    List<WorkoutSession> all,
    List<WorkoutSession> current,
    Duration? window,
    DateTime now,
  ) {
    final heatStart = _mondayOf(
      now,
    ).subtract(const Duration(days: 7 * (kHeatmapWeeks - 1)));
    final dayCounts = <DateTime, int>{};
    for (final s in all) {
      final k = _dayKey(s.startedAt);
      if (k.isBefore(heatStart)) continue;
      dayCounts.update(k, (v) => v + 1, ifAbsent: () => 1);
    }

    final days = <DateTime>{for (final s in current) _dayKey(s.startedAt)};
    final earliest = current.fold<DateTime>(
      now,
      (m, s) => s.startedAt.isBefore(m) ? s.startedAt : m,
    );
    final spanDays = window == null
        ? now.difference(earliest).inDays + 1
        : window.inDays;
    final weeksInRange = spanDays / 7;
    final sessionsPerWeek = weeksInRange < 1
        ? current.length.toDouble()
        : current.length / weeksInRange;

    return Consistency(
      trainingDays: days.length,
      sessionsPerWeek: sessionsPerWeek,
      currentStreakWeeks: _currentStreak(all, now),
      bestStreakWeeks: _bestStreak(all),
      dayCounts: dayCounts,
    );
  }

  static List<WeeklyVolume> _weeklyVolume(
    List<WorkoutSession> current,
    Duration? window,
    DateTime now,
  ) {
    final byWeek = <DateTime, double>{};
    for (final s in current) {
      final wk = _mondayOf(s.startedAt);
      byWeek.update(
        wk,
        (v) => v + s.totalTonnage,
        ifAbsent: () => s.totalTonnage,
      );
    }
    final weeks = window == null
        ? 12
        : math.min(14, (window.inDays / 7).ceil());
    final thisWeek = _mondayOf(now);
    return [
      for (var i = weeks - 1; i >= 0; i--)
        () {
          final start = thisWeek.subtract(Duration(days: 7 * i));
          return WeeklyVolume(weekStart: start, tonnageKg: byWeek[start] ?? 0);
        }(),
    ];
  }

  static List<MuscleLoad> _muscleLoads(
    List<WorkoutSession> all,
    List<WorkoutSession> current,
    DateTime now,
  ) {
    final groups = <MuscleGroup>{for (final s in all) ...s.tags};
    final lastByGroup = <MuscleGroup, DateTime>{};
    for (final s in all) {
      for (final g in s.tags) {
        final cur = lastByGroup[g];
        if (cur == null || s.startedAt.isAfter(cur)) {
          lastByGroup[g] = s.startedAt;
        }
      }
    }
    final sessByGroup = <MuscleGroup, int>{};
    for (final s in current) {
      for (final g in s.tags) {
        sessByGroup.update(g, (v) => v + 1, ifAbsent: () => 1);
      }
    }
    final loads =
        [
          for (final g in groups)
            MuscleLoad(
              group: g,
              sessions: sessByGroup[g] ?? 0,
              daysSinceLast: lastByGroup[g] == null
                  ? null
                  : now.difference(lastByGroup[g]!).inDays,
            ),
        ]..sort((a, b) {
          final c = b.sessions.compareTo(a.sessions);
          if (c != 0) return c;
          return (a.daysSinceLast ?? 1 << 30).compareTo(
            b.daysSinceLast ?? 1 << 30,
          );
        });
    return loads;
  }

  static List<ExerciseProgress> _exerciseProgress(
    List<WorkoutSession> current,
  ) {
    final sortedAsc = [...current]
      ..sort((a, b) => a.startedAt.compareTo(b.startedAt));
    final byName = <String, List<ExercisePoint>>{};
    for (final s in sortedAsc) {
      for (final ex in s.exercises) {
        if (ex.isTimeBased) continue;
        var bestE = 0.0;
        var topW = 0.0;
        var topReps = 0;
        for (final set in ex.sets) {
          if (!set.completed) continue;
          final w = set.weight;
          final r = set.actualReps;
          if (w <= 0 || r <= 0) continue;
          final e = estimatedOneRm(w, r);
          if (e > bestE) bestE = e;
          if (w > topW) {
            topW = w;
            topReps = r;
          }
        }
        if (bestE <= 0) continue;
        (byName[ex.name] ??= []).add(
          ExercisePoint(
            date: s.startedAt,
            estimatedOneRm: bestE,
            topWeight: topW,
            repsAtTop: topReps,
          ),
        );
      }
    }
    final progress = [
      for (final e in byName.entries)
        if (e.value.length >= 2) ExerciseProgress(name: e.key, points: e.value),
    ]..sort((a, b) => b.sessionCount.compareTo(a.sessionCount));
    return progress;
  }

  static Records _records(List<WorkoutSession> current, int bestStreak) {
    BestSession? best;
    HeaviestLift? heaviest;
    BestOneRm? bestRm;
    for (final s in current) {
      final t = s.totalTonnage;
      if (best == null || t > best.tonnageKg) {
        best = BestSession(
          name: s.templateName,
          date: s.startedAt,
          tonnageKg: t,
        );
      }
      for (final ex in s.exercises) {
        if (ex.isTimeBased) continue;
        for (final set in ex.sets) {
          if (!set.completed) continue;
          final w = set.weight;
          final r = set.actualReps;
          if (w <= 0 || r <= 0) continue;
          if (heaviest == null || w > heaviest.weight) {
            heaviest = HeaviestLift(
              exercise: ex.name,
              weight: w,
              reps: r,
              date: s.startedAt,
            );
          }
          final e = estimatedOneRm(w, r);
          if (bestRm == null || e > bestRm.oneRm) {
            bestRm = BestOneRm(exercise: ex.name, oneRm: e, date: s.startedAt);
          }
        }
      }
    }
    return Records(
      bestSession: best,
      heaviestLift: heaviest,
      bestOneRm: bestRm,
      bestStreakWeeks: bestStreak,
    );
  }

  static int _currentStreak(List<WorkoutSession> all, DateTime now) {
    final weeks = <int>{for (final s in all) _weekIndex(s.startedAt)};
    final cw = _weekIndex(now);
    int? probe;
    if (weeks.contains(cw)) {
      probe = cw;
    } else if (weeks.contains(cw - 1)) {
      probe = cw - 1;
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

  static int _bestStreak(List<WorkoutSession> all) {
    final weeks = <int>{for (final s in all) _weekIndex(s.startedAt)}.toList()
      ..sort();
    var best = 0;
    var run = 0;
    int? prev;
    for (final w in weeks) {
      run = (prev != null && w == prev + 1) ? run + 1 : 1;
      best = math.max(best, run);
      prev = w;
    }
    return best;
  }

  static DateTime _dayKey(DateTime d) => DateTime(d.year, d.month, d.day);

  static DateTime _mondayOf(DateTime d) {
    final day = DateTime(d.year, d.month, d.day);
    return day.subtract(Duration(days: day.weekday - 1));
  }

  static int _weekIndex(DateTime d) {
    final utc = DateTime.utc(d.year, d.month, d.day);
    return (utc.difference(DateTime.utc(1970)).inDays + 3) ~/ 7;
  }
}
