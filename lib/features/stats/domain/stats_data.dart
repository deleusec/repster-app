import 'dart:math' as math;

import 'package:repster/core/exercises/exercise_name_key.dart';
import 'package:repster/features/dashboard/domain/consistency.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/stats/domain/stats_range.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

/// Reps past which Epley stops being a strength estimate. At 20 reps it turns
/// 50 kg into 83 kg, so an endurance set would read as a strength gain and the
/// curve would rise while the loads fall.
const int kMaxRepsForOneRm = 12;

/// Estimated 1RM via the Epley formula. Returns 0 when not applicable: no
/// load, no reps, or a set too long to estimate from
/// ([kMaxRepsForOneRm]).
double estimatedOneRm(double weight, int reps) {
  if (weight <= 0 || reps <= 0 || reps > kMaxRepsForOneRm) return 0;
  // Epley is a fit for multi-rep sets and overshoots a single by 3.3 %. A
  // single is not an estimate — it is the measurement.
  if (reps == 1) return weight;
  return weight * (1 + reps / 30);
}

/// KPIs for the selected range, with the change vs the previous window of the
/// same length (`null` when not computable: "All" range or no data).
class StatKpis {
  const StatKpis({
    required this.sessions,
    required this.volumeKg,
    required this.sets,
    required this.avgDurationSec,
    this.tensionSec = 0,
    this.sessionsDelta,
    this.volumeDelta,
    this.setsDelta,
    this.durationDelta,
  });

  final int sessions;

  /// Tonnage in kg (`reps × load`). Holds are in [tensionSec], not here.
  final double volumeKg;
  final int sets;
  final int avgDurationSec;

  /// Seconds held on time-based exercises. Deliberately without a delta:
  /// more time under tension is not self-evidently better.
  final int tensionSec;
  final double? sessionsDelta;
  final double? volumeDelta;
  final double? setsDelta;
  final double? durationDelta;
}

/// Weekly aggregated volume (tonnage), for the trend histogram.
class WeeklyVolume {
  const WeeklyVolume({
    required this.weekStart,
    required this.tonnageKg,
    this.isInProgress = false,
  });

  final DateTime weekStart;
  final double tonnageKg;

  /// The running week. Its bar is not a drop — it is unfinished, and drawing it
  /// like the others made every Monday look like a collapse.
  final bool isInProgress;
}

/// Load per muscle group: session count within the range + time since the
/// last workout (across all ranges).
///
/// Counted from the sessions' muscle tags. Crediting the exercises actually
/// performed would be finer, but `exercises.muscle_groups` is only filled for
/// the certified catalog — four fifths of a real user's sets run through
/// personal exercises, which nothing in the app can tag yet. Tags cover
/// everything, and they are the same source the profile and history read, so
/// the three screens agree.
class MuscleLoad {
  const MuscleLoad({
    required this.group,
    required this.sessions,
    required this.daysSinceLast,
  });

  final MuscleGroup group;

  /// Sessions in range tagged with this group.
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

/// Sessions without beating the best estimated 1RM before we call it a plateau.
/// Three is deliberately not two: one flat session is normal variance.
const int kPlateauSessions = 3;

/// Reading of an exercise's recent trend.
enum StrengthTrend { progressing, plateau, regressing }

/// Progression time series for a given exercise.
class ExerciseProgress {
  const ExerciseProgress({required this.name, required this.points});

  final String name;

  /// Chronological, oldest first.
  final List<ExercisePoint> points;

  int get sessionCount => points.length;

  /// Change in estimated 1RM per 30 days, as a fraction (`0.032` = +3.2 %/month)
  /// — `null` until there are two points spread over at least a week.
  ///
  /// A least-squares slope rather than first-vs-last: one lucky session at
  /// either end should not define a trend.
  double? get monthlyRate {
    if (points.length < 2) return null;
    final t0 = points.first.date;
    final xs = [
      for (final p in points) p.date.difference(t0).inDays.toDouble(),
    ];
    final span = xs.last - xs.first;
    if (span < 7) return null;

    final ys = [for (final p in points) p.estimatedOneRm];
    final meanX = xs.reduce((a, b) => a + b) / xs.length;
    final meanY = ys.reduce((a, b) => a + b) / ys.length;
    var num = 0.0;
    var den = 0.0;
    for (var i = 0; i < xs.length; i++) {
      num += (xs[i] - meanX) * (ys[i] - meanY);
      den += (xs[i] - meanX) * (xs[i] - meanX);
    }
    if (den == 0 || meanY <= 0) return null;
    return (num / den) * 30 / meanY;
  }

  /// Best estimated 1RM ever recorded on this exercise.
  double get bestOneRm =>
      points.fold(0, (m, p) => p.estimatedOneRm > m ? p.estimatedOneRm : m);

  /// Sessions since the best 1RM was set. `0` means the last session set it.
  int get sessionsSinceBest {
    var best = 0.0;
    var index = -1;
    for (var i = 0; i < points.length; i++) {
      if (points[i].estimatedOneRm > best) {
        best = points[i].estimatedOneRm;
        index = i;
      }
    }
    return index < 0 ? 0 : points.length - 1 - index;
  }

  /// `null` while there is not enough history to say anything honest.
  StrengthTrend? get trend {
    final rate = monthlyRate;
    if (rate == null) return null;
    if (sessionsSinceBest >= kPlateauSessions) {
      // Losing ground and stalling are different situations: only the first
      // deserves the word.
      return rate < -0.02 ? StrengthTrend.regressing : StrengthTrend.plateau;
    }
    if (rate <= -0.02) return StrengthTrend.regressing;
    return StrengthTrend.progressing;
  }
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
    required this.weeklyVolume,
    required this.muscleLoads,
    required this.exercises,
    required this.records,
    this.hasHistory = false,
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

    // Only a total absence of history is empty. A quiet month zeroes the
    // activity counters but must still show the strength curves and records,
    // which no longer depend on the range.
    if (all.isEmpty) return StatsData.empty;
    final current = all.where((s) => inCurrent(s.startedAt)).toList();
    final previous = all.where((s) => inPrevious(s.startedAt)).toList();

    // Activity is scoped by the range; strength is not. A four-week window
    // leaves a strength curve with two or three points, and drops an exercise
    // entirely below two sessions — while "heaviest lift" would silently mean
    // "heaviest this month". Curves and records read the whole history.
    return StatsData(
      kpis: _kpis(current, previous, hasWindow: window != null),
      weeklyVolume: _weeklyVolume(current, window, now),
      muscleLoads: _muscleLoads(all, current, now),
      exercises: _exerciseProgress(all),
      records: _records(
        all,
        Consistency.longestStreak([for (final s in all) s.startedAt]),
      ),
      hasHistory: true,
    );
  }

  final StatKpis kpis;
  final List<WeeklyVolume> weeklyVolume;
  final List<MuscleLoad> muscleLoads;
  final List<ExerciseProgress> exercises;
  final Records records;

  /// Whether the user has any completed session at all — as opposed to none
  /// *in the selected range*, which is a normal state with real records.
  final bool hasHistory;

  bool get isEmpty => !hasHistory;

  static const StatsData empty = StatsData(
    kpis: StatKpis(sessions: 0, volumeKg: 0, sets: 0, avgDurationSec: 0),
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
    double vol(List<WorkoutSession> l) => l.fold(0, (a, s) => a + s.tonnageKg);
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
      tensionSec: cur.fold(0, (a, s) => a + s.timeUnderTensionSec),
      sessionsDelta: delta(sessions, prevSessions),
      volumeDelta: delta(vol(cur), vol(prev)),
      setsDelta: delta(setsOf(cur), setsOf(prev)),
      durationDelta: delta(avgDur, prevAvgDur),
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
      byWeek.update(wk, (v) => v + s.tonnageKg, ifAbsent: () => s.tonnageKg);
    }
    final weeks = window == null
        ? 12
        : math.min(14, (window.inDays / 7).ceil());
    final thisWeek = _mondayOf(now);
    return [
      for (var i = weeks - 1; i >= 0; i--)
        () {
          final start = thisWeek.subtract(Duration(days: 7 * i));
          return WeeklyVolume(
            weekStart: start,
            tonnageKg: byWeek[start] ?? 0,
            isInProgress: i == 0,
          );
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

  /// Strength curve per exercise, over the **whole** history: a range-scoped
  /// curve has too few points to read, and an exercise disappears entirely
  /// below two sessions in the window.
  static List<ExerciseProgress> _exerciseProgress(List<WorkoutSession> all) {
    final sortedAsc = [...all]
      ..sort((a, b) => a.startedAt.compareTo(b.startedAt));
    // Keyed by exercise identity, not by display name: one bench press is one
    // curve whatever language it was recorded in.
    final byExercise = <String, List<ExercisePoint>>{};
    final labels = <String, String>{};
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
        final key = exerciseIdentityKey(
          name: ex.name,
          exerciseId: ex.exerciseId,
        );
        (byExercise[key] ??= []).add(
          ExercisePoint(
            date: s.startedAt,
            estimatedOneRm: bestE,
            topWeight: topW,
            repsAtTop: topReps,
          ),
        );
        // Sessions are walked oldest first, so the most recent spelling labels
        // the curve. Catalog exercises are already named identically across
        // rows; this only decides between spellings of a hand-typed one.
        labels[key] = ex.name;
      }
    }
    final progress = [
      for (final e in byExercise.entries)
        if (e.value.length >= 2)
          ExerciseProgress(name: labels[e.key] ?? '', points: e.value),
    ]..sort((a, b) => b.sessionCount.compareTo(a.sessionCount));
    return progress;
  }

  /// Records over the **whole** history: a range-scoped "heaviest lift" is a
  /// monthly maximum wearing the word record.
  static Records _records(List<WorkoutSession> all, int bestStreak) {
    BestSession? best;
    HeaviestLift? heaviest;
    BestOneRm? bestRm;
    for (final s in all) {
      final t = s.tonnageKg;
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

  static DateTime _mondayOf(DateTime d) {
    final day = DateTime(d.year, d.month, d.day);
    return day.subtract(Duration(days: day.weekday - 1));
  }
}
