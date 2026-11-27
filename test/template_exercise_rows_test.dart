import 'package:flutter_test/flutter_test.dart';
import 'package:repster/features/templates/data/templates_repository.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';

TemplateSlot _slot(String id, List<String> names) => TemplateSlot(
  slotId: id,
  order: 0,
  supersetWithNext: false,
  variants: [
    for (final name in names)
      TemplateExercise(
        id: 'row-$name',
        name: name,
        sets: 3,
        reps: 10,
        tempo: '',
        restTime: 90,
        notes: '',
        order: 0,
      ),
  ],
);

void main() {
  group('templateExerciseRows', () {
    test('keeps an exercise whose name was typed with a stray space', () {
      // A phone keyboard leaves a space after a suggested word.
      final rows = templateExerciseRows(
        'tpl',
        [
          _slot('a', ['Hack squat']),
          _slot('b', ['Lombaire ']),
          _slot('c', [' Leg curl']),
        ],
        {'Hack squat': 'hack', 'Lombaire': 'lombaire', 'Leg curl': 'curl'},
      );

      expect(
        [for (final r in rows) r['exercise_id']],
        ['hack', 'lombaire', 'curl'],
      );
      expect([for (final r in rows) r['position']], [0, 1, 2]);
    });

    test('the variants of a slot share its position', () {
      final rows = templateExerciseRows(
        'tpl',
        [
          _slot('a', ['Squat']),
          _slot('b', ['Leg curl', 'Romanian deadlift']),
        ],
        {'Squat': 'squat', 'Leg curl': 'curl', 'Romanian deadlift': 'rdl'},
      );

      expect(
        [for (final r in rows) (r['position'], r['variant_position'])],
        [(0, 0), (1, 0), (1, 1)],
      );
    });
  });
}
