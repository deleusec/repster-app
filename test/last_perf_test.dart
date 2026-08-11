import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/session/presentation/widgets/exercise_meta.dart';

WorkoutExercise _exercise({
  int targetReps = 10,
  bool isTimeBased = false,
  int setCount = 3,
}) => WorkoutExercise(
  id: 'e1',
  name: 'Développé couché',
  notes: '',
  tempo: '2-0-2-0',
  restTime: 90,
  isTimeBased: isTimeBased,
  sets: [
    for (var i = 0; i < setCount; i++)
      WorkoutSet(
        id: 's$i',
        setNumber: i + 1,
        targetReps: isTimeBased ? 0 : targetReps,
        actualReps: isTimeBased ? 0 : targetReps,
        weight: 80,
        completed: false,
        targetSeconds: isTimeBased ? targetReps : null,
      ),
  ],
);

Future<void> _pumpSummary(
  WidgetTester tester, {
  required WorkoutExercise exercise,
  required List<LastPerf> perfs,
  LastPerfMeta? meta,
}) => tester.pumpWidget(
  MaterialApp(
    home: Scaffold(
      body: ExerciseLastPerfs(exercise: exercise, perfs: perfs, meta: meta),
    ),
  ),
);

void main() {
  group('lastPerfKey', () {
    test('ignores the rep target so a 10→12 change keeps the history', () {
      expect(
        lastPerfKey(exerciseName: 'Squat', isTimeBased: false),
        lastPerfKey(exerciseName: 'Squat', isTimeBased: false),
      );
    });

    test('separates reps from holds', () {
      expect(
        lastPerfKey(exerciseName: 'Planche', isTimeBased: true),
        isNot(lastPerfKey(exerciseName: 'Planche', isTimeBased: false)),
      );
    });

    test('follows the catalog id across a language change', () {
      expect(
        lastPerfKey(
          exerciseName: 'Développé couché',
          isTimeBased: false,
          exerciseId: 'abc',
        ),
        lastPerfKey(
          exerciseName: 'Barbell Bench Press',
          isTimeBased: false,
          exerciseId: 'abc',
        ),
      );
    });

    test('separates two exercises sharing a name but not an id', () {
      expect(
        lastPerfKey(exerciseName: 'Curl', isTimeBased: false, exerciseId: 'a'),
        isNot(
          lastPerfKey(
            exerciseName: 'Curl',
            isTimeBased: false,
            exerciseId: 'b',
          ),
        ),
      );
    });

    test('falls back to the normalized name without an id', () {
      expect(
        lastPerfKey(exerciseName: 'Machine Dips', isTimeBased: false),
        lastPerfKey(exerciseName: '  machine  dips ', isTimeBased: false),
      );
      expect(
        lastPerfKey(exerciseName: 'Développé', isTimeBased: false),
        lastPerfKey(exerciseName: 'developpe', isTimeBased: false),
      );
    });

    test('an empty id is treated as no id', () {
      expect(
        lastPerfKey(exerciseName: 'Squat', isTimeBased: false, exerciseId: ''),
        lastPerfKey(exerciseName: 'Squat', isTimeBased: false),
      );
    });

    test('exerciseLastPerfKey reads the exercise identity', () {
      final ex = _exercise().copyWith(exerciseId: 'abc');
      expect(
        exerciseLastPerfKey(ex),
        lastPerfKey(
          exerciseName: ex.name,
          isTimeBased: false,
          exerciseId: 'abc',
        ),
      );
    });
  });

  group('rankLastPerfs', () {
    const key = 'id:bench:R';

    LastPerfCandidate candidate({
      required int day,
      required double weight,
      int? target,
      bool fromSameWorkout = false,
      bool matchesTarget = false,
      String forKey = key,
    }) => LastPerfCandidate(
      key: forKey,
      perfs: [LastPerf(reps: target ?? 0, weight: weight)],
      performedAt: DateTime(2026, 8, day),
      target: target,
      fromSameWorkout: fromSameWorkout,
      matchesTarget: matchesTarget,
    );

    double? weightFor(
      Map<String, ExerciseLastPerfResult> ranked, [
      String forKey = key,
    ]) => ranked[forKey]?.perfs.first.weight;

    test('takes the most recent when nothing else separates candidates', () {
      final ranked = rankLastPerfs([
        candidate(day: 8, weight: 67.5),
        candidate(day: 5, weight: 75),
      ]);
      expect(weightFor(ranked), 67.5);
    });

    test('a matching target beats a more recent session at another target', () {
      // The real case: a 5×5 day and a 4×10 day on the same bench press. Today
      // aims for 5, so the 75kg of the 5th beats the 67.5kg of the 8th.
      final ranked = rankLastPerfs([
        candidate(day: 8, weight: 67.5, target: 10),
        candidate(day: 5, weight: 75, target: 5, matchesTarget: true),
      ]);
      expect(weightFor(ranked), 75);
    });

    test('the same workout beats a matching target elsewhere', () {
      // A template that moved from 10 to 12 reps keeps its own history.
      final ranked = rankLastPerfs([
        candidate(day: 8, weight: 60, target: 12, matchesTarget: true),
        candidate(day: 5, weight: 80, target: 10, fromSameWorkout: true),
      ]);
      expect(weightFor(ranked), 80);
      expect(ranked[key]!.meta.fromSameWorkout, isTrue);
    });

    test('the same workout at the same target wins over both', () {
      final ranked = rankLastPerfs([
        candidate(day: 9, weight: 60, target: 5, matchesTarget: true),
        candidate(day: 8, weight: 70, target: 10, fromSameWorkout: true),
        candidate(
          day: 5,
          weight: 80,
          target: 5,
          fromSameWorkout: true,
          matchesTarget: true,
        ),
      ]);
      expect(weightFor(ranked), 80);
    });

    test('keeps the most recent inside a rank', () {
      final ranked = rankLastPerfs([
        candidate(day: 8, weight: 75, target: 5, matchesTarget: true),
        candidate(day: 5, weight: 72.5, target: 5, matchesTarget: true),
      ]);
      expect(weightFor(ranked), 75);
    });

    test('a reference is never lost when no rank matches', () {
      final ranked = rankLastPerfs([
        candidate(day: 8, weight: 67.5, target: 10),
      ]);
      expect(weightFor(ranked), 67.5);
      expect(ranked[key]!.meta.fromSameWorkout, isFalse);
    });

    test('ranks each key on its own', () {
      final ranked = rankLastPerfs([
        candidate(day: 8, weight: 67.5, target: 10),
        candidate(day: 5, weight: 75, target: 5, matchesTarget: true),
        candidate(day: 9, weight: 40, forKey: 'id:row:R'),
      ]);
      expect(weightFor(ranked), 75);
      expect(weightFor(ranked, 'id:row:R'), 40);
    });

    test('carries the past target through for the UI to flag', () {
      final ranked = rankLastPerfs([
        candidate(day: 8, weight: 67.5, target: 10),
      ]);
      expect(ranked[key]!.meta.target, 10);
      expect(ranked[key]!.meta.performedAt, DateTime(2026, 8, 8));
    });

    test('is empty without candidates', () {
      expect(rankLastPerfs(const []), isEmpty);
    });
  });

  group('LastPerfLookup', () {
    test('reads the target off the first set', () {
      expect(LastPerfLookup.of(_exercise(targetReps: 5)).target, 5);
    });

    test('reads seconds for a hold', () {
      final lookup = LastPerfLookup.of(
        _exercise(targetReps: 45, isTimeBased: true),
      );
      expect(lookup.target, 45);
      expect(lookup.isTimeBased, isTrue);
    });

    test('has no target without sets', () {
      expect(LastPerfLookup.of(_exercise(setCount: 0)).target, isNull);
    });

    test('its key is the one the exercise reads back', () {
      final ex = _exercise().copyWith(exerciseId: 'abc');
      expect(LastPerfLookup.of(ex).key, exerciseLastPerfKey(ex));
    });
  });

  group('referenceWeight', () {
    test('takes the first set, not the heaviest or the last', () {
      expect(
        referenceWeight(const [
          LastPerf(reps: 10, weight: 80),
          LastPerf(reps: 8, weight: 60),
          LastPerf(reps: 6, weight: 90),
        ]),
        80,
      );
    });

    test('is null without history or at bodyweight', () {
      expect(referenceWeight(null), isNull);
      expect(referenceWeight(const []), isNull);
      expect(referenceWeight(const [LastPerf(reps: 12, weight: 0)]), isNull);
    });
  });

  group('perfForSet', () {
    const perfs = [
      LastPerf(reps: 10, weight: 80),
      LastPerf(reps: 9, weight: 80),
    ];

    test('matches by index', () {
      expect(perfForSet(perfs, 0), perfs[0]);
      expect(perfForSet(perfs, 1), perfs[1]);
    });

    test('falls back to the last set past the end', () {
      expect(perfForSet(perfs, 5), perfs.last);
    });

    test('returns null on an empty list or a negative index', () {
      expect(perfForSet(const [], 0), isNull);
      expect(perfForSet(perfs, -1), isNull);
    });
  });

  group('ExerciseLastPerfs', () {
    testWidgets('renders nothing without a reference', (tester) async {
      await _pumpSummary(tester, exercise: _exercise(), perfs: const []);
      expect(find.byType(MetaChip), findsNothing);
      expect(find.byType(RichText), findsNothing);
    });

    testWidgets('shows the age and one chip per set, drops none', (
      tester,
    ) async {
      await _pumpSummary(
        tester,
        exercise: _exercise(),
        perfs: const [
          LastPerf(reps: 10, weight: 80),
          LastPerf(reps: 9, weight: 80),
          LastPerf(reps: 8, weight: 85),
        ],
        meta: LastPerfMeta(
          performedAt: DateTime.now().subtract(const Duration(days: 5)),
          target: 10,
        ),
      );
      expect(
        find.textContaining('Last time', findRichText: true),
        findsOneWidget,
      );
      expect(find.textContaining('5 d ago', findRichText: true), findsOne);
      expect(find.text('10×80kg'), findsOne);
      expect(find.text('9×80kg'), findsOne);
      expect(find.text('8×85kg'), findsOne);
    });

    testWidgets("caps chips at today's set count and marks the rest", (
      tester,
    ) async {
      await _pumpSummary(
        tester,
        exercise: _exercise(setCount: 2),
        perfs: const [
          LastPerf(reps: 10, weight: 80),
          LastPerf(reps: 9, weight: 80),
          LastPerf(reps: 8, weight: 80),
          LastPerf(reps: 7, weight: 80),
        ],
        meta: LastPerfMeta(performedAt: DateTime.now(), target: 10),
      );
      expect(find.text('10×80kg'), findsOne);
      expect(find.text('9×80kg'), findsOne);
      expect(find.text('8×80kg'), findsNothing);
      expect(find.text('+2'), findsOne);
    });

    testWidgets('marks nothing when the past session had fewer sets', (
      tester,
    ) async {
      await _pumpSummary(
        tester,
        exercise: _exercise(setCount: 4),
        perfs: const [LastPerf(reps: 10, weight: 80)],
        meta: LastPerfMeta(performedAt: DateTime.now(), target: 10),
      );
      expect(find.byType(MetaChip), findsOne);
      expect(find.textContaining('+'), findsNothing);
    });

    testWidgets('says when the reference comes from another workout', (
      tester,
    ) async {
      await _pumpSummary(
        tester,
        exercise: _exercise(),
        perfs: const [LastPerf(reps: 10, weight: 80)],
        meta: LastPerfMeta(performedAt: DateTime.now(), target: 10),
      );
      expect(
        find.textContaining('another workout', findRichText: true),
        findsOne,
      );
    });

    testWidgets('stays quiet when it comes from this same workout', (
      tester,
    ) async {
      await _pumpSummary(
        tester,
        exercise: _exercise(),
        perfs: const [LastPerf(reps: 10, weight: 80)],
        meta: LastPerfMeta(
          performedAt: DateTime.now(),
          target: 10,
          fromSameWorkout: true,
        ),
      );
      expect(
        find.textContaining('another workout', findRichText: true),
        findsNothing,
      );
    });

    testWidgets('flags a target the session was not aiming for', (
      tester,
    ) async {
      await _pumpSummary(
        tester,
        exercise: _exercise(targetReps: 12),
        perfs: const [LastPerf(reps: 10, weight: 80)],
        meta: LastPerfMeta(performedAt: DateTime.now(), target: 10),
      );
      expect(
        find.textContaining('was aiming for 10 reps', findRichText: true),
        findsOne,
      );
    });

    testWidgets('stays silent when the target matches', (tester) async {
      await _pumpSummary(
        tester,
        exercise: _exercise(),
        perfs: const [LastPerf(reps: 10, weight: 80)],
        meta: LastPerfMeta(performedAt: DateTime.now(), target: 10),
      );
      expect(
        find.textContaining('was aiming for', findRichText: true),
        findsNothing,
      );
    });
  });
}
