const _accentMap = {
  'à': 'a',
  'á': 'a',
  'â': 'a',
  'ä': 'a',
  'ã': 'a',
  'å': 'a',
  'ç': 'c',
  'è': 'e',
  'é': 'e',
  'ê': 'e',
  'ë': 'e',
  'ì': 'i',
  'í': 'i',
  'î': 'i',
  'ï': 'i',
  'ñ': 'n',
  'ò': 'o',
  'ó': 'o',
  'ô': 'o',
  'ö': 'o',
  'õ': 'o',
  'ù': 'u',
  'ú': 'u',
  'û': 'u',
  'ü': 'u',
  'ý': 'y',
  'ÿ': 'y',
  'œ': 'oe',
  'æ': 'ae',
  // Characters Postgres' `unaccent` folds but Unicode decomposition does not.
  // `exerciseNameKey` mirrors that index, so a mismatch here would have the
  // client treat a name as new and the DB reject it as a duplicate. `ß` is
  // live in the catalog ("Hüftstoß").
  'ß': 'ss',
  'ø': 'o',
  'ł': 'l',
  'đ': 'd',
  'ð': 'd',
  'þ': 'th',
};

/// Normalizes a string for search: lowercased with accents stripped.
/// `Développé` → `developpe`, enabling accent-insensitive matching.
String foldAccents(String input) {
  final lower = input.toLowerCase();
  final buffer = StringBuffer();
  for (final char in lower.split('')) {
    buffer.write(_accentMap[char] ?? char);
  }
  return buffer.toString();
}
