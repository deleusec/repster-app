import 'package:flutter_test/flutter_test.dart';
import 'package:repster/features/session/domain/template_merge.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';

// ── Fixtures ─────────────────────────────────────────────────────────────────

TemplateExercise _tpl(
  String name, {
  int sets = 3,
  int reps = 10,
  int restTime = 90,
  String tempo = '2-0-2-0',
  String notes = '',
  bool isTimeBased = false,
  int? durationSeconds,
}) => TemplateExercise(
  id: 'row-$name',
  name: name,
  exerciseId: 'cat-$name',
  sets: sets,
  reps: reps,
  tempo: tempo,
  restTime: restTime,
  notes: notes,
  order: 0,
  isTimeBased: isTimeBased,
  durationSeconds: durationSeconds,
);

TemplateSlot _slot(
  String id,
  List<TemplateExercise> variants, {
  bool supersetWithNext = false,
}) => TemplateSlot(
  slotId: id,
  order: 0,
  supersetWithNext: supersetWithNext,
  variants: variants,
);

WorkoutVariant _variantOf(TemplateExercise e) => WorkoutVariant(
  name: e.name,
  sets: e.sets,
  reps: e.reps,
  tempo: e.tempo,
  restTime: e.restTime,
  notes: e.notes,
  isTimeBased: e.isTimeBased,
  durationSeconds: e.durationSeconds,
  exerciseId: e.exerciseId,
);

List<WorkoutSet> _sets(int n, {int reps = 10, int? seconds}) => [
  for (var i = 0; i < n; i++)
    WorkoutSet(
      id: 's$i',
      setNumber: i + 1,
      targetReps: seconds == null ? reps : 0,
      actualReps: seconds == null ? reps : 0,
      weight: 60,
      completed: false,
      targetSeconds: seconds,
      actualSeconds: seconds == null ? null : 0,
    ),
];

/// A session exercise started from [slot]'s variant [active], as the live
/// session builds it.
WorkoutExercise _fromSlot(
  TemplateSlot slot, {
  int active = 0,
  bool keep = false,
  String? name,
  String? exerciseId,
  int? restTime,
  String? tempo,
  String? notes,
  List<WorkoutSet>? sets,
}) {
  final origin = slot.variants[active];
  return WorkoutExercise(
    id: 'live-${slot.slotId}',
    name: name ?? origin.name,
    exerciseId: exerciseId ?? origin.exerciseId,
    notes: notes ?? origin.notes,
    tempo: tempo ?? origin.tempo,
    restTime: restTime ?? origin.restTime,
    isTimeBased: origin.isTimeBased,
    sets:
        sets ??
        _sets(
          origin.sets,
          reps: origin.reps,
          seconds: origin.isTimeBased
              ? (origin.durationSeconds ?? kDefaultHoldSeconds)
              : null,
        ),
    slotId: slot.slotId,
    variants: [for (final v in slot.variants) _variantOf(v)],
    activeVariantIndex: active,
    keepInTemplate: keep,
  );
}

WorkoutExercise _added(
  String name, {
  bool keep = false,
  int sets = 3,
  int reps = 12,
  int restTime = 60,
}) => WorkoutExercise(
  id: 'live-$name',
  name: name,
  notes: '',
  tempo: '2-0-2-0',
  restTime: restTime,
  sets: _sets(sets, reps: reps),
  slotId: 'new-$name',
  sessionModified: true,
  keepInTemplate: keep,
);

List<String> _names(List<TemplateSlot> slots) => [
  for (final s in slots) s.primary.name,
];

void main() {
  final squat = _tpl('Squat');
  final bench = _tpl('Bench');
  final dbPress = _tpl('DB press');
  final row = _tpl('Row');

  group('differsFromTemplate', () {
    test('an untouched exercise does not differ', () {
      expect(_fromSlot(_slot('a', [squat])).differsFromTemplate, isFalse);
    });

    test('a variant switch is not a difference', () {
      final ex = _fromSlot(_slot('a', [bench, dbPress]), active: 1);
      expect(ex.differsFromTemplate, isFalse);
    });

    test('set count, target, rest, tempo, notes and name all count', () {
      final slot = _slot('a', [squat]);
      expect(_fromSlot(slot, sets: _sets(4)).differsFromTemplate, isTrue);
      expect(
        _fromSlot(slot, sets: _sets(3, reps: 5)).differsFromTemplate,
        isTrue,
      );
      expect(_fromSlot(slot, restTime: 120).differsFromTemplate, isTrue);
      expect(_fromSlot(slot, tempo: '3-1-1-0').differsFromTemplate, isTrue);
      expect(_fromSlot(slot, notes: 'belt').differsFromTemplate, isTrue);
      expect(_fromSlot(slot, name: 'Front squat').differsFromTemplate, isTrue);
    });

    test('a load change alone is not a difference', () {
      final ex = _fromSlot(_slot('a', [squat]));
      final heavier = ex.copyWith(
        sets: [for (final s in ex.sets) s.copyWith(weight: 100)],
      );
      expect(heavier.differsFromTemplate, isFalse);
    });

    test('an exercise added in session always differs', () {
      expect(_added('Curl').differsFromTemplate, isTrue);
    });
  });

  group('pendingTemplateChanges', () {
    test('lists only kept exercises that differ, plus removals', () {
      final changes = pendingTemplateChanges(
        [
          _fromSlot(_slot('a', [squat]), sets: _sets(4), keep: true),
          _fromSlot(_slot('b', [bench]), sets: _sets(4)),
          _fromSlot(_slot('c', [row]), keep: true),
          _added('Curl', keep: true),
        ],
        {'d': 'Dips'},
      );
      expect(changes.map((c) => c.name), ['Squat', 'Curl', 'Dips']);
      expect(changes.map((c) => c.kind), [
        TemplateChangeKind.modified,
        TemplateChangeKind.added,
        TemplateChangeKind.removed,
      ]);
    });
  });

  group('mergeSessionIntoSlots', () {
    test('leaves the template alone when nothing is kept', () {
      final slots = [
        _slot('a', [squat]),
        _slot('b', [bench]),
      ];
      final merged = mergeSessionIntoSlots(slots, [
        _fromSlot(slots[0], sets: _sets(5)),
        _added('Curl'),
      ]);
      expect(_names(merged), ['Squat', 'Bench']);
      expect(merged[0].primary.sets, 3);
    });

    test('rewrites the active variant in place, other variants kept', () {
      final slots = [
        _slot('a', [bench, dbPress]),
        _slot('b', [row]),
      ];
      final merged = mergeSessionIntoSlots(slots, [
        _fromSlot(
          slots[0],
          active: 1,
          keep: true,
          sets: _sets(4, reps: 8),
          restTime: 120,
          notes: 'neutral grip',
        ),
        _fromSlot(slots[1]),
      ]);
      expect(merged, hasLength(2));
      final slot = merged[0];
      expect(slot.slotId, 'a');
      expect(slot.variants.map((v) => v.name), ['Bench', 'DB press']);
      expect(slot.variants[0], bench.copyWith(order: 0));
      final updated = slot.variants[1];
      expect(updated.id, dbPress.id);
      expect(updated.sets, 4);
      expect(updated.reps, 8);
      expect(updated.restTime, 120);
      expect(updated.notes, 'neutral grip');
      expect(updated.exerciseId, dbPress.exerciseId);
    });

    test('a swap renames the variant and carries the new identity', () {
      final slots = [
        _slot('a', [bench]),
      ];
      final merged = mergeSessionIntoSlots(slots, [
        _fromSlot(
          slots[0],
          keep: true,
          name: 'Floor press',
          exerciseId: 'cat-floor',
        ),
      ]);
      final v = merged.single.variants.single;
      expect(v.name, 'Floor press');
      expect(v.exerciseId, 'cat-floor');
      expect(v.sets, bench.sets);
    });

    test('a hold writes its duration, not reps', () {
      final hang = _tpl('Dead hang', isTimeBased: true, durationSeconds: 30);
      final slots = [
        _slot('a', [hang]),
      ];
      final merged = mergeSessionIntoSlots(slots, [
        _fromSlot(slots[0], keep: true, sets: _sets(3, seconds: 45)),
      ]);
      final v = merged.single.variants.single;
      expect(v.isTimeBased, isTrue);
      expect(v.durationSeconds, 45);
      expect(v.reps, hang.reps);
    });

    test('an added exercise lands after the exercise before it', () {
      final slots = [
        _slot('a', [squat]),
        _slot('b', [bench]),
      ];
      final merged = mergeSessionIntoSlots(slots, [
        _fromSlot(slots[0]),
        _added('Curl', keep: true, sets: 4, restTime: 45),
        _fromSlot(slots[1]),
      ]);
      expect(_names(merged), ['Squat', 'Curl', 'Bench']);
      final curl = merged[1];
      expect(curl.slotId, 'new-Curl');
      expect(curl.supersetWithNext, isFalse);
      expect(curl.variants.single.sets, 4);
      expect(curl.variants.single.reps, 12);
      expect(curl.variants.single.restTime, 45);
      expect(merged.map((s) => s.order), [0, 1, 2]);
    });

    test('an added exercise never splits a superset block', () {
      final slots = [
        _slot('a', [squat], supersetWithNext: true),
        _slot('b', [bench]),
        _slot('c', [row]),
      ];
      final merged = mergeSessionIntoSlots(slots, [
        _fromSlot(slots[0]),
        _added('Curl', keep: true),
        _fromSlot(slots[1]),
        _fromSlot(slots[2]),
      ]);
      expect(_names(merged), ['Squat', 'Bench', 'Curl', 'Row']);
      expect(merged[0].supersetWithNext, isTrue);
    });

    test('an added exercise first in the session goes first', () {
      final slots = [
        _slot('a', [squat]),
      ];
      final merged = mergeSessionIntoSlots(slots, [
        _added('Warm-up', keep: true),
        _fromSlot(slots[0]),
      ]);
      expect(_names(merged), ['Warm-up', 'Squat']);
    });

    test('a removed slot is dropped, the rest renumbered', () {
      final slots = [
        _slot('a', [squat]),
        _slot('b', [bench]),
        _slot('c', [row]),
      ];
      final merged = mergeSessionIntoSlots(
        slots,
        [_fromSlot(slots[0]), _fromSlot(slots[2])],
        removedSlotIds: {'b'},
      );
      expect(_names(merged), ['Squat', 'Row']);
      expect(merged.map((s) => s.order), [0, 1]);
      expect(merged.map((s) => s.primary.order), [0, 1]);
    });

    test('a kept exercise that does not differ writes nothing', () {
      final slots = [
        _slot('a', [squat]),
      ];
      final merged = mergeSessionIntoSlots(slots, [
        _fromSlot(slots[0], keep: true),
      ]);
      expect(merged.single.variants.single, squat.copyWith(order: 0));
    });
  });
}
