import 'package:flutter_test/flutter_test.dart';
import 'package:repster/core/exercises/exercise_identity.dart';

/// The certified catalog as `CertifiedExerciseIndex` hands it over: every
/// alias and translation folded onto the one id.
final _catalog = {
  exerciseNameKey('Barbell Bench Press'): 'bench',
  exerciseNameKey('Développé couché'): 'bench',
  exerciseNameKey('Panca piana'): 'bench',
  exerciseNameKey('Lat Pulldown'): 'pulldown',
  exerciseNameKey('Tirage vertical'): 'pulldown',
};

ExerciseResolutionPlan plan(
  List<String> names, {
  Map<String, String> catalog = const {},
  Map<String, String> own = const {},
}) => planExerciseResolution(
  names: names,
  certifiedByKey: catalog,
  ownByKey: own,
);

/// One joined `exercises` row as the catalog select returns it.
Map<String, dynamic> _row(
  String id,
  String canonical, [
  List<String> aliases = const [],
]) => {
  'id': id,
  'name': canonical,
  'exercise_names': [
    for (final alias in aliases) {'name': alias},
  ],
};

void main() {
  group('indexCertifiedExercises', () {
    test('every translation and alias points at the one id', () {
      final lookup = indexCertifiedExercises([
        _row('bench', 'Barbell Bench Press', [
          'Développé couché',
          'Panca piana',
          'BBP',
        ]),
      ]);
      for (final name in [
        'Barbell Bench Press',
        'Développé couché',
        'Panca piana',
        'BBP',
      ]) {
        expect(lookup.byKey[exerciseNameKey(name)], 'bench', reason: name);
      }
      expect(lookup.ambiguous, isEmpty);
    });

    test('matches through casing and accents', () {
      final lookup = indexCertifiedExercises([
        _row('bench', 'Barbell Bench Press', ['Développé couché']),
      ]);
      expect(lookup.byKey[exerciseNameKey('  developpe  COUCHE ')], 'bench');
    });

    test('a name claimed by two exercises is reported, not guessed', () {
      final lookup = indexCertifiedExercises([
        _row('a', 'Row'),
        _row('b', 'Rowing', ['row']),
      ]);
      expect(lookup.byKey.containsKey(exerciseNameKey('Row')), isFalse);
      expect(lookup.ambiguous.keys, [exerciseNameKey('Row')]);
      // The unambiguous name of the second entry survives.
      expect(lookup.byKey[exerciseNameKey('Rowing')], 'b');
    });

    test('a name repeated within one exercise is not an ambiguity', () {
      // The canonical name is usually also its own English primary name.
      final lookup = indexCertifiedExercises([
        _row('bench', 'Barbell Bench Press', ['Barbell Bench Press']),
      ]);
      expect(lookup.ambiguous, isEmpty);
      expect(lookup.byKey.values, ['bench']);
    });

    test('survives rows with no id, no name, or no aliases', () {
      final lookup = indexCertifiedExercises([
        {'name': 'Orphan', 'exercise_names': <dynamic>[]},
        {'id': 'x', 'exercise_names': <dynamic>[]},
        {'id': 'y', 'name': 'Squat'},
        {'id': 'z', 'name': '   ', 'exercise_names': <dynamic>[]},
      ]);
      expect(lookup.byKey, {exerciseNameKey('Squat'): 'y'});
    });
  });

  group('planExerciseResolution', () {
    test('a localized name resolves to the certified exercise', () {
      // The whole point: the app records display names, so the Italian and the
      // French label must both land on the one catalog row.
      final result = plan([
        'Panca piana',
        'Développé couché',
      ], catalog: _catalog);
      expect(result.resolved, {
        'Panca piana': 'bench',
        'Développé couché': 'bench',
      });
      expect(result.toCreate, isEmpty);
    });

    test('the catalog wins over an own exercise of the same name', () {
      // A leftover personal duplicate must not keep capturing the history.
      final result = plan(
        ['Développé couché'],
        catalog: _catalog,
        own: {exerciseNameKey('Développé couché'): 'personal-dupe'},
      );
      expect(result.resolved['Développé couché'], 'bench');
    });

    test('an own exercise is reused across casing and accents', () {
      final result = plan(
        ['Machine Dips'],
        own: {exerciseNameKey('machine dips'): 'mine'},
      );
      expect(result.resolved['Machine Dips'], 'mine');
      expect(result.toCreate, isEmpty);
    });

    test('an unknown name is queued for creation', () {
      final result = plan(['Hack squat'], catalog: _catalog);
      expect(result.resolved, isEmpty);
      expect(result.toCreate, {
        'Hack squat': ['Hack squat'],
      });
    });

    test('two spellings in one batch become a single row', () {
      // The DB enforces uniqueness on the normalized name, so inserting both
      // would be rejected as a duplicate and take the whole save down.
      final result = plan(['Machine Dips', 'machine  dips']);
      expect(result.toCreate, hasLength(1));
      expect(result.toCreate.values.single, ['Machine Dips', 'machine  dips']);
    });

    test('names are trimmed and deduplicated', () {
      final result = plan([
        '  Développé couché ',
        'Développé couché',
      ], catalog: _catalog);
      expect(result.resolved, {'Développé couché': 'bench'});
    });

    test('blank names are dropped, never queued', () {
      final result = plan(['', '   ', 'Squat']);
      expect(result.resolved, isEmpty);
      expect(result.toCreate.keys, ['Squat']);
    });

    test('an empty input resolves to nothing at all', () {
      final result = plan([]);
      expect(result.resolved, isEmpty);
      expect(result.toCreate, isEmpty);
    });

    test('one batch can span all three outcomes', () {
      final result = plan(
        ['Panca piana', 'Machine Dips', 'Hack squat'],
        catalog: _catalog,
        own: {exerciseNameKey('machine dips'): 'mine'},
      );
      expect(result.resolved, {'Panca piana': 'bench', 'Machine Dips': 'mine'});
      expect(result.toCreate.keys, ['Hack squat']);
    });
  });
}
