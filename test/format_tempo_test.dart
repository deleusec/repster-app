import 'package:flutter_test/flutter_test.dart';
import 'package:repster/shared/util/format.dart';

void main() {
  group('formatTempoInput', () {
    test('inserts dashes between digits', () {
      expect(formatTempoInput('3120'), '3-1-2-0');
      expect(formatTempoInput('31'), '3-1');
    });

    test('accepts X and normalises to uppercase', () {
      expect(formatTempoInput('312x'), '3-1-2-X');
      expect(formatTempoInput('X'), 'X');
      expect(formatTempoInput('3-1-X-0'), '3-1-X-0');
    });

    test('drops other characters and caps at 4', () {
      expect(formatTempoInput('3a1b2c0dX'), '3-1-2-0');
      expect(formatTempoInput('312X0'), '3-1-2-X');
    });
  });
}
