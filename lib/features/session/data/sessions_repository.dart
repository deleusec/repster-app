import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/exercises/exercise_identity.dart';
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
import 'package:repster/i18n/translations.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:uuid/uuid.dart';

/// Repository for live sessions and history. Wraps operations on
/// `workout_sessions` / `session_exercises` / `session_sets`.
class SessionsRepository {
  SessionsRepository(this._client, this._exercises);

  final sb.SupabaseClient _client;

  /// Resolves exercise names to ids, preferring the certified catalog and
  /// reusing the user's existing rows — a session must never fork a duplicate.
  final ExerciseResolver _exercises;

  /// Locale used to name certified exercises. Read here so the DTOs stay
  /// i18n-free, same as `templates_repository`.
  String get _locale => LocaleSettings.currentLocale.languageCode;

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
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Saves the completed session: inserts the exercises and completed sets,
  /// then marks the parent row as completed.
  ///
  /// The parent row is updated **last**: marking it completed also clears the
  /// live snapshot, so doing it first would turn any failure below into an
  /// empty completed session that can no longer be resumed.
  Future<void> saveSession(WorkoutSession session) async {
    try {
      final completedAt = DateTime.now().toUtc();

      // Clear old records in case this is a re-save.
      await _client
          .from('session_exercises')
          .delete()
          .eq('session_id', session.id);

      // Resolved in one pass rather than per exercise: fewer round-trips on the
      // slowest part of the save.
      final exerciseIds = await _exercises.resolve(
        session.exercises.map((e) => e.name),
      );

      // Insert exercises, get their server ids, then insert sets.
      for (var i = 0; i < session.exercises.length; i++) {
        final ex = session.exercises[i];
        // A blank name resolves to nothing: the UI blocks it, but
        // `session_exercises.exercise_id` is worth keeping non-null.
        final exerciseId =
            exerciseIds[ex.name.trim()] ?? await _exercises.idForUnnamed();
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
              // Never NULL: the history and last-perf reads report the target
              // duration a session was aiming for.
              'duration_target_seconds':
                  s.targetSeconds ?? s.actualSeconds ?? 0,
              'duration_performed_seconds':
                  s.actualSeconds ?? s.targetSeconds ?? 0,
            },
          });
        }
        if (setRows.isNotEmpty) {
          await _client.from('session_sets').insert(setRows);
        }
      }

      // `single()` so a vanished session row (purged by a session started
      // elsewhere) surfaces as an error instead of a silent no-op.
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
          .eq('user_id', _userId)
          .select('id')
          .single();
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Edits the metadata of a completed session (title, date, duration, notes).
  /// The performed exercises and sets stay immutable — only the parent row is
  /// writable, which is also all the DB grants (`session_sets` /
  /// `session_exercises` have no UPDATE policy).
  Future<void> updateSessionDetails({
    required String sessionId,
    required String templateName,
    required DateTime startedAt,
    required int durationSeconds,
    required String notes,
  }) async {
    try {
      await _client
          .from('workout_sessions')
          .update({
            'template_name': templateName.trim(),
            'started_at': startedAt.toUtc().toIso8601String(),
            'duration_seconds': durationSeconds,
            'notes': notes.trim().isEmpty ? null : notes.trim(),
          })
          .eq('id', sessionId)
          .eq('user_id', _userId)
          .select('id')
          .single();
    } on Object catch (e, st) {
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
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  static const _lastPerfSelect = '''
id, exercise_id, name, is_time_based,
session_sets (
  set_number, reps_target, reps_performed, weight_kg, completed_at,
  duration_target_seconds, duration_performed_seconds
),
workout_sessions!inner ( user_id, completed_at, template_id )
''';

  /// Past `session_exercises` rows of the user, matched by catalog id or by
  /// display name. Two `in` filters rather than one `or(...)`: exercise names
  /// are user text, and `inFilter` escapes them for us.
  Future<List<Map<String, dynamic>>> _lastPerfRows({
    Set<String>? ids,
    Set<String>? names,
  }) async {
    var query = _client
        .from('session_exercises')
        .select(_lastPerfSelect)
        .eq('workout_sessions.user_id', _userId)
        .not('workout_sessions.completed_at', 'is', null);
    if (ids != null) query = query.inFilter('exercise_id', ids.toList());
    if (names != null) query = query.inFilter('name', names.toList());
    final data = await query;
    return data.cast<Map<String, dynamic>>();
  }

  /// Last perf of each of [lookups], indexed by [lastPerfKey]. Fetches the
  /// candidate sessions and hands the arbitration to [rankLastPerfs], which
  /// documents the ranking; [templateId] is what makes a candidate count as the
  /// same workout.
  ///
  /// Every row is offered under **both** its id key and its name key: today's
  /// exercise may know its catalog id while an old row does not, or the other
  /// way around, and either should still find its history.
  ///
  /// The target never filters the query, it only ranks: a template moving from
  /// 10 to 12 reps must not lose its history.
  Future<Map<String, ExerciseLastPerfResult>> _fetchLastPerfs(
    List<LastPerfLookup> lookups, {
    String? templateId,
  }) async {
    final ids = <String>{};
    final names = <String>{};
    // Today's target per key. Rows are indexed under both their id key and
    // their name key, so a target is registered under both: whichever key the
    // caller reads back must know what today is aiming for.
    final targetByKey = <String, int>{};
    for (final lookup in lookups) {
      final id = lookup.exerciseId;
      if (id != null && id.isNotEmpty) {
        ids.add(id);
      }
      if (lookup.name.trim().isNotEmpty) names.add(lookup.name);
      if (lookup.target case final target?) {
        targetByKey
          ..putIfAbsent(lookup.key, () => target)
          ..putIfAbsent(
            lastPerfKey(
              exerciseName: lookup.name,
              isTimeBased: lookup.isTimeBased,
            ),
            () => target,
          );
      }
    }
    if (ids.isEmpty && names.isEmpty) return const {};

    final batches = await Future.wait([
      if (ids.isNotEmpty) _lastPerfRows(ids: ids),
      if (names.isNotEmpty) _lastPerfRows(names: names),
    ]);

    // A row can come back from both batches: dedup on its own primary key.
    final unique = <String, Map<String, dynamic>>{};
    for (final batch in batches) {
      for (final row in batch) {
        if (row['id'] case final String id) unique[id] = row;
      }
    }

    // Sort by completion date descending client-side to avoid ordering
    // subtleties on the joined table.
    final rows = unique.values.toList()
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

    // Rows are already sorted most recent first, which is what rankLastPerfs
    // expects.
    final candidates = <LastPerfCandidate>[];
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

      final session = row['workout_sessions'] as Map<String, dynamic>?;
      final completedAt = DateTime.tryParse(
        session?['completed_at'] as String? ?? '',
      );
      if (completedAt == null) continue;

      // What that session was aiming for: surfaced so the UI can flag a format
      // change, and compared with today's target to rank this row. A missing
      // target must not discard the perf — it just can't reach the top ranks.
      final target = isTimeBased
          ? sets.first['duration_target_seconds'] as int?
          : sets.first['reps_target'] as int?;

      final perfs = [
        for (final s in sets)
          LastPerf(
            reps: (s['reps_performed'] as int?) ?? 0,
            weight: ((s['weight_kg'] as num?) ?? 0).toDouble(),
            seconds: isTimeBased
                ? (s['duration_performed_seconds'] as int? ?? 0)
                : null,
          ),
      ];
      final isSameWorkout =
          templateId != null && session?['template_id'] == templateId;

      final rowId = row['exercise_id'] as String?;
      for (final key in {
        if (rowId != null)
          lastPerfKey(
            exerciseName: name,
            isTimeBased: isTimeBased,
            exerciseId: rowId,
          ),
        lastPerfKey(exerciseName: name, isTimeBased: isTimeBased),
      }) {
        candidates.add(
          LastPerfCandidate(
            key: key,
            perfs: perfs,
            performedAt: completedAt,
            target: target,
            fromSameWorkout: isSameWorkout,
            // No target on one side or the other means "cannot tell", which is
            // not a match.
            matchesTarget: target != null && target == targetByKey[key],
          ),
        );
      }
    }
    return rankLastPerfs(candidates);
  }

  /// Startup pre-fill: last perf of each template exercise, indexed by
  /// [lastPerfKey], preferring past runs of [templateId].
  Future<Map<String, ExerciseLastPerfResult>> bulkLastPerfs(
    List<LastPerfLookup> lookups, {
    String? templateId,
  }) async {
    if (lookups.isEmpty) return const {};
    try {
      return await _fetchLastPerfs(lookups, templateId: templateId);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Last perf of a single exercise, used after an in-session swap or add.
  /// Same ranking as [bulkLastPerfs] — pass [target] so a swap into a 5-rep
  /// slot is not handed the load of a 10-rep day.
  Future<ExerciseLastPerfResult?> lastPerfsForExercise({
    required String name,
    required bool isTimeBased,
    String? exerciseId,
    int? target,
    String? templateId,
  }) async {
    try {
      final lookup = LastPerfLookup(
        name: name,
        exerciseId: exerciseId,
        isTimeBased: isTimeBased,
        target: target,
      );
      final found = await _fetchLastPerfs([lookup], templateId: templateId);
      return found[lookup.key];
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  static const _exerciseHistorySelect = '''
id, is_time_based,
session_sets ( set_number, reps_performed, weight_kg,
  duration_performed_seconds, completed_at ),
workout_sessions!inner ( user_id, completed_at )
''';

  /// Rows of one exercise, matched by catalog id or by recorded name. Same
  /// two-query shape as [_lastPerfRows], and for the same reason.
  Future<List<Map<String, dynamic>>> _exerciseHistoryRows({
    String? exerciseId,
    String? name,
  }) async {
    var query = _client
        .from('session_exercises')
        .select(_exerciseHistorySelect)
        .eq('workout_sessions.user_id', _userId)
        .not('workout_sessions.completed_at', 'is', null);
    if (exerciseId != null) query = query.eq('exercise_id', exerciseId);
    if (name != null) query = query.eq('name', name);
    final data = await query;
    return data.cast<Map<String, dynamic>>();
  }

  /// Full per-exercise history: every past completed session on this exercise,
  /// each with its completed sets, most recent first. Feeds the history sheet.
  ///
  /// Matched on [exerciseId] when the caller knows it, **plus** on the recorded
  /// [name]. Filtering on the name alone is what made this sheet show 3 entries
  /// in Italian and 33 in French for one bench press: the name is the label
  /// snapshotted at save time, the id is the identity. The name query is kept
  /// for rows that predate the catalog link and for hand-typed exercises.
  Future<List<ExerciseHistoryEntry>> fetchExerciseHistory({
    required String name,
    String? exerciseId,
  }) async {
    try {
      final batches = await Future.wait([
        if (exerciseId != null && exerciseId.isNotEmpty)
          _exerciseHistoryRows(exerciseId: exerciseId),
        if (name.trim().isNotEmpty) _exerciseHistoryRows(name: name),
      ]);
      // A row matches both filters more often than not: dedup on its own key.
      final unique = <String, Map<String, dynamic>>{};
      for (final batch in batches) {
        for (final row in batch) {
          if (row['id'] case final String id) unique[id] = row;
        }
      }

      final entries = <ExerciseHistoryEntry>[];
      for (final row in unique.values) {
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
    } on Object catch (e, st) {
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
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Snapshot of the in-progress session (most recent unfinished), or `null`.
  Future<InProgressSnapshot?> fetchInProgressSnapshot() async {
    try {
      final rows = await _client
          .from('workout_sessions')
          .select('id, live_snapshot, live_updated_at')
          .eq('user_id', _userId)
          .filter('completed_at', 'is', null)
          .not('live_snapshot', 'is', null)
          .order('live_updated_at', ascending: false)
          .limit(1);
      if (rows.isEmpty) return null;
      final r = rows.first;
      final snap = r['live_snapshot'];
      if (snap is! Map) return null;
      final updated = r['live_updated_at'] as String?;
      return InProgressSnapshot(
        sessionId: r['id'] as String,
        snapshot: Map<String, dynamic>.from(snap),
        liveUpdatedAt: updated == null
            ? null
            : DateTime.parse(updated).toLocal(),
      );
    } on Object catch (e, st) {
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
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  // ── History ────────────────────────────────────────────────────────────────

  static const _historySelect =
      '''
id, template_id, template_name, started_at, completed_at, duration_seconds,
tags, notes,
session_exercises (
  id, exercise_id, name, position, notes, is_time_based, slot_id,
  superset_with_next,
  $exerciseDisplayNameSelect,
  session_sets (
    id, set_number, reps_target, reps_performed, weight_kg, tempo,
    completed_at, duration_target_seconds, duration_performed_seconds
  )
)
''';

  /// Only what [WorkoutSessionSummaryDto] aggregates. Kept separate from
  /// [_historySelect] so the list screens do not pay for the per-exercise
  /// catalog join they never display. Mirrors `dashboard_repository`.
  static const _historySummarySelect = '''
id, template_id, template_name, started_at, completed_at, duration_seconds,
tags,
session_exercises (
  is_time_based,
  session_sets (
    reps_performed, weight_kg, duration_performed_seconds, completed_at
  )
)
''';

  Future<List<WorkoutSessionSummary>> fetchHistory({int limit = 100}) async {
    try {
      final rows = await _client
          .from('workout_sessions')
          .select(_historySummarySelect)
          .eq('user_id', _userId)
          .not('completed_at', 'is', null)
          .order('started_at', ascending: false)
          .limit(limit);
      return rows.map(WorkoutSessionSummaryDto.fromRow).toList(growable: false);
    } on Object catch (e, st) {
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
      final locale = _locale;
      return rows
          .map((r) => WorkoutSessionDto.fromRow(r, locale: locale))
          .toList(growable: false);
    } on Object catch (e, st) {
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
      return WorkoutSessionDto.fromRow(row, locale: _locale);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  // ── Internal helpers ───────────────────────────────────────────────────────
}

/// In-progress session snapshot fetched from Supabase.
class InProgressSnapshot {
  const InProgressSnapshot({
    required this.sessionId,
    required this.snapshot,
    this.liveUpdatedAt,
  });

  final String sessionId;
  final Map<String, dynamic> snapshot;

  /// When the snapshot was last written — the last action, give or take the
  /// sync debounce. Redundant with the snapshot's own `lastActivityAt`, and the
  /// only source for snapshots written before that field existed.
  final DateTime? liveUpdatedAt;
}

final sessionsRepositoryProvider = Provider<SessionsRepository>((ref) {
  return SessionsRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(exerciseResolverProvider),
  );
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
            exerciseId: v.exerciseId,
          ),
      ];
      result.add(
        WorkoutExercise(
          id: _uuid.v4(),
          name: primary.name,
          exerciseId: primary.exerciseId,
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
              // A time-based slot always gets a target (the template may have
              // none) and starts at 0 held, like every other creation path.
              targetSeconds: primary.isTimeBased
                  ? (primary.durationSeconds ?? kDefaultHoldSeconds)
                  : null,
              actualSeconds: primary.isTimeBased ? 0 : null,
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
