import 'package:flutter_test/flutter_test.dart';

import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/stats/domain/stats_data.dart';
import 'package:repster/features/stats/domain/stats_range.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

final _now = DateTime(2026, 7, 26, 12);

WorkoutSet _set({
  int reps = 10,
  double weight = 80,
  int? seconds,
  bool completed = true,
}) => WorkoutSet(
  id: 'set',
  setNumber: 1,
  targetReps: seconds == null ? reps : 0,
  actualReps: seconds == null ? reps : 0,
  weight: weight,
  completed: completed,
  targetSeconds: seconds,
  actualSeconds: seconds,
);

WorkoutExercise _exercise({
  required List<WorkoutSet> sets,
  String name = 'Bench Press',
  bool isTimeBased = false,
  String? exerciseId,
}) => WorkoutExercise(
  id: 'ex-$name',
  name: name,
  notes: '',
  tempo: '2-0-2-0',
  restTime: 90,
  sets: sets,
  isTimeBased: isTimeBased,
  exerciseId: exerciseId,
);

WorkoutSession _session({
  List<WorkoutExercise> exercises = const [],
  int daysAgo = 1,
  List<MuscleGroup> tags = const [],
  String name = 'Push',
}) => WorkoutSession(
  id: 's-$daysAgo-$name',
  templateId: 't',
  templateName: name,
  startedAt: _now.subtract(Duration(days: daysAgo)),
  duration: 3600,
  exercises: exercises,
  tags: tags,
  notes: '',
);

StatsData _compute(
  List<WorkoutSession> sessions, {
  StatsRange range = StatsRange.last4Weeks,
}) => StatsData.compute(all: sessions, range: range, now: _now);

void main() {
  group('tonnage and time under tension', () {
    test('a loaded hold never counts as tonnage', () {
      final session = _session(
        exercises: [
          _exercise(sets: [_set()]),
          _exercise(
            name: 'Plank',
            isTimeBased: true,
            sets: [_set(seconds: 60, weight: 20)],
          ),
        ],
      );
      // 60 s × 20 kg used to add 1200 to the tonnage, outweighing the 800 of a
      // real working set.
      expect(session.tonnageKg, 800);
      expect(session.timeUnderTensionSec, 60);
    });

    test('the KPIs report the two measures apart', () {
      final data = _compute([
        _session(
          exercises: [
            _exercise(sets: [_set()]),
            _exercise(
              name: 'Plank',
              isTimeBased: true,
              sets: [_set(seconds: 45, weight: 0)],
            ),
          ],
        ),
      ]);
      expect(data.kpis.volumeKg, 800);
      expect(data.kpis.tensionSec, 45);
    });

    test('a hold reports its hold time, not a tonnage', () {
      final hold = _exercise(
        name: 'Plank',
        isTimeBased: true,
        sets: [_set(seconds: 60, weight: 20)],
      );
      expect(hold.tonnage, 0);
      expect(hold.holdTime, 60);
    });
  });

  group('estimatedOneRm', () {
    test('estimates within the reliable rep range', () {
      expect(estimatedOneRm(90, 10), closeTo(120, 0.01));
    });

    test('takes a single at face value instead of inflating it', () {
      // Epley would claim 103.3 kg for a 100 kg single.
      expect(estimatedOneRm(100, 1), 100);
    });

    test('refuses a set too long to estimate from', () {
      // Epley would claim 83 kg here, so an endurance set would read as a
      // strength gain.
      expect(estimatedOneRm(50, 20), 0);
      expect(estimatedOneRm(50, kMaxRepsForOneRm + 1), 0);
      expect(estimatedOneRm(50, kMaxRepsForOneRm), greaterThan(0));
    });

    test('refuses bodyweight or an empty set', () {
      expect(estimatedOneRm(0, 10), 0);
      expect(estimatedOneRm(80, 0), 0);
    });
  });

  group('range scope', () {
    List<WorkoutSession> history() => [
      _session(
        daysAgo: 2,
        exercises: [
          _exercise(sets: [_set(reps: 8, weight: 90)]),
        ],
      ),
      // Beyond the 4-week window.
      _session(
        daysAgo: 120,
        exercises: [
          _exercise(sets: [_set(reps: 5, weight: 140)]),
        ],
      ),
      _session(
        daysAgo: 150,
        exercises: [
          _exercise(sets: [_set(reps: 5, weight: 130)]),
        ],
      ),
    ];

    test('activity counters stay scoped to the range', () {
      final data = _compute(history());
      expect(data.kpis.sessions, 1);
    });

    test('records read the whole history, not the window', () {
      final data = _compute(history());
      expect(data.records.heaviestLift?.weight, 140);
    });

    test('a strength curve keeps its out-of-range points', () {
      final data = _compute(history());
      final bench = data.exercises.firstWhere((e) => e.name == 'Bench Press');
      expect(bench.points, hasLength(3));
    });

    test('a quiet range is not an empty page', () {
      final data = _compute([
        _session(
          daysAgo: 90,
          exercises: [
            _exercise(sets: [_set(reps: 5, weight: 140)]),
          ],
        ),
      ]);
      expect(data.isEmpty, isFalse);
      expect(data.kpis.sessions, 0);
      expect(data.records.heaviestLift?.weight, 140);
    });

    test('no history at all is empty', () {
      expect(_compute([]).isEmpty, isTrue);
    });
  });

  group('strength curve identity', () {
    test('one catalog id is one curve across languages', () {
      // The real case: the same bench press recorded in Italian, then in
      // French. Grouping on the display name gave two curves of one point each,
      // which the ≥2 filter then hid entirely.
      final data = _compute([
        _session(
          daysAgo: 20,
          exercises: [
            _exercise(
              name: 'Panca piana',
              exerciseId: 'bench',
              sets: [_set(reps: 5, weight: 72.5)],
            ),
          ],
        ),
        _session(
          daysAgo: 2,
          exercises: [
            _exercise(
              name: 'Développé couché',
              exerciseId: 'bench',
              sets: [_set(reps: 5, weight: 75)],
            ),
          ],
        ),
      ]);
      expect(data.exercises, hasLength(1));
      expect(data.exercises.single.points, hasLength(2));
    });

    test('the curve is labelled with the most recent name', () {
      final data = _compute([
        _session(
          daysAgo: 20,
          exercises: [
            _exercise(
              name: 'Panca piana',
              exerciseId: 'bench',
              sets: [_set(reps: 5, weight: 72.5)],
            ),
          ],
        ),
        _session(
          daysAgo: 2,
          exercises: [
            _exercise(
              name: 'Développé couché',
              exerciseId: 'bench',
              sets: [_set(reps: 5, weight: 75)],
            ),
          ],
        ),
      ]);
      expect(data.exercises.single.name, 'Développé couché');
    });

    test('two ids stay two curves even under one name', () {
      final data = _compute([
        for (var i = 0; i < 2; i++)
          _session(
            daysAgo: 20 - i,
            exercises: [
              _exercise(
                name: 'Curl',
                exerciseId: 'a',
                sets: [_set(weight: 20)],
              ),
              _exercise(
                name: 'Curl',
                exerciseId: 'b',
                sets: [_set(weight: 30)],
              ),
            ],
          ),
      ]);
      expect(data.exercises, hasLength(2));
    });

    test('without an id it still groups on the normalized name', () {
      final data = _compute([
        _session(
          daysAgo: 20,
          exercises: [
            _exercise(name: 'Machine Dips', sets: [_set(weight: 40)]),
          ],
        ),
        _session(
          daysAgo: 2,
          exercises: [
            _exercise(name: 'machine  dips', sets: [_set(weight: 45)]),
          ],
        ),
      ]);
      expect(data.exercises, hasLength(1));
      expect(data.exercises.single.points, hasLength(2));
    });
  });

  group('muscle load', () {
    test('counts the sessions tagged with each group', () {
      final data = _compute([
        _session(daysAgo: 2, tags: [MuscleGroup.chest, MuscleGroup.triceps]),
        _session(daysAgo: 5, name: 'Push 2', tags: [MuscleGroup.chest]),
      ]);
      int sessionsOf(MuscleGroup g) =>
          data.muscleLoads.firstWhere((l) => l.group == g).sessions;
      expect(sessionsOf(MuscleGroup.chest), 2);
      expect(sessionsOf(MuscleGroup.triceps), 1);
    });

    test('keeps a group the exercises alone would have dropped', () {
      // The real reason this reads tags: `exercises.muscle_groups` is empty for
      // every personal exercise, which is most of what people actually log.
      final data = _compute([
        _session(
          tags: [MuscleGroup.abs],
          exercises: [
            _exercise(name: 'Crunch poulie haute', sets: [_set()]),
          ],
        ),
      ]);
      expect(data.muscleLoads.map((l) => l.group), [MuscleGroup.abs]);
    });

    test('reports how long since a group was last trained', () {
      final data = _compute([
        _session(daysAgo: 3, tags: [MuscleGroup.back]),
      ]);
      expect(data.muscleLoads.single.daysSinceLast, 3);
    });

    test('keeps a group out of range, at zero sessions', () {
      final data = _compute([
        _session(daysAgo: 2, tags: [MuscleGroup.chest]),
        _session(daysAgo: 200, name: 'Legs', tags: [MuscleGroup.quads]),
      ]);
      final quads = data.muscleLoads.firstWhere(
        (l) => l.group == MuscleGroup.quads,
      );
      expect(quads.sessions, 0);
      expect(quads.daysSinceLast, 200);
    });
  });

  group('weekly volume across a daylight-saving change', () {
    // Winter time starts 2026-10-25. Stepping weeks back with Durations used
    // to land the earlier Mondays at 01:00, so their tonnage was never found
    // and the chart read zero before the change. Only observable under a DST
    // timezone.
    test('keeps the tonnage of the weeks before the change', () {
      final now = DateTime(2026, 11, 7, 10);
      final sessions = [
        for (final day in [
          DateTime(2026, 10, 14, 18),
          DateTime(2026, 10, 20, 7),
          DateTime(2026, 11, 3, 19),
        ])
          WorkoutSession(
            id: 's-$day',
            templateId: 't',
            templateName: 'Push',
            startedAt: day,
            duration: 3600,
            exercises: [
              _exercise(sets: [_set(weight: 50)]),
            ],
            tags: const [],
            notes: '',
          ),
      ];
      final stats = StatsData.compute(
        all: sessions,
        range: StatsRange.last4Weeks,
        now: now,
      );
      final loaded = stats.weeklyVolume.where((w) => w.tonnageKg > 0);
      expect(loaded.map((w) => w.weekStart), [
        DateTime(2026, 10, 12),
        DateTime(2026, 10, 19),
        DateTime(2026, 11, 2),
      ]);
    });
  });

  group('strength trend', () {
    ExerciseProgress progress(List<(int daysAgo, double oneRm)> points) =>
        ExerciseProgress(
          name: 'Bench Press',
          points: [
            for (final (daysAgo, oneRm) in points.reversed)
              ExercisePoint(
                date: _now.subtract(Duration(days: daysAgo)),
                estimatedOneRm: oneRm,
                topWeight: oneRm,
                repsAtTop: 5,
              ),
          ],
        );

    test('says nothing on a single session', () {
      final p = progress([(1, 100)]);
      expect(p.monthlyRate, isNull);
      expect(p.trend, isNull);
    });

    test('says nothing on two sessions in the same week', () {
      final p = progress([(1, 100), (4, 95)]);
      expect(p.monthlyRate, isNull);
      expect(p.trend, isNull);
    });

    test('reads a rising slope as progress', () {
      final p = progress([(1, 110), (15, 105), (29, 100)]);
      expect(p.monthlyRate, greaterThan(0));
      expect(p.trend, StrengthTrend.progressing);
      expect(p.sessionsSinceBest, 0);
    });

    test('reads a falling slope as losing ground', () {
      final p = progress([(1, 90), (15, 95), (29, 100)]);
      expect(p.monthlyRate, lessThan(0));
      expect(p.trend, StrengthTrend.regressing);
    });

    test('a flat run after the best is a plateau, not a regression', () {
      final p = progress([(1, 100), (8, 100), (15, 100), (36, 100)]);
      expect(p.sessionsSinceBest, greaterThanOrEqualTo(kPlateauSessions));
      expect(p.trend, StrengthTrend.plateau);
    });

    test('one flat session is not a plateau', () {
      final p = progress([(1, 105), (15, 105), (29, 100)]);
      expect(p.sessionsSinceBest, lessThan(kPlateauSessions));
      expect(p.trend, StrengthTrend.progressing);
    });

    test('a slope is not decided by the two endpoints alone', () {
      // One lucky last session over a flat run must not read as progress.
      final p = progress([
        (1, 101),
        (8, 100),
        (15, 100),
        (22, 100),
        (29, 100),
        (36, 100),
      ]);
      expect(p.monthlyRate!.abs(), lessThan(0.01));
    });

    test('reports the best 1RM regardless of position', () {
      final p = progress([(1, 95), (15, 120), (29, 100)]);
      expect(p.bestOneRm, 120);
    });
  });
}
