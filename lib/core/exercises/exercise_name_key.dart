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
