import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/core/emoji/fluent_emoji.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/session_emoji.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';

part 'template.freezed.dart';

/// Workout template — an ordered collection of slots (each may hold several
/// interchangeable variants), tagged by muscle groups.
@freezed
class Template with _$Template {
  const factory Template({
    required String id,
    required String name,
    required String description,
    required List<MuscleGroup> tags,
    required List<TemplateSlot> slots,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,

    /// The picture chosen for the session. `null` on rows older than the
    /// picker or written by the PWA: [displayEmoji] then falls back on the
    /// first muscle group's.
    FluentEmoji? emoji,
  }) = _Template;

  const Template._();

  FluentEmoji get displayEmoji => sessionEmoji(emoji, tags);

  /// Flat list of each slot's primary variant, in order. Useful for screens
  /// that don't show the alternative variants (dashboard, list).
  List<TemplateExercise> get primaryExercises => [
    for (var i = 0; i < slots.length; i++) slots[i].primary.copyWith(order: i),
  ];
}

/// Flattens a list of slots into primary exercises (reused for legacy import
/// and read-only views).
List<TemplateExercise> slotsToExercises(List<TemplateSlot> slots) {
  return [
    for (var i = 0; i < slots.length; i++)
      slots[i].variants.isEmpty
          ? TemplateExercise(
              id: 'empty-${slots[i].slotId}',
              name: '',
              sets: 3,
              reps: 10,
              tempo: '2-0-2-0',
              restTime: 90,
              notes: '',
              order: i,
            )
          : slots[i].variants.first.copyWith(order: i),
  ];
}
