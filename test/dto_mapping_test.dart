import 'package:flutter_test/flutter_test.dart';
import 'package:repster/features/contact/data/contact_request_dto.dart';
import 'package:repster/features/dashboard/data/in_progress_session_info_dto.dart';
import 'package:repster/features/dashboard/data/workout_session_summary_dto.dart';
import 'package:repster/features/session/data/workout_session_dto.dart';
import 'package:repster/features/templates/data/template_dto.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

void main() {
  group('WorkoutSessionSummaryDto.fromRow', () {
    test('keeps holds out of the tonnage and maps tags', () {
      final row = <String, dynamic>{
        'id': 's1',
        'template_name': 'Push',
        'started_at': '2026-01-01T10:00:00.000Z',
        'duration_seconds': 3600,
        'tags': ['chest', 'triceps', 'bogus'],
        'session_exercises': [
          {
            'is_time_based': false,
            'session_sets': [
              {
                'completed_at': '2026-01-01T10:05:00.000Z',
                'reps_performed': 10,
                'weight_kg': 50,
              },
              // Unvalidated set: ignored.
              {'completed_at': null, 'reps_performed': 8, 'weight_kg': 50},
            ],
          },
          {
            'is_time_based': true,
            'session_sets': [
              {
                'completed_at': '2026-01-01T10:10:00.000Z',
                'duration_performed_seconds': 30,
                'weight_kg': 20,
              },
            ],
          },
        ],
      };

      final summary = WorkoutSessionSummaryDto.fromRow(row);
      expect(summary.id, 's1');
      expect(summary.templateName, 'Push');
      expect(summary.durationSeconds, 3600);
      expect(summary.totalSets, 2);
      // The 30 s × 20 kg hold used to be added here, making it worth more than
      // the 10 × 50 kg set.
      expect(summary.totalTonnageKg, 10 * 50);
      expect(summary.timeUnderTensionSec, 30);
      expect(summary.tags, [MuscleGroup.chest, MuscleGroup.triceps]);
    });

    test('defaults on a minimal row', () {
      final row = <String, dynamic>{
        'id': 's2',
        'started_at': '2026-01-01T10:00:00.000Z',
      };
      final summary = WorkoutSessionSummaryDto.fromRow(row);
      expect(summary.templateName, '');
      expect(summary.durationSeconds, 0);
      expect(summary.totalSets, 0);
      expect(summary.totalTonnageKg, 0);
      expect(summary.timeUnderTensionSec, 0);
      expect(summary.tags, isEmpty);
    });
  });

  group('WorkoutSessionDto.fromRow', () {
    test('sorts exercises by position and sets by set_number', () {
      final row = <String, dynamic>{
        'id': 's1',
        'template_id': 't1',
        'template_name': 'Push',
        'started_at': '2026-01-01T10:00:00.000Z',
        'duration_seconds': 100,
        'tags': ['back'],
        'notes': 'hi',
        'session_exercises': [
          {
            'id': 'e2',
            'name': 'B',
            'position': 1,
            'is_time_based': false,
            'notes': '',
            'session_sets': [
              {
                'id': 'x2',
                'set_number': 2,
                'reps_target': 10,
                'reps_performed': 9,
                'weight_kg': 40,
                'completed_at': '2026-01-01T10:06:00.000Z',
              },
              {
                'id': 'x1',
                'set_number': 1,
                'reps_target': 10,
                'reps_performed': 10,
                'weight_kg': 40,
                'completed_at': null,
              },
            ],
          },
          {
            'id': 'e1',
            'name': 'A',
            'position': 0,
            'is_time_based': false,
            'session_sets': <dynamic>[],
          },
        ],
      };

      final session = WorkoutSessionDto.fromRow(row);
      expect(session.templateId, 't1');
      expect(session.notes, 'hi');
      expect(session.exercises.map((e) => e.name), ['A', 'B']);

      final b = session.exercises[1];
      expect(b.sets.map((s) => s.setNumber), [1, 2]);
      expect(b.sets[0].completed, isFalse, reason: 'completed_at null');
      expect(b.sets[1].completed, isTrue);
      expect(b.sets[1].actualReps, 9);
    });
  });

  group('TemplateDto.fromRow', () {
    test('groups/sorts slots and variants', () {
      final row = <String, dynamic>{
        'id': 't1',
        'name': 'PPL',
        'description': null,
        'tags': ['chest'],
        'is_active': true,
        'created_at': '2026-01-01T00:00:00.000Z',
        'updated_at': '2026-01-02T00:00:00.000Z',
        'template_exercises': [
          {
            'id': 'te3',
            'slot_id': 's2',
            'position': 1,
            'variant_position': 1,
            'superset_with_next': false,
            'sets_count': 4,
            'reps_target': 6,
            'tempo': '3-1-1-0',
            'rest_seconds': 120,
            'notes': 'n',
            'is_time_based': false,
            'exercises': {'name': 'Squat'},
          },
          {
            'id': 'te2',
            'slot_id': 's2',
            'position': 1,
            'variant_position': 0,
            'superset_with_next': false,
            'exercises': {'name': 'Leg Press'},
          },
          {
            'id': 'te1',
            'slot_id': 's1',
            'position': 0,
            'variant_position': 0,
            'superset_with_next': true,
            'exercises': {'name': 'Bench'},
          },
        ],
      };

      final template = TemplateDto.fromRow(row);
      expect(template.description, '');
      expect(template.tags, [MuscleGroup.chest]);
      expect(template.slots, hasLength(2));

      // Sorted by min(position): s1 (0) before s2 (1).
      final s1 = template.slots[0];
      expect(s1.slotId, 's1');
      expect(s1.supersetWithNext, isTrue);
      expect(s1.variants.map((v) => v.name), ['Bench']);

      final s2 = template.slots[1];
      expect(s2.slotId, 's2');
      expect(s2.supersetWithNext, isFalse);
      // Variants sorted by variant_position.
      expect(s2.variants.map((v) => v.name), ['Leg Press', 'Squat']);

      final squat = s2.variants[1];
      expect(squat.sets, 4);
      expect(squat.reps, 6);
      expect(squat.tempo, '3-1-1-0');
      expect(squat.restTime, 120);

      // Defaults applied to the minimal variant.
      final legPress = s2.variants[0];
      expect(legPress.sets, 3);
      expect(legPress.reps, 10);
      expect(legPress.tempo, '2-0-2-0');
      expect(legPress.restTime, 90);
    });

    test('missing slot_id → each row becomes its own slot', () {
      final row = <String, dynamic>{
        'id': 't1',
        'name': 'X',
        'tags': <dynamic>[],
        'created_at': '2026-01-01T00:00:00.000Z',
        'updated_at': '2026-01-01T00:00:00.000Z',
        'template_exercises': [
          {
            'id': 'te1',
            'position': 0,
            'exercises': {'name': 'A'},
          },
        ],
      };
      final template = TemplateDto.fromRow(row);
      expect(template.slots, hasLength(1));
      expect(template.slots.first.slotId, 'te1');
    });
  });

  group('InProgressSessionInfoDto.fromRow', () {
    test('maps fields and accepts null template_id', () {
      final row = <String, dynamic>{
        'id': 's1',
        'template_id': null,
        'template_name': 'Push',
        'started_at': '2026-01-01T10:00:00.000Z',
      };
      final info = InProgressSessionInfoDto.fromRow(row);
      expect(info.sessionId, 's1');
      expect(info.templateId, isNull);
      expect(info.templateName, 'Push');
    });
  });

  group('ContactRequestDto.toInsert', () {
    test('trims text fields and keeps user_id / category', () {
      final payload = ContactRequestDto.toInsert(
        userId: 'u1',
        name: '  Bob  ',
        email: '  b@x.io ',
        category: 'bug',
        message: '  coucou  ',
      );
      expect(payload, {
        'user_id': 'u1',
        'name': 'Bob',
        'email': 'b@x.io',
        'category': 'bug',
        'message': 'coucou',
      });
    });
  });
}
