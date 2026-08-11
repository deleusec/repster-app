/// Everything Postgres' `unaccent` folds over the Latin ranges the app can
/// meet, mirrored character for character.
///
/// **Generated from the database, not hand-written.** The source of truth is
/// the `unaccent` dictionary the DB uses:
///
/// ```sql
/// SELECT lower(chr(cp)), public.f_unaccent(lower(chr(cp)))
/// FROM generate_series(192, 383) cp
/// WHERE public.f_unaccent(lower(chr(cp))) <> lower(chr(cp));
/// ```
///
/// Parity matters because `exerciseNameKey` keys exercise identity on this, and
/// `exercises_user_normalized_name_key` keys the DB's uniqueness on
/// `f_unaccent`. A character folded on one side and not the other makes the
/// client judge a name new and the index reject it as a duplicate. The map used
/// to cover only the Latin-1 letters, which left `č`, `ş`, `ū`, `ž` — and `×`,
/// plausible in a name like `3×10 Curl` — to drift.
///
/// Non-letters (`×`, `÷`) are in here for that reason alone: the DB folds them,
/// so the key has to as well.
const _accentMap = {
  '×': '*',
  'ß': 'ss',
  'à': 'a',
  'á': 'a',
  'â': 'a',
  'ã': 'a',
  'ä': 'a',
  'å': 'a',
  'æ': 'ae',
  'ç': 'c',
  'è': 'e',
  'é': 'e',
  'ê': 'e',
  'ë': 'e',
  'ì': 'i',
  'í': 'i',
  'î': 'i',
  'ï': 'i',
  'ð': 'd',
  'ñ': 'n',
  'ò': 'o',
  'ó': 'o',
  'ô': 'o',
  'õ': 'o',
  'ö': 'o',
  '÷': '/',
  'ø': 'o',
  'ù': 'u',
  'ú': 'u',
  'û': 'u',
  'ü': 'u',
  'ý': 'y',
  'þ': 'th',
  'ÿ': 'y',
  'ā': 'a',
  'ă': 'a',
  'ą': 'a',
  'ć': 'c',
  'ĉ': 'c',
  'ċ': 'c',
  'č': 'c',
  'ď': 'd',
  'đ': 'd',
  'ē': 'e',
  'ĕ': 'e',
  'ė': 'e',
  'ę': 'e',
  'ě': 'e',
  'ĝ': 'g',
  'ğ': 'g',
  'ġ': 'g',
  'ģ': 'g',
  'ĥ': 'h',
  'ħ': 'h',
  'ĩ': 'i',
  'ī': 'i',
  'ĭ': 'i',
  'į': 'i',
  'ı': 'i',
  'ĳ': 'ij',
  'ĵ': 'j',
  'ķ': 'k',
  'ĸ': 'q',
  'ĺ': 'l',
  'ļ': 'l',
  'ľ': 'l',
  'ŀ': 'l',
  'ł': 'l',
  'ń': 'n',
  'ņ': 'n',
  'ň': 'n',
  'ŉ': "'n",
  'ŋ': 'n',
  'ō': 'o',
  'ŏ': 'o',
  'ő': 'o',
  'œ': 'oe',
  'ŕ': 'r',
  'ŗ': 'r',
  'ř': 'r',
  'ś': 's',
  'ŝ': 's',
  'ş': 's',
  'š': 's',
  'ţ': 't',
  'ť': 't',
  'ŧ': 't',
  'ũ': 'u',
  'ū': 'u',
  'ŭ': 'u',
  'ů': 'u',
  'ű': 'u',
  'ų': 'u',
  'ŵ': 'w',
  'ŷ': 'y',
  'ź': 'z',
  'ż': 'z',
  'ž': 'z',
  'ſ': 's',
  // Combining dot above. `İ`.toLowerCase() decomposes to `i` + this on some
  // platforms; Postgres folds the pair to `i`, so drop the mark.
  '̇': '',
};

/// Normalizes a string for search and for identity: lowercased, with every
/// character [_accentMap] knows folded to its ASCII form. `Développé` →
/// `developpe`, enabling accent-insensitive matching.
///
/// Folds one UTF-16 code unit at a time, which covers the whole Latin range;
/// characters outside it pass through unchanged, exactly as `unaccent` leaves
/// them.
String foldAccents(String input) {
  final lower = input.toLowerCase();
  final buffer = StringBuffer();
  for (final char in lower.split('')) {
    buffer.write(_accentMap[char] ?? char);
  }
  return buffer.toString();
}
