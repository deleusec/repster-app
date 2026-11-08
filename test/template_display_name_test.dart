import 'package:flutter_test/flutter_test.dart';
import 'package:repster/features/templates/data/template_dto.dart';

/// One template, one slot, one exercise — the joined `exercises` payload is
/// what each test varies.
Map<String, dynamic> _row(Map<String, dynamic> exercises) => {
  'id': 't1',
  'name': 'Foundation',
  'description': null,
  'tags': <String>[],
  'is_active': true,
  'created_at': '2026-01-01T00:00:00.000Z',
  'updated_at': '2026-01-01T00:00:00.000Z',
  'template_exercises': [
    {
      'id': 'te1',
      'slot_id': 's1',
      'position': 0,
      'variant_position': 0,
      'superset_with_next': false,
      'exercises': exercises,
    },
  ],
};

String _name(Map<String, dynamic> exercises, {required String locale}) =>
    TemplateDto.fromRow(
      _row(exercises),
      locale: locale,
    ).slots.first.primary.name;

void main() {
  group('TemplateDto display name', () {
    // The certified `Barbell Bench Press`, as the join returns it.
    final certified = {
      'name': 'Barbell Bench Press',
      'exercise_names': [
        {'name': 'Barbell Bench Press', 'locale': 'en', 'is_primary': true},
        {'name': 'Développé couché', 'locale': 'fr', 'is_primary': true},
        {'name': 'Press de banca', 'locale': 'es', 'is_primary': true},
        // A non-primary alias must never be picked as the display name.
        {'name': 'Bench', 'locale': 'en', 'is_primary': false},
      ],
    };

    test('prefers the primary name for the requested locale', () {
      expect(_name(certified, locale: 'fr'), 'Développé couché');
      expect(_name(certified, locale: 'es'), 'Press de banca');
    });

    test('falls back to English for an unknown locale', () {
      expect(_name(certified, locale: 'de'), 'Barbell Bench Press');
    });

    test('never picks a non-primary alias', () {
      expect(_name(certified, locale: 'en'), isNot('Bench'));
      expect(_name(certified, locale: 'en'), 'Barbell Bench Press');
    });

    test('personal exercises keep their canonical name', () {
      // No `exercise_names` rows: this is the shape of a user's own exercise.
      expect(
        _name({
          'name': 'Hack squat',
          'exercise_names': <dynamic>[],
        }, locale: 'fr'),
        'Hack squat',
      );
      // And the shape before the join was widened, so old callers still map.
      expect(_name({'name': 'Hack squat'}, locale: 'fr'), 'Hack squat');
    });

    test('falls back to the canonical name when no primary matches', () {
      final orphan = {
        'name': 'Rear Delt Fly',
        'exercise_names': [
          {'name': 'alias sans locale', 'locale': null, 'is_primary': false},
        ],
      };
      expect(_name(orphan, locale: 'fr'), 'Rear Delt Fly');
    });
  });
}
