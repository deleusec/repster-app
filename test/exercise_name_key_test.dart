import 'package:flutter_test/flutter_test.dart';
import 'package:repster/core/exercises/exercise_identity.dart';

void main() {
  group('exerciseNameKey', () {
    test('collapses the variations that used to fork a second row', () {
      // The real duplicates found in prod.
      expect(exerciseNameKey('Machine dips'), exerciseNameKey('Machine Dips'));
      expect(exerciseNameKey('Spider curl'), exerciseNameKey('Spider Curl'));
      expect(exerciseNameKey('Pec deck'), exerciseNameKey('Pec deck '));
      // Trailing spaces from the PWA, and double spaces.
      expect(exerciseNameKey('Tirage vertical '), 'tirage vertical');
      expect(
        exerciseNameKey('Oiseaux poulie  unilatéral'),
        'oiseaux poulie unilateral',
      );
    });

    test('strips accents so the DB f_unaccent comparison agrees', () {
      expect(exerciseNameKey('Développé couché'), 'developpe couche');
      expect(exerciseNameKey('Élévation latérale'), 'elevation laterale');
    });

    test('keeps genuinely different exercises apart', () {
      expect(
        exerciseNameKey('Développé couché'),
        isNot(exerciseNameKey('Développé couché prise serrée')),
      );
      expect(
        exerciseNameKey('Pec deck'),
        isNot(exerciseNameKey('Reverse pec deck')),
      );
      expect(
        exerciseNameKey('Tractions pronation'),
        isNot(exerciseNameKey('Tractions supination')),
      );
    });

    test('folds what Postgres unaccent folds but NFD does not', () {
      // The DB index is the authority: f_unaccent(lower(...)) yields these.
      // A mismatch makes the client insert a name the index then rejects.
      expect(exerciseNameKey('Hüftstoß'), 'huftstoss');
      expect(exerciseNameKey('Cœur'), 'coeur');
      expect(exerciseNameKey('Æther'), 'aether');
      expect(exerciseNameKey('Bankdrücken'), 'bankdrucken');
    });

    test('leaves hyphens and apostrophes alone, like the DB', () {
      expect(exerciseNameKey('T-Bar Row'), 't-bar row');
      expect(exerciseNameKey("L'appui"), "l'appui");
    });

    test('is empty for a blank name', () {
      expect(exerciseNameKey('   '), isEmpty);
    });
  });

  group('groupByNameKey', () {
    test('keeps distinct names apart, one group each', () {
      final groups = groupByNameKey(['Squat', 'Bench Press', 'Deadlift']);
      expect(groups.keys, ['Squat', 'Bench Press', 'Deadlift']);
      expect(groups.values.every((aliases) => aliases.length == 1), isTrue);
    });

    test('folds casing variants onto the first name seen', () {
      // The whole point: these two normalize identically, so inserting both
      // would violate exercises_user_normalized_name_key.
      final groups = groupByNameKey(['Machine Dips', 'Machine dips']);
      expect(groups.keys, ['Machine Dips']);
      expect(groups['Machine Dips'], ['Machine Dips', 'Machine dips']);
    });

    test('folds accents and stray whitespace too', () {
      final groups = groupByNameKey([
        'Développé couché',
        'Developpe couche',
        'Développé  couché ',
      ]);
      expect(groups, hasLength(1));
      expect(groups.values.single, hasLength(3));
    });

    test('drops blank names rather than grouping them together', () {
      final groups = groupByNameKey(['Squat', '   ', '']);
      expect(groups.keys, ['Squat']);
    });

    test('is stable: the representative is the first occurrence', () {
      final groups = groupByNameKey(['machine dips', 'Machine Dips']);
      expect(groups.keys, ['machine dips']);
    });
  });
}
