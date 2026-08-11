import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/exercises/exercise_identity.dart';
import 'package:repster/core/supabase/postgrest_error_x.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/features/templates/data/template_dto.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_slot.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:uuid/uuid.dart';

/// CRUD repository for templates. Encapsulates the `workout_templates` +
/// `template_exercises` + `exercises(name)` join and the DB → domain mapping.
class TemplatesRepository {
  TemplatesRepository(this._client, this._exercises);

  final sb.SupabaseClient _client;

  /// Resolves exercise names to ids, preferring the certified catalog and
  /// reusing the user's existing rows — a template must never fork a duplicate.
  final ExerciseResolver _exercises;
  static const _uuid = Uuid();

  String get _userId {
    final id = _client.auth.currentUser?.id;
    if (id == null) {
      throw const AppAuthException(
        'Not authenticated',
        reason: AuthFailureReason.notSignedIn,
      );
    }
    return id;
  }

  // ── Read ─────────────────────────────────────────────────────────────────

  static const _selectAll =
      '''
id, name, description, tags, position, is_active, created_at, updated_at,
template_exercises (
  id, exercise_id, position, sets_count, reps_target, tempo, rest_seconds,
  notes, is_time_based, duration_seconds, slot_id, variant_position,
  superset_with_next,
  $exerciseDisplayNameSelect
)
''';

  /// Locale used to resolve certified exercises' display names. Read here so
  /// `template_dto` stays i18n-free.
  String get _locale => LocaleSettings.currentLocale.languageCode;

  Future<List<Template>> fetchAll({bool onlyActive = false}) async {
    try {
      var query = _client
          .from('workout_templates')
          .select(_selectAll)
          .eq('user_id', _userId);
      if (onlyActive) query = query.eq('is_active', true);
      final rows = await query.order('position', ascending: true);
      final locale = _locale;
      return rows
          .map((r) => TemplateDto.fromRow(r, locale: locale))
          .toList(growable: false);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<Template> fetchById(String id) async {
    try {
      final row = await _client
          .from('workout_templates')
          .select(_selectAll)
          .eq('id', id)
          .eq('user_id', _userId)
          .single();
      return TemplateDto.fromRow(row, locale: _locale);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  // ── Mutations ────────────────────────────────────────────────────────────

  Future<String> create({
    required String name,
    required String description,
    required List<MuscleGroup> tags,
    required List<TemplateSlot> slots,
  }) async {
    try {
      final normalized = _normalizeSlots(slots);
      final nextPosition = await _nextPosition();
      final inserted = await _client
          .from('workout_templates')
          .insert({
            'user_id': _userId,
            'name': name.trim(),
            'description': description.trim().isEmpty
                ? null
                : description.trim(),
            'tags': tags.map((t) => t.toDb()).toList(),
            'position': nextPosition,
          })
          .select('id')
          .single();
      final id = inserted['id'] as String;

      if (normalized.isNotEmpty) {
        await _replaceTemplateExercises(id, normalized);
      }
      return id;
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<void> update({
    required String id,
    required String name,
    required String description,
    required List<MuscleGroup> tags,
    required List<TemplateSlot> slots,
  }) async {
    try {
      final normalized = _normalizeSlots(slots);
      await _client
          .from('workout_templates')
          .update({
            'name': name.trim(),
            'description': description.trim().isEmpty
                ? null
                : description.trim(),
            'tags': tags.map((t) => t.toDb()).toList(),
          })
          .eq('id', id)
          .eq('user_id', _userId);

      await _client.from('template_exercises').delete().eq('template_id', id);

      if (normalized.isNotEmpty) {
        await _replaceTemplateExercises(id, normalized);
      }
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<void> delete(String id) async {
    try {
      await _client
          .from('workout_templates')
          .delete()
          .eq('id', id)
          .eq('user_id', _userId);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<String> duplicate(String id) async {
    try {
      final source = await fetchById(id);
      final newSlots = source.slots
          .map(
            (s) => s.copyWith(
              slotId: _uuid.v4(),
              variants: s.variants
                  .map((v) => v.copyWith(id: _uuid.v4()))
                  .toList(growable: false),
            ),
          )
          .toList(growable: false);
      return await create(
        name: '${source.name} ${t.templates.list.copySuffix}',
        description: source.description,
        tags: source.tags,
        slots: newSlots,
      );
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<void> toggleActive(String id, {required bool isActive}) async {
    try {
      await _client
          .from('workout_templates')
          .update({'is_active': isActive})
          .eq('id', id)
          .eq('user_id', _userId);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<void> reorder(List<String> orderedIds) async {
    if (orderedIds.isEmpty) return;
    try {
      // `_userId` resolved once, then all UPDATEs run in parallel: ~1
      // round-trip of latency instead of N. RLS plus the `user_id` filter
      // ensure we only touch the user's own templates.
      final userId = _userId;
      await Future.wait([
        for (var i = 0; i < orderedIds.length; i++)
          _client
              .from('workout_templates')
              .update({'position': i})
              .eq('id', orderedIds[i])
              .eq('user_id', userId),
      ]);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  // ── Internal helpers ─────────────────────────────────────────────────────

  Future<int> _nextPosition() async {
    final rows = await _client
        .from('workout_templates')
        .select('position')
        .eq('user_id', _userId)
        .order('position', ascending: false)
        .limit(1);
    if (rows.isEmpty) return 0;
    return (rows.first['position'] as int) + 1;
  }

  Future<void> _replaceTemplateExercises(
    String templateId,
    List<TemplateSlot> slots,
  ) async {
    final names = [
      for (final s in slots)
        for (final v in s.variants) v.name,
    ];
    final exMap = await _exercises.resolve(names);
    final rows = <Map<String, Object?>>[];
    for (var slotIdx = 0; slotIdx < slots.length; slotIdx++) {
      final slot = slots[slotIdx];
      for (var vIdx = 0; vIdx < slot.variants.length; vIdx++) {
        final ex = slot.variants[vIdx];
        final exerciseId = exMap[ex.name];
        if (exerciseId == null) continue;
        rows.add({
          'template_id': templateId,
          'exercise_id': exerciseId,
          'position': slotIdx,
          'slot_id': slot.slotId,
          'variant_position': vIdx,
          'superset_with_next': slot.supersetWithNext,
          'sets_count': ex.sets,
          'reps_target': ex.reps,
          'tempo': ex.tempo.isEmpty ? null : ex.tempo,
          'rest_seconds': ex.restTime,
          'notes': ex.notes.trim().isEmpty ? null : ex.notes.trim(),
          'is_time_based': ex.isTimeBased,
          'duration_seconds': ex.isTimeBased
              ? (ex.durationSeconds ?? 30)
              : null,
        });
      }
    }
    if (rows.isEmpty) return;
    await _client.from('template_exercises').insert(rows);
  }

  /// Normalizes slots before writing: recomputes orders; the last slot cannot
  /// have `supersetWithNext = true`.
  List<TemplateSlot> _normalizeSlots(List<TemplateSlot> slots) {
    return [
      for (var i = 0; i < slots.length; i++)
        slots[i].copyWith(
          order: i,
          supersetWithNext: i != slots.length - 1 && slots[i].supersetWithNext,
        ),
    ];
  }
}

final templatesRepositoryProvider = Provider<TemplatesRepository>((ref) {
  return TemplatesRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(exerciseResolverProvider),
  );
});
