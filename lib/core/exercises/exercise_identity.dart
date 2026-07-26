import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/exercises/exercise_name_key.dart';
import 'package:repster/core/logging/app_logger.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

// Re-exported so the existing callers keep a single import for exercise
// identity, while `domain/` can depend on the pure key function alone.
export 'package:repster/core/exercises/exercise_name_key.dart'
    show exerciseNameKey, groupByNameKey;

/// Name → id lookup over the certified "Repster" catalog.
///
/// Exists so that recording an exercise never forks a private copy of a
/// certified one: two ids for the same movement split the user's history, and
/// the fork silently comes back on every save. Both the session and template
/// write paths must go through this before creating a personal row.
///
/// Matching spans the canonical `exercises.name` **and** every
/// `exercise_names` row (aliases + translations): the app records *localized*
/// display names, so `Développé couché` has to resolve to `Barbell Bench
/// Press`.
class CertifiedExerciseIndex {
  CertifiedExerciseIndex(this._client);

  final sb.SupabaseClient _client;

  Future<Map<String, String>>? _memo;

  /// Id of the certified exercise known under [name], or `null` if the catalog
  /// doesn't know it (the caller should then use a personal exercise).
  Future<String?> idFor(String name) async {
    final key = exerciseNameKey(name);
    if (key.isEmpty) return null;
    return (await byKey())[key];
  }

  /// The whole index, keyed by [exerciseNameKey].
  ///
  /// Memoized: the catalog is global and read-only, so one fetch per app run
  /// serves every save.
  Future<Map<String, String>> byKey() => _memo ??= _fetch();

  Future<Map<String, String>> _fetch() async {
    final List<dynamic> rows;
    try {
      rows = await _client
          .from('exercises')
          .select('id, name, exercise_names ( name )')
          .eq('is_certified', true);
    } on Object catch (e, st) {
      log.w('certified exercise index unavailable', error: e, stackTrace: st);
      // Do not memoize a failure: retry on the next call. Falling back to a
      // personal exercise is better than failing to record a workout.
      _memo = null;
      return const {};
    }

    final index = <String, String>{};
    final ambiguous = <String>{};
    for (final row in rows.cast<Map<String, dynamic>>()) {
      final id = row['id'] as String?;
      if (id == null) continue;
      final names = <String>[
        if (row['name'] case final String n) n,
        for (final alias in row['exercise_names'] as List<dynamic>? ?? const [])
          if ((alias as Map<String, dynamic>)['name'] case final String n) n,
      ];
      for (final n in names) {
        final key = exerciseNameKey(n);
        if (key.isEmpty || ambiguous.contains(key)) continue;
        final existing = index[key];
        if (existing != null && existing != id) {
          // A name shared by two catalog entries is not something to guess at:
          // drop it so the caller falls back to a personal exercise.
          index.remove(key);
          ambiguous.add(key);
          continue;
        }
        index[key] = id;
      }
    }
    return index;
  }
}

final certifiedExerciseIndexProvider = Provider<CertifiedExerciseIndex>(
  (ref) => CertifiedExerciseIndex(ref.watch(supabaseClientProvider)),
);

/// Resolves exercise names to `exercises.id`, creating personal rows only for
/// names that are genuinely new.
///
/// Precedence: certified catalog → the caller's own exercises (matched on
/// [exerciseNameKey], so a casing or accent variant reuses the existing row) →
/// insert. The middle step is what keeps
/// `exercises_user_normalized_name_key` from rejecting the insert: the DB
/// enforces normalized uniqueness, so attempting `Machine Dips` next to an
/// existing `Machine dips` would be a unique violation, not a silent duplicate.
class ExerciseResolver {
  ExerciseResolver(this._client, this._certified);

  final sb.SupabaseClient _client;
  final CertifiedExerciseIndex _certified;

  /// Maps each non-blank name (trimmed) to the id to record. Blank names are
  /// absent from the result — callers decide what to do with them.
  Future<Map<String, String>> resolve(Iterable<String> names) async {
    final wanted = <String>{
      for (final n in names)
        if (n.trim().isNotEmpty) n.trim(),
    };
    if (wanted.isEmpty) return const {};

    final resolved = <String, String>{};
    final unmatched = <String>[];
    for (final name in wanted) {
      final certifiedId = await _certified.idFor(name);
      if (certifiedId != null) {
        resolved[name] = certifiedId;
      } else {
        unmatched.add(name);
      }
    }
    if (unmatched.isEmpty) return resolved;

    // Fetched per call rather than memoized: the inserts below change it.
    final own = await _ownIndex();
    final toCreate = <String>[];
    for (final name in unmatched) {
      final ownId = own[exerciseNameKey(name)];
      if (ownId != null) {
        resolved[name] = ownId;
      } else {
        toCreate.add(name);
      }
    }
    if (toCreate.isEmpty) return resolved;

    // `onConflict` targets the exact (user_id, name) index, so two spellings
    // of one movement in this batch would not look like a conflict — but
    // `exercises_user_normalized_name_key` sees one, and rejects the whole
    // upsert. Insert one row per normalized name and point every spelling at
    // it.
    final groups = groupByNameKey(toCreate);
    final inserted = await _client
        .from('exercises')
        .upsert([
          for (final name in groups.keys) {'user_id': _userId, 'name': name},
        ], onConflict: 'user_id,name')
        .select('id, name');
    for (final row in inserted) {
      final name = row['name'] as String;
      final id = row['id'] as String;
      for (final spelling in groups[name] ?? [name]) {
        resolved[spelling] = id;
      }
    }
    return resolved;
  }

  /// The caller's own exercises, keyed by [exerciseNameKey].
  Future<Map<String, String>> _ownIndex() async {
    final rows = await _client
        .from('exercises')
        .select('id, name')
        .eq('user_id', _userId);
    final index = <String, String>{};
    for (final row in rows) {
      if (row['name'] case final String name) {
        // The DB guarantees one row per normalized name, so no tie to break.
        index[exerciseNameKey(name)] = row['id'] as String;
      }
    }
    return index;
  }

  String get _userId {
    final id = _client.auth.currentUser?.id;
    if (id == null) {
      throw StateError('ExerciseResolver used while signed out');
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
