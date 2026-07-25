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

    test('is empty for a blank name', () {
      expect(exerciseNameKey('   '), isEmpty);
    });
  });
}
