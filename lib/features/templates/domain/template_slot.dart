import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/features/templates/domain/template_exercise.dart';

part 'template_slot.freezed.dart';

/// A slot is a position in a template. It can hold several interchangeable
/// `variants` (at least one). When `supersetWithNext` is true, the slot chains
/// into the next one — forming a superset block.
@freezed
class TemplateSlot with _$TemplateSlot {
  const factory TemplateSlot({
    required String slotId,
    required int order,
    required bool supersetWithNext,
    required List<TemplateExercise> variants,
  }) = _TemplateSlot;

  const TemplateSlot._();

  /// The primary variant — the one used by default.
  TemplateExercise get primary => variants.first;
}
