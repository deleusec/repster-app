import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// What kind of change a session writes back to its template.
enum TemplateChangeKind { added, modified, removed }

/// One line of the "template will be updated" recap.
class TemplateChange {
  const TemplateChange({required this.name, required this.kind});

  final String name;
  final TemplateChangeKind kind;
}

/// Lists what [mergeSessionIntoSlots] would change: the exercises flagged
/// [WorkoutExercise.keepInTemplate] that actually differ from their origin,
/// plus the slots marked for removal. Empty when there is nothing to write.
List<TemplateChange> pendingTemplateChanges(
  List<WorkoutExercise> exercises,
  Map<String, String> removedSlots,
) {
  return [
    for (final ex in exercises)
      if (ex.keepInTemplate && ex.differsFromTemplate)
        TemplateChange(
          name: ex.name,
          kind: ex.templateOrigin == null
              ? TemplateChangeKind.added
              : TemplateChangeKind.modified,
        ),
    for (final name in removedSlots.values)
      TemplateChange(name: name, kind: TemplateChangeKind.removed),
  ];
}

/// Writes the session's kept changes into the template's slots.
///
/// Only exercises flagged [WorkoutExercise.keepInTemplate] are written, and
/// only slots listed in [removedSlotIds] are dropped: everything else in the
/// template stays exactly as it was, other variants included. A kept exercise
/// whose slot still exists replaces its active variant in place; one with no
/// slot (added in session) becomes a new single-variant slot, placed after
/// the slot of the nearest session exercise before it — past the end of that
/// slot's superset block, so a chain is never split.
List<TemplateSlot> mergeSessionIntoSlots(
  List<TemplateSlot> slots,
  List<WorkoutExercise> exercises, {
  Set<String> removedSlotIds = const {},
}) {
  final result = [
    for (final s in slots)
      if (!removedSlotIds.contains(s.slotId)) s,
  ];
  for (var i = 0; i < exercises.length; i++) {
    final ex = exercises[i];
    if (!ex.keepInTemplate || !ex.differsFromTemplate) continue;
    final slotId = ex.slotId;
    final existing = slotId == null
        ? -1
        : result.indexWhere((s) => s.slotId == slotId);

    if (existing >= 0) {
      final slot = result[existing];
      final variants = [...slot.variants];
      final idx = (ex.activeVariantIndex ?? 0).clamp(
        0,
        variants.isEmpty ? 0 : variants.length - 1,
      );
      final previous = idx < variants.length ? variants[idx] : null;
      final replacement = _toTemplateExercise(
        ex,
        id: previous?.id ?? _uuid.v4(),
        order: slot.order,
      );
      if (previous == null) {
        variants.add(replacement);
      } else {
        variants[idx] = replacement;
      }
      result[existing] = slot.copyWith(variants: variants);
      continue;
    }

    final newSlotId = slotId ?? _uuid.v4();
    final newSlot = TemplateSlot(
      slotId: newSlotId,
      order: 0,
      supersetWithNext: false,
      variants: [_toTemplateExercise(ex, id: _uuid.v4(), order: 0)],
    );
    result.insert(_insertionIndex(result, exercises, i), newSlot);
  }

  return [
    for (var i = 0; i < result.length; i++)
      result[i].copyWith(
        order: i,
        variants: [for (final v in result[i].variants) v.copyWith(order: i)],
      ),
  ];
}

/// Index at which a slot for `exercises[i]` goes: right after the block of
/// the closest preceding exercise that still has a slot, else at the start.
int _insertionIndex(
  List<TemplateSlot> slots,
  List<WorkoutExercise> exercises,
  int i,
) {
  for (var j = i - 1; j >= 0; j--) {
    final slotId = exercises[j].slotId;
    if (slotId == null) continue;
    var at = slots.indexWhere((s) => s.slotId == slotId);
    if (at < 0) continue;
    while (at < slots.length - 1 && slots[at].supersetWithNext) {
      at++;
    }
    return at + 1;
  }
  return 0;
}

TemplateExercise _toTemplateExercise(
  WorkoutExercise ex, {
  required String id,
  required int order,
}) {
  final origin = ex.templateOrigin;
  final target = ex.currentTarget;
  return TemplateExercise(
    id: id,
    name: ex.name,
    exerciseId: ex.exerciseId,
    sets: ex.sets.isEmpty ? (origin?.sets ?? 1) : ex.sets.length,
    reps: ex.isTimeBased
        ? (origin?.reps ?? 10)
        : (target ?? origin?.reps ?? 10),
    tempo: ex.tempo,
    restTime: ex.restTime,
    notes: ex.notes,
    order: order,
    isTimeBased: ex.isTimeBased,
    durationSeconds: ex.isTimeBased
        ? (target ?? origin?.durationSeconds ?? kDefaultHoldSeconds)
        : null,
  );
}
