import 'package:flutter_test/flutter_test.dart';

import 'package:repster/features/dashboard/domain/next_session.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_slot.dart';

Template _template(String id) => Template(
  id: id,
  name: id.toUpperCase(),
  description: '',
  tags: const [],
  slots: const <TemplateSlot>[],
  isActive: true,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

WorkoutSessionSummary _session(String? templateId) => WorkoutSessionSummary(
  id: 's-$templateId',
  templateId: templateId,
  templateName: 'Session',
  startedAt: DateTime(2026, 7, 30),
  durationSeconds: 3600,
  totalTonnageKg: 1000,
  totalSets: 12,
  tags: const [],
);

void main() {
  final program = [_template('a'), _template('b'), _template('c')];

  test('no template at all → nothing to suggest', () {
    expect(suggestNextTemplate(const [], [_session('a')]), isNull);
  });

  test('no session yet → first of the program', () {
    expect(suggestNextTemplate(program, const [])?.id, 'a');
  });

  test('follows the program order', () {
    expect(suggestNextTemplate(program, [_session('a')])?.id, 'b');
    expect(suggestNextTemplate(program, [_session('b')])?.id, 'c');
  });

  test('wraps around after the last one', () {
    expect(suggestNextTemplate(program, [_session('c')])?.id, 'a');
  });

  test('only the most recent session counts', () {
    final sessions = [_session('b'), _session('c'), _session('a')];
    expect(suggestNextTemplate(program, sessions)?.id, 'c');
  });

  test('template gone (deleted or deactivated) → restart the cycle', () {
    expect(suggestNextTemplate(program, [_session(null)])?.id, 'a');
    expect(suggestNextTemplate(program, [_session('gone')])?.id, 'a');
  });
}
