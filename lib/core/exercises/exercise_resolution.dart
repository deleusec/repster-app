import 'package:repster/core/exercises/exercise_name_key.dart';

/// The certified catalog folded into a name → id lookup.
class CertifiedExerciseLookup {
  const CertifiedExerciseLookup({required this.byKey, required this.ambiguous});

  /// [exerciseNameKey] → `exercises.id`.
  final Map<String, String> byKey;

  /// Keys two different catalog entries both claim, mapped to one of the
  /// offending names. Absent from [byKey]: the caller falls back to a personal
  /// exercise, which forks the history, so this is worth reporting rather than
  /// guessing at. The fix belongs in the catalog data.
  final Map<String, String> ambiguous;
}

/// Folds `exercises` rows joined with `exercise_names` into a lookup.
///
/// Every name of a row — the canonical one plus every alias and translation —
/// points at the same id, which is what lets a localized display name resolve
/// back to the catalog entry it came from.
CertifiedExerciseLookup indexCertifiedExercises(
  Iterable<Map<String, dynamic>> rows,
) {
  final byKey = <String, String>{};
  final ambiguous = <String, String>{};
  for (final row in rows) {
    if (row['id'] case final String id) {
      for (final name in _namesOf(row)) {
        final key = exerciseNameKey(name);
        if (key.isEmpty || ambiguous.containsKey(key)) continue;
        final existing = byKey[key];
        if (existing != null && existing != id) {
          byKey.remove(key);
          ambiguous[key] = name;
          continue;
        }
        byKey[key] = id;
      }
    }
  }
  return CertifiedExerciseLookup(byKey: byKey, ambiguous: ambiguous);
}

/// Canonical name plus every alias and translation of one joined row.
Iterable<String> _namesOf(Map<String, dynamic> row) => [
  if (row['name'] case final String name) name,
  for (final alias
      in row['exercise_names'] as List<dynamic>? ?? const <dynamic>[])
    if ((alias as Map<String, dynamic>)['name'] case final String name) name,
];

/// What resolving a batch of exercise names comes down to once the two indexes
/// are known: the ids already available, and the rows left to create.
class ExerciseResolutionPlan {
  const ExerciseResolutionPlan({
    required this.resolved,
    required this.toCreate,
  });

  /// Input name (trimmed) → `exercises.id`.
  final Map<String, String> resolved;

  /// Rows to insert: one entry per *normalized* name — the representative
  /// spelling to store — mapped to every input spelling that folds onto it.
  ///
  /// Grouped because the DB enforces uniqueness on the normalized name. Two
  /// spellings of one movement in the same batch (`Machine Dips` next to
  /// `Machine dips`) are two distinct strings, so `onConflict: 'user_id,name'`
  /// does not see a conflict — but `exercises_user_normalized_name_key` does,
  /// and rejects the whole insert. One row, several spellings pointing at it.
  final Map<String, List<String>> toCreate;
}

/// Decides, for each of [names], which `exercises.id` to record.
///
/// Precedence: the certified catalog, then the caller's own exercises, then a
/// new personal row.
///
/// The catalog comes first so that recording a movement never forks a private
/// copy of a certified one — two ids for one movement split the user's history,
/// and the fork comes back on every save. Own exercises come next, matched on
/// [exerciseNameKey] rather than on the exact string, so a casing or accent
/// variant reuses the existing row instead of colliding with it.
///
/// Both indexes are keyed by [exerciseNameKey]. Blank names are dropped: a
/// caller that needs an id for one asks for it explicitly.
///
/// Pure on purpose — the I/O lives in `ExerciseResolver`, this is the part
/// worth pinning down with tests.
ExerciseResolutionPlan planExerciseResolution({
  required Iterable<String> names,
  required Map<String, String> certifiedByKey,
  required Map<String, String> ownByKey,
}) {
  final wanted = <String>{
    for (final name in names)
      if (name.trim().isNotEmpty) name.trim(),
  };

  final resolved = <String, String>{};
  final unresolved = <String>[];
  for (final name in wanted) {
    final key = exerciseNameKey(name);
    final id = certifiedByKey[key] ?? ownByKey[key];
    if (id != null) {
      resolved[name] = id;
    } else {
      unresolved.add(name);
    }
  }

  return ExerciseResolutionPlan(
    resolved: resolved,
    toCreate: groupByNameKey(unresolved),
  );
}
