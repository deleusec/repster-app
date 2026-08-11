import 'package:repster/core/text/fold_accents.dart';

/// Identity key for an exercise name: trimmed, whitespace-collapsed,
/// lowercased and accent-stripped. What makes `Machine Dips`, `machine dips`
/// and `Machine  dips` one exercise.
///
/// **One of three implementations of the same rule, which must agree:**
///   1. this function, via `foldAccents`
///   2. `exercises_user_normalized_name_key` —
///      `f_unaccent(lower(btrim(regexp_replace(name, '\s+', ' ', 'g'))))`
///   3. `resolveExerciseIds` in the PWA (`repster-pwa/lib/exercise-identity.ts`)
///
/// (1) drifting from (2) means the client judges a name new, inserts, and the
/// unique index rejects it. `ExerciseResolver` recovers from that rather than
/// failing a save, so a drift costs a round-trip instead of a lost workout —
/// but keep them aligned. `foldAccents` carries the characters Postgres'
/// `unaccent` folds and Unicode decomposition does not (`ß`, `œ`, `ø`…).
///
/// Kept in its own Dart-pure file (no Supabase, no Riverpod) so `domain/` can
/// use it to key an exercise that has no catalog id yet.
String exerciseNameKey(String name) =>
    foldAccents(name.trim().replaceAll(RegExp(r'\s+'), ' '));

/// What makes two records "the same exercise": its catalog id when it has one,
/// its normalized name otherwise.
///
/// The single rule for every read that groups history — the per-exercise
/// history sheet, the strength curves, the "last time" reference. Grouping on
/// the raw display name instead splits one movement per language and per
/// spelling: `Panca piana` and `Développé couché` are one bench press, and the
/// user who switches the app to Italian must not lose the other 33 sets.
///
/// An empty [exerciseId] counts as no id — the DB never stores one, but a
/// hand-typed exercise arrives with `''` from some code paths.
String exerciseIdentityKey({required String name, String? exerciseId}) =>
    exerciseId != null && exerciseId.isNotEmpty
    ? 'id:$exerciseId'
    : 'nm:${exerciseNameKey(name)}';

/// Groups [names] that collide once normalized, preserving input order.
///
/// Returns, for each representative — the first name seen for a given
/// [exerciseNameKey] — every raw name that folds onto it. Blank names are
/// dropped.
///
/// Exists because the database enforces uniqueness on the *normalized* name.
/// Two spellings of one movement in the same batch (`Machine Dips` next to
/// `Machine dips`) are two distinct strings, so an `onConflict: 'user_id,name'`
/// upsert does not see them as a conflict — but the normalized index does, and
/// rejects the batch. Collapsing them first is what keeps one mistyped
/// exercise from failing an entire session save.
Map<String, List<String>> groupByNameKey(Iterable<String> names) {
  final representatives = <String, String>{};
  final groups = <String, List<String>>{};
  for (final name in names) {
    final key = exerciseNameKey(name);
    if (key.isEmpty) continue;
    final representative = representatives.putIfAbsent(key, () => name);
    groups.putIfAbsent(representative, () => <String>[]).add(name);
  }
  return groups;
}
