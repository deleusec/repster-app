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
