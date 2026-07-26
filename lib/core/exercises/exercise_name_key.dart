import 'package:repster/core/text/fold_accents.dart';

/// Identity key for an exercise name: trimmed, whitespace-collapsed,
/// lowercased and accent-stripped. Mirrors the DB's `f_unaccent(lower(...))`
/// comparisons so client and server agree on what counts as "the same name" —
/// which is what makes `Machine Dips`, `machine dips` and `Machine  dips` one
/// exercise.
///
/// Kept in its own Dart-pure file (no Supabase, no Riverpod) so `domain/` can
/// use it to key an exercise that has no catalog id yet.
String exerciseNameKey(String name) =>
    foldAccents(name.trim().replaceAll(RegExp(r'\s+'), ' '));

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
