import 'dart:math';

import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';

/// Maps a DB row → [Template]. Rebuilds slots (grouped by `slot_id`) and their
/// variants from the `workout_templates` + `template_exercises` +
/// `exercises(name, exercise_names(...))` join.
class TemplateDto {
  const TemplateDto._();

  /// [locale] is a 2-letter code used to pick a certified exercise's display
  /// name; unknown locales fall back to English, then to the canonical name.
  static Template fromRow(Map<String, dynamic> row, {String locale = 'en'}) {
    final rawExercises =
        (row['template_exercises'] as List<dynamic>? ?? const [])
            .cast<Map<String, dynamic>>();

    // Group rows by slot_id (fall back to row.id so each row becomes its own
    // slot when `slot_id` is missing).
    final slotMap = <String, List<Map<String, dynamic>>>{};
    for (final r in rawExercises) {
      final key = (r['slot_id'] as String?) ?? r['id'] as String;
      slotMap.putIfAbsent(key, () => []).add(r);
    }

    // Stable sort of slots by min(position).
    final slotEntries = slotMap.entries.map((e) {
      final minPos = e.value.fold<int>(
        1 << 31,
        (acc, r) => min(acc, r['position'] as int),
      );
      return (slotId: e.key, rows: e.value, minPos: minPos);
    }).toList()..sort((a, b) => a.minPos.compareTo(b.minPos));

    final slots = <TemplateSlot>[];
    for (var i = 0; i < slotEntries.length; i++) {
      final entry = slotEntries[i];
      final sortedVariants = [...entry.rows]
        ..sort((a, b) {
          final va = (a['variant_position'] as int?) ?? 0;
          final vb = (b['variant_position'] as int?) ?? 0;
          return va.compareTo(vb);
        });
      final variants = [
        for (final r in sortedVariants) _exerciseFromRow(r, i, locale),
      ];
      final supersetWithNext =
          (sortedVariants.first['superset_with_next'] as bool?) ?? false;
      slots.add(
        TemplateSlot(
          slotId: entry.slotId,
          order: i,
          supersetWithNext: supersetWithNext,
          variants: variants,
        ),
      );
    }

    return Template(
      id: row['id'] as String,
      name: row['name'] as String,
      description: row['description'] as String? ?? '',
      tags: MuscleGroup.listFromDb(row['tags'] as List<dynamic>?),
      slots: slots,
      isActive: (row['is_active'] as bool?) ?? true,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }

  /// Display name of the joined exercise: the primary `exercise_names` entry
  /// for [locale], else the English one, else the canonical `exercises.name`.
  ///
  /// Same precedence as the `search_exercises` RPC, so the catalog picker and
  /// the templates agree. Personal exercises carry no `exercise_names` rows and
  /// therefore always fall through to their canonical name — without this, a
  /// certified exercise would show its English canonical name in a French
  /// template, and `saveSession` would snapshot that into the history.
  static String _displayName(Map<String, dynamic>? exercises, String locale) {
    if (exercises == null) return '';
    final canonical = exercises['name'] as String? ?? '';
    final rows = exercises['exercise_names'] as List<dynamic>? ?? const [];
    String? localized;
    String? english;
    for (final raw in rows.cast<Map<String, dynamic>>()) {
      if (raw['is_primary'] != true) continue;
      if (raw['name'] case final String value) {
        final rowLocale = raw['locale'] as String?;
        if (rowLocale == locale) localized = value;
        if (rowLocale == 'en') english = value;
      }
    }
    return localized ?? english ?? canonical;
  }

  static TemplateExercise _exerciseFromRow(
    Map<String, dynamic> r,
    int slotOrder,
    String locale,
  ) {
    final exercises = r['exercises'] as Map<String, dynamic>?;
    final name = _displayName(exercises, locale);
    return TemplateExercise(
      id: r['id'] as String,
      name: name,
      exerciseId: r['exercise_id'] as String?,
      sets: (r['sets_count'] as int?) ?? 3,
      reps: (r['reps_target'] as int?) ?? 10,
      tempo: (r['tempo'] as String?) ?? '2-0-2-0',
      restTime: (r['rest_seconds'] as int?) ?? 90,
      notes: (r['notes'] as String?) ?? '',
      order: slotOrder,
      isTimeBased: (r['is_time_based'] as bool?) ?? false,
      durationSeconds: r['duration_seconds'] as int?,
    );
  }
}
