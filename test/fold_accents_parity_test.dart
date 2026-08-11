import 'package:flutter_test/flutter_test.dart';
import 'package:repster/core/text/fold_accents.dart';

/// What `unaccent` does in the database, captured from it directly:
///
/// ```sql
/// SELECT lower(chr(cp)), public.f_unaccent(lower(chr(cp)))
/// FROM generate_series(192, 383) cp
/// WHERE public.f_unaccent(lower(chr(cp))) <> lower(chr(cp));
/// ```
///
/// This is the contract `foldAccents` has to honour. Exercise identity is keyed
/// on `foldAccents` client-side and on `f_unaccent` in
/// `exercises_user_normalized_name_key`; a character folded on one side only
/// makes the client insert a name the index then rejects. If this test fails
/// after a Postgres or `unaccent` upgrade, re-run the query and update the map.
const _postgresFolds = {
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
};

void main() {
  group('foldAccents mirrors the database', () {
    test('folds every character unaccent folds, the same way', () {
      final drift = <String, String>{};
      for (final entry in _postgresFolds.entries) {
        final got = foldAccents(entry.key);
        if (got != entry.value) {
          drift[entry.key] =
              'folds to "$got", the DB folds to "${entry.value}"';
        }
      }
      expect(drift, isEmpty, reason: 'characters drifting from f_unaccent');
    });

    test('covers the whole Latin range the query spans', () {
      expect(_postgresFolds, hasLength(99));
    });
  });
}
