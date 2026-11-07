import 'package:flutter_test/flutter_test.dart';

import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_duration.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';

TemplateSlot _slot(
  int i, {
  int sets = 3,
  int reps = 10,
  String tempo = '2-0-2-0',
  int rest = 90,
  bool timed = false,
  int? hold,
}) => TemplateSlot(
  slotId: 's$i',
  order: i,
  supersetWithNext: false,
  variants: [
    TemplateExercise(
      id: 'e$i',
      name: 'x',
      sets: sets,
      reps: reps,
      tempo: tempo,
      restTime: rest,
      notes: '',
      order: i,
      isTimeBased: timed,
      durationSeconds: hold,
    ),
  ],
);

Template _template(List<TemplateSlot> slots) => Template(
  id: 't',
  name: 't',
  description: '',
  tags: const [MuscleGroup.chest],
  slots: slots,
  isActive: true,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

void main() {
  group('tempoSeconds', () {
    test('sums the four phases', () {
      expect(tempoSeconds('3-1-2-0'), 6);
    });

    test('counts X as one second', () {
      expect(tempoSeconds('3-0-X-0'), 4);
    });

    test('falls back to a controlled rep when unreadable', () {
      expect(tempoSeconds(''), 4);
      expect(tempoSeconds('fast'), 4);
    });
  });

  group('estimateTemplateSeconds', () {
    test('adds sets at tempo, the rests between them and a setup', () {
      // 3 sets × 10 reps × 4 s = 120, 2 rests × 90 = 180, setup 50.
      expect(estimateTemplateSeconds(_template([_slot(0)])), 350);
    });

    test('uses the hold for a timed exercise', () {
      // 3 × 45 = 135, 2 × 90 = 180, setup 50.
      expect(
        estimateTemplateSeconds(_template([_slot(0, timed: true, hold: 45)])),
        365,
      );
    });

    test('is zero for an empty template', () {
      expect(estimateTemplateSeconds(_template(const [])), 0);
    });
  });
}
