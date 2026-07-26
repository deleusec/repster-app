import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/settings/presentation/settings_screen.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/i18n/translations.g.dart';

class _OkAuth extends AuthController {
  @override
  Future<AuthUser?> build() async => AuthUser(
    id: 'u1',
    email: 'alex@example.com',
    joinedAt: DateTime(2026),
    fullName: 'Alex Martin',
  );
}

class _FailingAuth extends AuthController {
  @override
  Future<AuthUser?> build() async => throw Exception('auth down');
}

Future<void> _pump(WidgetTester tester, AuthController Function() auth) async {
  tester.view.physicalSize = const Size(390, 1400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(auth),
        // The two counts are decoration; leave them empty so the test speaks
        // only about the user.
        templatesControllerProvider.overrideWith(_EmptyTemplates.new),
        historyControllerProvider.overrideWith(_EmptyHistory.new),
      ],
      child: MaterialApp(theme: AppTheme.dark(), home: const SettingsScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

class _EmptyTemplates extends TemplatesController {
  @override
  Future<List<Template>> build() async => const [];
}

class _EmptyHistory extends HistoryController {
  @override
  Future<List<WorkoutSessionSummary>> build() async => const [];
}

void main() {
  testWidgets('a loaded user gets the profile card', (tester) async {
    await _pump(tester, _OkAuth.new);

    expect(find.text('Alex Martin'), findsOneWidget);
    expect(find.text(t.settings.profileUnavailable), findsNothing);
  });

  testWidgets('a failing user says so instead of vanishing', (tester) async {
    await _pump(tester, _FailingAuth.new);

    // The bug this replaces: the card silently disappeared, which reads as
    // "you are signed out" rather than "we could not load you".
    expect(find.text(t.settings.profileUnavailable), findsOneWidget);
    expect(find.text(t.common.actions.retry), findsOneWidget);
  });

  testWidgets('a failing user does not lock the rest of the screen', (
    tester,
  ) async {
    await _pump(tester, _FailingAuth.new);

    // Signing out is exactly what someone with a broken session needs, so it
    // must survive the failure — along with the legal pages and the language
    // picker.
    expect(find.text(t.settings.logout.action), findsOneWidget);
    expect(find.text(t.settings.rows.privacy), findsOneWidget);
    expect(find.text(t.settings.rows.language), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
