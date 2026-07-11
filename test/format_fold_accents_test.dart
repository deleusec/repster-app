import 'package:flutter_test/flutter_test.dart';
import 'package:repster/shared/util/format.dart';

void main() {
  group('foldAccents', () {
    test('lowercases and strips French accents', () {
      expect(foldAccents('Développé couché'), 'developpe couche');
      expect(foldAccents('Élévation latérale'), 'elevation laterale');
      expect(foldAccents('TRACTIONS'), 'tractions');
    });

    test('leaves plain ascii untouched', () {
      expect(foldAccents('squat'), 'squat');
    });

    test('lets a folded query match an accented name', () {
      const name = 'Développé militaire';
      expect(foldAccents(name).contains(foldAccents('deve')), isTrue);
      expect(foldAccents(name).contains(foldAccents('MILIT')), isTrue);
    });
  });
}
