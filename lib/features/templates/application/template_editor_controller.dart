import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repster/core/emoji/fluent_emoji.dart';
import 'package:repster/core/emoji/legacy_tags.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';
import 'package:uuid/uuid.dart';

part 'template_editor_controller.freezed.dart';

/// Draft state of the template being edited. Independent of the repo — the
/// draft is only committed on `save`.
@freezed
class TemplateEditorState with _$TemplateEditorState {
  const factory TemplateEditorState({
    required String name,
    required String description,
    required List<TemplateSlot> slots,
    required FluentEmoji emoji,
  }) = _TemplateEditorState;

  const TemplateEditorState._();

  factory TemplateEditorState.empty() => const TemplateEditorState(
    name: '',
    description: '',
    slots: [],
    emoji: kDefaultSessionEmoji,
  );

  factory TemplateEditorState.fromTemplate(Template t) => TemplateEditorState(
    name: t.name,
    description: t.description,
    slots: t.slots,
    emoji: t.emoji,
  );

  bool get isValid =>
      name.trim().isNotEmpty &&
      slots.isNotEmpty &&
      slots.every((s) => s.variants.every((v) => v.name.trim().isNotEmpty));
}

class TemplateEditorController
    extends AutoDisposeNotifier<TemplateEditorState> {
  static const _uuid = Uuid();

  @override
  TemplateEditorState build() => TemplateEditorState.empty();

  void hydrate(Template t) => state = TemplateEditorState.fromTemplate(t);

  void setName(String v) => state = state.copyWith(name: v);
  void setDescription(String v) => state = state.copyWith(description: v);
  void setEmoji(FluentEmoji e) => state = state.copyWith(emoji: e);

  // ── Slots ────────────────────────────────────────────────────────────────

  void addSlot({TemplateExercise? variant}) {
    final ex =
        variant ??
        TemplateExercise(
          id: _uuid.v4(),
          name: '',
          sets: 3,
          reps: 10,
          tempo: '2-0-2-0',
          restTime: 90,
          notes: '',
          order: state.slots.length,
        );
    state = state.copyWith(
      slots: [
        ...state.slots,
        TemplateSlot(
          slotId: _uuid.v4(),
          order: state.slots.length,
          supersetWithNext: false,
          variants: [ex],
        ),
      ],
    );
  }

  void removeSlot(int index) {
    final next = [...state.slots]..removeAt(index);
    state = state.copyWith(slots: _reindex(next));
  }

  void reorderSlots(int oldIndex, int newIndex) {
    final next = [...state.slots];
    var ni = newIndex;
    if (ni > oldIndex) ni -= 1;
    final moved = next.removeAt(oldIndex);
    next.insert(ni, moved);
    state = state.copyWith(slots: _reindex(next));
  }

  void toggleSupersetWithNext(int index) {
    if (index >= state.slots.length - 1) return;
    final next = [...state.slots];
    next[index] = next[index].copyWith(
      supersetWithNext: !next[index].supersetWithNext,
    );
    state = state.copyWith(slots: next);
  }

  // ── Slot variants ────────────────────────────────────────────────────────

  void addVariant(int slotIndex) {
    final slot = state.slots[slotIndex];
    final base = slot.variants.first;
    final variant = base.copyWith(id: _uuid.v4());
    final next = [...state.slots];
    next[slotIndex] = slot.copyWith(variants: [...slot.variants, variant]);
    state = state.copyWith(slots: next);
  }

  void removeVariant(int slotIndex, int variantIndex) {
    final slot = state.slots[slotIndex];
    if (slot.variants.length <= 1) return;
    final variants = [...slot.variants]..removeAt(variantIndex);
    final next = [...state.slots];
    next[slotIndex] = slot.copyWith(variants: variants);
    state = state.copyWith(slots: next);
  }

  void updateVariant(
    int slotIndex,
    int variantIndex,
    TemplateExercise Function(TemplateExercise) update,
  ) {
    final slot = state.slots[slotIndex];
    final variants = [...slot.variants];
    variants[variantIndex] = update(variants[variantIndex]);
    final next = [...state.slots];
    next[slotIndex] = slot.copyWith(variants: variants);
    state = state.copyWith(slots: next);
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  List<TemplateSlot> _reindex(List<TemplateSlot> slots) {
    return [
      for (var i = 0; i < slots.length; i++)
        slots[i].copyWith(
          order: i,
          supersetWithNext: i != slots.length - 1 && slots[i].supersetWithNext,
        ),
    ];
  }
}

final templateEditorControllerProvider =
    AutoDisposeNotifierProvider<TemplateEditorController, TemplateEditorState>(
      TemplateEditorController.new,
    );
