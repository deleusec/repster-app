import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/supabase/postgrest_error_x.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/features/dashboard/data/workout_session_summary_dto.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/session/data/workout_session_dto.dart';
import 'package:repster/features/session/domain/exercise_history.dart';
import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:uuid/uuid.dart';

/// Repository for live sessions and history. Wraps operations on
/// `workout_sessions` / `session_exercises` / `session_sets`.
class SessionsRepository {
  SessionsRepository(this._client);

  final sb.SupabaseClient _client;

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

  /// Creates a `workout_sessions` row (without `completed_at`) and returns its
  /// id. The live state is built controller-side from the `Template`.
  Future<String> startSession(Template template) async {
    try {
      // Invariant: at most one in-progress session per user. Purge unfinished
      // drafts before creating a new one.
      await _client
          .from('workout_sessions')
          .delete()
          .eq('user_id', _userId)
          .filter('completed_at', 'is', null);
      final row = await _client
          .from('workout_sessions')
          .insert({
            'user_id': _userId,
            'template_id': template.id,
            'template_name': template.name,
            'tags': template.tags.map((t) => t.toDb()).toList(),
            'started_at': DateTime.now().toUtc().toIso8601String(),
          })
          .select('id')
          .single();
      return row['id'] as String;
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Saves the completed session: updates the parent row and inserts the
  /// exercises and completed sets.
  Future<void> saveSession(WorkoutSession session) async {
    try {
      final completedAt = DateTime.now().toUtc();
      await _client
          .from('workout_sessions')
          .update({
            'completed_at': completedAt.toIso8601String(),
            'duration_seconds': session.duration,
            'notes': session.notes.trim().isEmpty ? null : session.notes.trim(),
            // The session becomes an immutable history entry, so clear the
            // live snapshot.
            'live_snapshot': null,
            'live_updated_at': null,
          })
          .eq('id', session.id)
          .eq('user_id', _userId);

      // Clear old records in case this is a re-save.
      await _client
          .from('session_exercises')
          .delete()
          .eq('session_id', session.id);

      // Insert exercises, get their server ids, then insert sets.
      for (var i = 0; i < session.exercises.length; i++) {
        final ex = session.exercises[i];
        final exerciseId = await _ensureExerciseId(ex.name);
        final inserted = await _client
            .from('session_exercises')
            .insert({
              'session_id': session.id,
              'exercise_id': exerciseId,
              'name': ex.name,
              'position': i,
              'notes': ex.notes.trim().isEmpty ? null : ex.notes.trim(),
              'is_time_based': ex.isTimeBased,
              'slot_id': ex.slotId,
              'superset_with_next':
                  ex.supersetGroupId != null &&
                  (ex.supersetPosition ?? 0) < ((ex.supersetSize ?? 1) - 1),
            })
            .select('id')
            .single();
        final sessionExerciseId = inserted['id'] as String;

        if (ex.sets.isEmpty) continue;
        final setRows = <Map<String, Object?>>[];
        for (final s in ex.sets) {
          if (!s.completed) continue;
          setRows.add({
            'session_exercise_id': sessionExerciseId,
            'set_number': s.setNumber,
            'reps_target': s.targetReps,
            'reps_performed': ex.isTimeBased ? 0 : s.actualReps,
            'weight_kg': s.weight,
            'tempo': ex.tempo.isEmpty ? null : ex.tempo,
            'completed_at': completedAt.toIso8601String(),
            if (ex.isTimeBased) ...{
              'duration_target_seconds': s.targetSeconds,
              'duration_performed_seconds': s.actualSeconds,
            },
          });
        }
        if (setRows.isNotEmpty) {
          await _client.from('session_sets').insert(setRows);
        }
      }
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Discard: deletes the workout_sessions row (cascades).
  Future<void> discardInProgress(String sessionId) async {
    try {
      await _client
          .from('workout_sessions')
          .delete()
          .eq('id', sessionId)
          .eq('user_id', _userId);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  static const _lastPerfSelect = '''
exercise_id, name, is_time_based,
session_sets (
  set_number, reps_target, reps_performed, weight_kg, completed_at,
  duration_target_seconds, duration_performed_seconds
),
workout_sessions!inner ( user_id, completed_at )
''';

  /// Fetches the user's latest perfs (one entry per set), deduplicated by
  /// `(name, target, kind)` keeping the most recent session. Shared basis for
  /// pre-fill, suggestions and fallback.
  Future<List<_LastPerfRow>> _fetchLastPerfRows({List<String>? names}) async {
    if (names != null && names.isEmpty) return const [];
    var query = _client
        .from('session_exercises')
        .select(_lastPerfSelect)
        .eq('workout_sessions.user_id', _userId)
        .not('workout_sessions.completed_at', 'is', null)
        .not('exercise_id', 'is', null);
    if (names != null) {
      query = query.inFilter('name', names.toSet().toList());
    }
    final data = await query;

    // Sort by completion date descending client-side to avoid ordering
    // subtleties on the joined table.
    final rows = data.cast<Map<String, dynamic>>().toList()
      ..sort((a, b) {
        final ca =
            (a['workout_sessions'] as Map<String, dynamic>?)?['completed_at']
                as String? ??
            '';
        final cb =
            (b['workout_sessions'] as Map<String, dynamic>?)?['completed_at']
                as String? ??
            '';
        return cb.compareTo(ca);
      });

    final seen = <String>{};
    final result = <_LastPerfRow>[];
    for (final row in rows) {
      final name = row['name'] as String?;
      if (name == null) continue;
      final isTimeBased = (row['is_time_based'] as bool?) ?? false;
      final sets =
          (row['session_sets'] as List<dynamic>? ?? const [])
              .cast<Map<String, dynamic>>()
              .where((s) => s['completed_at'] != null)
              .toList()
            ..sort(
              (a, b) =>
                  (a['set_number'] as int).compareTo(b['set_number'] as int),
            );
      if (sets.isEmpty) continue;
      final target = isTimeBased
          ? sets.first['duration_target_seconds'] as int?
          : sets.first['reps_target'] as int?;
      if (target == null) continue;

      final key = lastPerfKey(
        exerciseName: name,
        target: target,
        isTimeBased: isTimeBased,
      );
      if (seen.contains(key)) continue;
      seen.add(key);

      final completedAt =
          (row['workout_sessions'] as Map<String, dynamic>?)?['completed_at']
              as String? ??
          '';
      result.add(
        _LastPerfRow(
          name: name,
          isTimeBased: isTimeBased,
          target: target,
          completedAt: completedAt,
          perfs: [
            for (final s in sets)
              LastPerf(
                reps: (s['reps_performed'] as int?) ?? 0,
                weight: ((s['weight_kg'] as num?) ?? 0).toDouble(),
                seconds: isTimeBased
                    ? (s['duration_performed_seconds'] as int? ?? 0)
                    : null,
              ),
          ],
        ),
      );
    }
    return result;
  }

  /// Startup pre-fill: latest perfs (per set) for each template exercise,
  /// indexed by `lastPerfKey`.
  Future<Map<String, List<LastPerf>>> bulkLastPerfs(
    List<String> exerciseNames,
  ) async {
    if (exerciseNames.isEmpty) return const {};
    try {
      final rows = await _fetchLastPerfRows(names: exerciseNames);
      return {
        for (final r in rows)
          lastPerfKey(
            exerciseName: r.name,
            target: r.target,
            isTimeBased: r.isTimeBased,
          ): r.perfs,
      };
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Latest perf of an exercise for a given target. Falls back to the most
  /// recent perf of the same kind if the exact target is missing. Used after a
  /// swap or add.
  Future<ExerciseLastPerfResult?> lastPerfsForExercise({
    required String name,
    required int target,
    required bool isTimeBased,
  }) async {
    try {
      final rows = await _fetchLastPerfRows(names: [name]);
      final sameKind = rows.where((r) => r.isTimeBased == isTimeBased).toList();
      if (sameKind.isEmpty) return null;
      for (final r in sameKind) {
        if (r.target == target) {
          return ExerciseLastPerfResult(perfs: r.perfs);
        }
      }
      // Fallback: the most recent of the right kind (rows already sorted desc).
      final fallback = sameKind.first;
      return ExerciseLastPerfResult(
        perfs: fallback.perfs,
        isFallback: true,
        originalTarget: fallback.target,
      );
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  static const _exerciseHistorySelect = '''
is_time_based,
session_sets ( set_number, reps_performed, weight_kg,
  duration_performed_seconds, completed_at ),
workout_sessions!inner ( user_id, completed_at )
''';

  /// Full per-exercise history: every past completed session on [name], each
  /// with its completed sets, most recent first. Feeds the history sheet.
  Future<List<ExerciseHistoryEntry>> fetchExerciseHistory(String name) async {
    try {
      final data = await _client
          .from('session_exercises')
          .select(_exerciseHistorySelect)
          .eq('name', name)
          .eq('workout_sessions.user_id', _userId)
          .not('workout_sessions.completed_at', 'is', null);

      final entries = <ExerciseHistoryEntry>[];
      for (final row in data.cast<Map<String, dynamic>>()) {
        final completedAt =
            (row['workout_sessions'] as Map<String, dynamic>?)?['completed_at']
                as String?;
        if (completedAt == null) continue;
        final isTimeBased = (row['is_time_based'] as bool?) ?? false;
        final sets =
            (row['session_sets'] as List<dynamic>? ?? const [])
                .cast<Map<String, dynamic>>()
                .where((s) => s['completed_at'] != null)
                .toList()
              ..sort(
                (a, b) =>
                    (a['set_number'] as int).compareTo(b['set_number'] as int),
              );
        if (sets.isEmpty) continue;
        entries.add(
          ExerciseHistoryEntry(
            date: DateTime.parse(completedAt),
            isTimeBased: isTimeBased,
            sets: [
              for (final s in sets)
                ExerciseHistorySet(
                  setNumber: s['set_number'] as int,
                  reps: (s['reps_performed'] as int?) ?? 0,
                  weight: ((s['weight_kg'] as num?) ?? 0).toDouble(),
                  seconds: isTimeBased
                      ? (s['duration_performed_seconds'] as int? ?? 0)
                      : null,
                ),
            ],
          ),
        );
      }
      entries.sort((a, b) => b.date.compareTo(a.date));
      return entries;
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  // ── In-progress session snapshot (resume) ─────────────────────────────────

  /// Persists the live snapshot (JSONB) to allow resuming.
  Future<void> syncSnapshot(
    String sessionId,
    Map<String, Object?> snapshot,
  ) async {
    try {
      await _client
          .from('workout_sessions')
          .update({
            'live_snapshot': snapshot,
            'live_updated_at': DateTime.now().toUtc().toIso8601String(),
          })
          .eq('id', sessionId)
          .eq('user_id', _userId);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Snapshot of the in-progress session (most recent unfinished), or `null`.
  Future<InProgressSnapshot?> fetchInProgressSnapshot() async {
    try {
      final rows = await _client
          .from('workout_sessions')
          .select('id, live_snapshot')
          .eq('user_id', _userId)
          .filter('completed_at', 'is', null)
          .not('live_snapshot', 'is', null)
          .order('live_updated_at', ascending: false)
          .limit(1);
      if (rows.isEmpty) return null;
      final r = rows.first;
      final snap = r['live_snapshot'];
      if (snap is! Map) return null;
      return InProgressSnapshot(
        sessionId: r['id'] as String,
        snapshot: Map<String, dynamic>.from(snap),
      );
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Permanently deletes a completed session from history (cascades to
  /// `session_exercises` / `session_sets`). Semantically distinct from
  /// [discardInProgress] but the same DB operation.
  Future<void> deleteSession(String sessionId) async {
    try {
      await _client
          .from('workout_sessions')
          .delete()
          .eq('id', sessionId)
          .eq('user_id', _userId);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  // ── History ────────────────────────────────────────────────────────────────

  static const _historySelect = '''
id, template_id, template_name, started_at, completed_at, duration_seconds,
tags, notes,
session_exercises (
  id, name, position, notes, is_time_based, slot_id, superset_with_next,
  session_sets (
    id, set_number, reps_target, reps_performed, weight_kg, tempo,
    completed_at, duration_target_seconds, duration_performed_seconds
  )
)
''';

  Future<List<WorkoutSessionSummary>> fetchHistory({int limit = 100}) async {
    try {
      final rows = await _client
          .from('workout_sessions')
          .select(_historySelect)
          .eq('user_id', _userId)
          .not('completed_at', 'is', null)
          .order('started_at', ascending: false)
          .limit(limit);
      return rows.map(WorkoutSessionSummaryDto.fromRow).toList(growable: false);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Like [fetchHistory] but returns full sessions (exercises + sets), the
  /// basis for advanced stats: per-exercise progression, estimated 1RM,
  /// records. Expensive: reserved for the Stats screen.
  Future<List<WorkoutSession>> fetchHistorySessions({int limit = 500}) async {
    try {
      final rows = await _client
          .from('workout_sessions')
          .select(_historySelect)
          .eq('user_id', _userId)
          .not('completed_at', 'is', null)
          .order('started_at', ascending: false)
          .limit(limit);
      return rows.map(WorkoutSessionDto.fromRow).toList(growable: false);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<WorkoutSession> fetchSessionById(String id) async {
    try {
      final row = await _client
          .from('workout_sessions')
          .select(_historySelect)
          .eq('id', id)
          .eq('user_id', _userId)
          .single();
      return WorkoutSessionDto.fromRow(row);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  // ── Internal helpers ───────────────────────────────────────────────────────

  Future<String> _ensureExerciseId(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      // Safety net: should not happen, the UI blocks empty sets.
      final inserted = await _client
          .from('exercises')
          .insert({'user_id': _userId, 'name': '(unnamed)'})
          .select('id')
          .single();
      return inserted['id'] as String;
    }
    final inserted = await _client
        .from('exercises')
        .upsert({
          'user_id': _userId,
          'name': trimmed,
        }, onConflict: 'user_id,name')
        .select('id')
        .single();
    return inserted['id'] as String;
  }
}

/// Aggregated last-perf row (repo-internal).
class _LastPerfRow {
  const _LastPerfRow({
    required this.name,
    required this.isTimeBased,
    required this.target,
    required this.completedAt,
    required this.perfs,
  });

  final String name;
  final bool isTimeBased;
  final int target;
  final String completedAt;
  final List<LastPerf> perfs;
}

/// In-progress session snapshot fetched from Supabase.
class InProgressSnapshot {
  const InProgressSnapshot({required this.sessionId, required this.snapshot});

  final String sessionId;
  final Map<String, dynamic> snapshot;
}

final sessionsRepositoryProvider = Provider<SessionsRepository>((ref) {
  return SessionsRepository(ref.watch(supabaseClientProvider));
});

/// Builds the initial live exercise list from a template.
List<WorkoutExercise> initialExercisesFromTemplate(Template template) {
  final result = <WorkoutExercise>[];

  // For each slot, take the primary variant and snapshot all variants (for
  // quick swaps). Superset chain detection: successive runs of slots with
  // `supersetWithNext = true`, ended by a slot whose flag is false.
  var i = 0;
  while (i < template.slots.length) {
    final blockStart = i;
    while (i < template.slots.length - 1 &&
        template.slots[i].supersetWithNext) {
      i++;
    }
    final blockEnd = i;
    final blockSize = blockEnd - blockStart + 1;
    final groupId = blockSize > 1 ? _uuid.v4() : null;
    for (var j = 0; j < blockSize; j++) {
      final slot = template.slots[blockStart + j];
      final primary = slot.primary;
      final variants = [
        for (final v in slot.variants)
          WorkoutVariant(
            name: v.name,
            sets: v.sets,
            reps: v.reps,
            tempo: v.tempo,
            restTime: v.restTime,
            notes: v.notes,
            isTimeBased: v.isTimeBased,
            durationSeconds: v.durationSeconds,
          ),
      ];
      result.add(
        WorkoutExercise(
          id: _uuid.v4(),
          name: primary.name,
          notes: primary.notes,
          tempo: primary.tempo,
          restTime: primary.restTime,
          sets: List.generate(
            primary.sets,
            (k) => WorkoutSet(
              id: _uuid.v4(),
              setNumber: k + 1,
              targetReps: primary.reps,
              actualReps: primary.reps,
              weight: 0,
              completed: false,
              targetSeconds: primary.isTimeBased
                  ? primary.durationSeconds
                  : null,
              actualSeconds: primary.isTimeBased
                  ? primary.durationSeconds
                  : null,
            ),
          ),
          isTimeBased: primary.isTimeBased,
          slotId: slot.slotId,
          variants: variants,
          activeVariantIndex: 0,
          supersetGroupId: groupId,
          supersetPosition: groupId == null ? null : j,
          supersetSize: groupId == null ? null : blockSize,
        ),
      );
    }
    i++;
  }
  return result;
}

const _uuid = Uuid();
