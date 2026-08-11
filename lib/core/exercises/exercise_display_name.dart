/// Display name of an exercise joined as `exercises ( name, exercise_names (
/// name, locale, is_primary ) )`: the primary `exercise_names` entry for
/// [locale], else the English one, else the canonical `exercises.name`.
///
/// Same precedence as the `search_exercises` RPC — which builds the same string
/// server-side for the catalog picker — so every screen names a movement
/// identically. Change one, change the other. Personal exercises carry no
/// `exercise_names` rows and therefore always fall through to their canonical
/// name.
///
/// [fallback] is used when the join brought nothing back — for history rows,
/// pass the name recorded at the time, which is the only label a deleted or
/// unlinked exercise still has.
String exerciseDisplayName(
  Map<String, dynamic>? exercises,
  String locale, {
  String fallback = '',
}) {
  if (exercises == null) return fallback;
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
  final name = localized ?? english ?? canonical;
  return name.isEmpty ? fallback : name;
}

/// The `exercises ( … )` fragment every select needs to feed
/// [exerciseDisplayName]. Shared so a caller cannot forget a column and get a
/// silent fallback to the canonical English name.
const String exerciseDisplayNameSelect =
    'exercises ( name, exercise_names ( name, locale, is_primary ) )';
