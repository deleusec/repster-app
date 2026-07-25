import 'package:flutter_test/flutter_test.dart';
import 'package:repster/features/session/data/sessions_repository.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';

Template _template(List<TemplateExercise> primaries) {
  final now = DateTime(2026);
  return Template(
    id: 't1',
    name: 'Foundation',
    description: '',
    tags: const [],
    isActive: true,
    createdAt: now,
    updatedAt: now,
    slots: [
      for (var i = 0; i < primaries.length; i++)
        TemplateSlot(
          slotId: 'slot-$i',
          order: i,
          supersetWithNext: false,
          variants: [primaries[i]],
        ),
    ],
  );
}

TemplateExercise _exercise({
  required String name,
  bool isTimeBased = false,
  int? durationSeconds,
  int sets = 2,
}) {
  return TemplateExercise(
    id: 'e-$name',
    name: name,
    sets: sets,
    reps: 10,
    tempo: '2-0-2-0',
    restTime: 90,
    notes: '',
    order: 0,
    isTimeBased: isTimeBased,
    durationSeconds: durationSeconds,
  );
}

void main() {
  group('initialExercisesFromTemplate — time-based slots', () {
    test('carries the template duration as target, nothing held yet', () {
      final exercises = initialExercisesFromTemplate(
        _template([
          _exercise(name: 'Dead hang', isTimeBased: true, durationSeconds: 45),
        ]),
      );

      expect(exercises.single.isTimeBased, isTrue);
      expect(
        exercises.single.sets.map((s) => s.targetSeconds),
        everyElement(45),
      );
      expect(
        exercises.single.sets.map((s) => s.actualSeconds),
        everyElement(0),
      );
    });

    test('falls back to the default hold when the template has none', () {
      final exercises = initialExercisesFromTemplate(
        _template([_exercise(name: 'Dead hang', isTimeBased: true)]),
      );

      // A null target would make the set unsavable as a timed perf: history and
      // last-perf lookups key on the target duration.
      expect(
        exercises.single.sets.map((s) => s.targetSeconds),
        everyElement(kDefaultHoldSeconds),
      );
    });

    test('leaves durations null on a reps-based slot', () {
      final exercises = initialExercisesFromTemplate(
        _template([_exercise(name: 'Squat')]),
      );

      final set = exercises.single.sets.first;
      expect(set.targetSeconds, isNull);
      expect(set.actualSeconds, isNull);
      expect(set.targetReps, 10);
      expect(set.actualReps, 10);
    });
  });
}
