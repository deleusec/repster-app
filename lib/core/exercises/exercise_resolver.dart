import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/exercises/certified_exercise_index.dart';
import 'package:repster/core/exercises/exercise_name_key.dart';
import 'package:repster/core/exercises/exercise_resolution.dart';
import 'package:repster/core/logging/app_logger.dart';
import 'package:repster/core/supabase/postgrest_paging.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// Name recorded for an exercise saved without one. The UI blocks it, but
/// `session_exercises.exercise_id` is worth keeping non-null.
const String kUnnamedExerciseName = '(unnamed)';

/// Postgres unique-violation. Raised by `exercises_user_normalized_name_key`
/// when the client judged a name new and the DB disagreed.
const String _uniqueViolation = '23505';

/// Turns exercise names into `exercises.id`, creating personal rows only for
/// names that are genuinely new.
///
/// **The only writer of the `exercises` table.** Every path that records a
/// movement — saving a session, saving a template — goes through here, which is
/// what keeps a second row from appearing for a movement the user already has.
/// See [planExerciseResolution] for the precedence and why it is that way.
class ExerciseResolver {
  ExerciseResolver(this._client, this._certified);

  final sb.SupabaseClient _client;
  final CertifiedExerciseIndex _certified;

  /// Maps each non-blank name (trimmed) to the id to record. Blank names are
  /// absent from the result — see [idForUnnamed].
  Future<Map<String, String>> resolve(Iterable<String> names) async {
    final plan = planExerciseResolution(
      names: names,
      certifiedByKey: await _certified.byKey(),
      // Read per call rather than memoized: the insert below changes it.
      ownByKey: await _ownIndex(),
    );
    if (plan.toCreate.isEmpty) return plan.resolved;

    final resolved = {...plan.resolved};
    final created = await _create(plan.toCreate);
    for (final entry in plan.toCreate.entries) {
      final id = created[entry.key];
      if (id == null) continue;
      for (final spelling in entry.value) {
        resolved[spelling] = id;
      }
    }
    return resolved;
  }

  /// Id to record for an exercise the user left unnamed.
  ///
  /// Routed through [resolve] rather than inserting directly, so it inherits
  /// the same deduplication and the same recovery.
  Future<String> idForUnnamed() async {
    final id = (await resolve(const [kUnnamedExerciseName]))[
      kUnnamedExerciseName
    ];
    if (id == null) {
      throw const UnexpectedException(
        'Could not resolve the unnamed exercise',
      );
    }
    return id;
  }

  /// Inserts one row per normalized name and returns representative name → id.
  ///
  /// On a unique violation the DB is telling us its normalization and
  /// [exerciseNameKey] disagreed — a character Postgres' `unaccent` folds and
  /// `foldAccents` does not, say. The row already exists, so re-reading the
  /// user's exercises resolves it. Without this, that disagreement would abort
  /// the whole save: a user could not record a workout at all.
  Future<Map<String, String>> _create(
    Map<String, List<String>> toCreate,
  ) async {
    try {
      final inserted = await _client
          .from('exercises')
          .upsert([
            for (final name in toCreate.keys)
              {'user_id': _userId, 'name': name},
          ], onConflict: 'user_id,name')
          .select('id, name');
      return {
        for (final row in inserted)
          if (row['name'] case final String name)
            name: row['id'] as String,
      };
    } on sb.PostgrestException catch (e, st) {
      if (e.code != _uniqueViolation) rethrow;
      log.w(
        'exercise insert hit the normalized-name index: exerciseNameKey and '
        'f_unaccent disagree on ${toCreate.keys.join(', ')} — re-reading',
        error: e,
        stackTrace: st,
      );
      final own = await _ownIndex();
      return {
        for (final name in toCreate.keys)
          if (own[exerciseNameKey(name)] case final String id) name: id,
      };
    }
  }

  /// The caller's own exercises, keyed by [exerciseNameKey].
  ///
  /// Paged: a truncated read would look like "this name is new" and insert a
  /// row the unique index then rejects.
  Future<Map<String, String>> _ownIndex() async {
    final rows = await fetchAllRows(
      () => _client.from('exercises').select('id, name').eq('user_id', _userId),
    );
    return {
      for (final row in rows)
        // One row per normalized name is a DB guarantee, so no tie to break.
        if (row['name'] case final String name)
          exerciseNameKey(name): row['id'] as String,
    };
  }

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
}

final exerciseResolverProvider = Provider<ExerciseResolver>(
  (ref) => ExerciseResolver(
    ref.watch(supabaseClientProvider),
    ref.watch(certifiedExerciseIndexProvider),
  ),
);
