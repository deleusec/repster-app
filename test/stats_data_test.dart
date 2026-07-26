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
  List<MuscleGroup> muscles = const [],
}) => WorkoutExercise(
  id: 'ex-$name',
  name: name,
  notes: '',
  tempo: '2-0-2-0',
  restTime: 90,
  sets: sets,
  isTimeBased: isTimeBased,
  muscleGroups: muscles,
);

WorkoutSession _session({
  required List<WorkoutExercise> exercises,
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

  group('muscle load', () {
    test('credits the primary muscle fully and the others by half', () {
      final data = _compute([
        _session(
          exercises: [
            _exercise(
              sets: [_set(), _set()],
              muscles: [
                MuscleGroup.chest,
                MuscleGroup.triceps,
                MuscleGroup.shoulders,
              ],
            ),
          ],
        ),
      ]);
      double setsOf(MuscleGroup g) =>
          data.muscleLoads.firstWhere((l) => l.group == g).weightedSets;
      expect(setsOf(MuscleGroup.chest), 2);
      expect(setsOf(MuscleGroup.triceps), 1);
      expect(setsOf(MuscleGroup.shoulders), 1);
    });

    test('ignores the template tags and reads the exercises performed', () {
      final data = _compute([
        _session(
          // The template claims legs; nothing in the session works them.
          tags: [MuscleGroup.quads, MuscleGroup.glutes],
          exercises: [
            _exercise(sets: [_set()], muscles: [MuscleGroup.chest]),
          ],
        ),
      ]);
      expect(data.muscleLoads.map((l) => l.group), [MuscleGroup.chest]);
    });

    test('counts uncompleted sets for nothing', () {
      final data = _compute([
        _session(
          exercises: [
            _exercise(
              sets: [_set(), _set(completed: false)],
              muscles: [MuscleGroup.back],
            ),
          ],
        ),
      ]);
      expect(data.muscleLoads.single.weightedSets, 1);
    });

    test('turns the count into a weekly rate over the range', () {
      // 24 credited sets across the 4-week window → 6 a week, under target.
      final data = _compute([
        for (var w = 0; w < 4; w++)
          _session(
            daysAgo: 1 + 7 * w,
            name: 'Push $w',
            exercises: [
              _exercise(
                sets: [_set(), _set(), _set(), _set(), _set(), _set()],
                muscles: [MuscleGroup.chest],
              ),
            ],
          ),
      ]);
      final chest = data.muscleLoads.single;
      expect(chest.weightedSets, 24);
      expect(chest.setsPerWeek, closeTo(6, 0.01));
      expect(chest.status, MuscleLoadStatus.under);
    });

    test('surfaces sets it could not attribute', () {
      final data = _compute([
        _session(
          exercises: [
            _exercise(sets: [_set()], muscles: [MuscleGroup.chest]),
            _exercise(name: 'Machin perso', sets: [_set(), _set()]),
          ],
        ),
      ]);
      expect(data.unattributedSets, 2);
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
