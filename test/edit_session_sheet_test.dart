import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/features/history/presentation/widgets/edit_session_sheet.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/i18n/translations.g.dart';

WorkoutSession _session({int duration = 4276, String name = 'Foundation'}) {
  return WorkoutSession(
    id: 's1',
    templateId: 't1',
    templateName: name,
    startedAt: DateTime(2026, 7, 25, 9, 38),
    duration: duration,
    exercises: const [],
    tags: const [],
    notes: 'Bonne séance',
  );
}

/// Opens the sheet and returns the value it pops.
Future<SessionDetailsEdit?> _open(
  WidgetTester tester,
  WorkoutSession session,
) async {
  SessionDetailsEdit? result;
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                result = await showEditSessionSheet(context, session: session);
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return result;
}

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.fr));

  testWidgets('lays out and prefills from the session', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await _open(tester, _session());

    expect(tester.takeException(), isNull);
    expect(find.text('Foundation'), findsOneWidget);
    expect(find.text('Bonne séance'), findsOneWidget);
    // 4276 s = 1 h 11 min → split across the two duration fields.
    expect(find.text('1'), findsWidgets);
    expect(find.text('11'), findsWidgets);
  });

  testWidgets('refuses an empty title instead of saving', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await _open(tester, _session());

    await tester.enterText(find.text('Foundation'), '   ');
    await tester.tap(find.text(t.history.detail.edit.save));
    await tester.pumpAndSettle();

    expect(find.text(t.history.detail.edit.nameRequired), findsOneWidget);
    // Still open: nothing was popped.
    expect(find.text(t.history.detail.edit.title), findsOneWidget);
  });

  testWidgets('pops the edited values', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    SessionDetailsEdit? captured;
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () async {
                  captured = await showEditSessionSheet(
                    context,
                    session: _session(),
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.enterText(find.text('Foundation'), 'Foundation v2');
    await tester.tap(find.text(t.history.detail.edit.save));
    await tester.pumpAndSettle();

    expect(captured, isNotNull);
    expect(captured!.templateName, 'Foundation v2');
    expect(captured!.durationSeconds, 1 * 3600 + 11 * 60);
    expect(captured!.startedAt, DateTime(2026, 7, 25, 9, 38));
  });
}
