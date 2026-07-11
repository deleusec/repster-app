import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/auth/presentation/change_password_screen.dart';
import 'package:repster/i18n/translations.g.dart';

class _FakeAuth extends AuthController {
  _FakeAuth({this.error});

  final AppException? error;
  String? capturedCurrent;
  String? capturedNew;

  @override
  Future<AuthUser?> build() async =>
      AuthUser(id: 'u1', email: 'alex@example.com', joinedAt: DateTime(2026));

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    capturedCurrent = currentPassword;
    capturedNew = newPassword;
    if (error != null) throw error!;
  }
}

Widget _wrap(_FakeAuth auth) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const Scaffold(body: Center(child: Text('home'))),
      ),
      GoRoute(path: '/change', builder: (_, _) => const ChangePasswordScreen()),
    ],
  );
  return ProviderScope(
    overrides: [authControllerProvider.overrideWith(() => auth)],
    child: MaterialApp.router(theme: AppTheme.dark(), routerConfig: router),
  );
}

Future<void> _openScreen(WidgetTester tester, _FakeAuth auth) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(_wrap(auth));
  await tester.pumpAndSettle();
  // Navigate to the screen (push → canPop true, to test going back).
  final ctx = tester.element(find.text('home'));
  unawaited(GoRouter.of(ctx).push('/change'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('renders the three password fields and submit button', (
    tester,
  ) async {
    await _openScreen(tester, _FakeAuth());

    expect(tester.takeException(), isNull);
    expect(find.text(t.auth.changePassword.title), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.text(t.auth.changePassword.submit), findsOneWidget);
  });

  testWidgets('blocks submit and shows error when new password is too short', (
    tester,
  ) async {
    final auth = _FakeAuth();
    await _openScreen(tester, auth);

    await tester.enterText(find.byType(TextField).at(0), 'oldpassword');
    await tester.enterText(find.byType(TextField).at(1), 'short');
    await tester.enterText(find.byType(TextField).at(2), 'short');
    await tester.ensureVisible(find.text(t.auth.changePassword.submit));
    await tester.pumpAndSettle();
    await tester.tap(find.text(t.auth.changePassword.submit));
    await tester.pumpAndSettle();

    expect(find.text(t.auth.validators.passwordMin), findsWidgets);
    expect(auth.capturedNew, isNull); // changePassword never called
  });

  testWidgets('submits new password and pops on success', (tester) async {
    final auth = _FakeAuth();
    await _openScreen(tester, auth);

    await tester.enterText(find.byType(TextField).at(0), 'oldpassword');
    await tester.enterText(find.byType(TextField).at(1), 'newpassword123');
    await tester.enterText(find.byType(TextField).at(2), 'newpassword123');
    await tester.ensureVisible(find.text(t.auth.changePassword.submit));
    await tester.pumpAndSettle();
    await tester.tap(find.text(t.auth.changePassword.submit));
    await tester.pumpAndSettle();

    expect(auth.capturedCurrent, 'oldpassword');
    expect(auth.capturedNew, 'newpassword123');
    // Back to home after success.
    expect(find.byType(ChangePasswordScreen), findsNothing);
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('shows a field error when current password is wrong', (
    tester,
  ) async {
    final auth = _FakeAuth(
      error: const AppAuthException(
        'bad',
        reason: AuthFailureReason.invalidCredentials,
      ),
    );
    await _openScreen(tester, auth);

    await tester.enterText(find.byType(TextField).at(0), 'wrongpassword');
    await tester.enterText(find.byType(TextField).at(1), 'newpassword123');
    await tester.enterText(find.byType(TextField).at(2), 'newpassword123');
    await tester.ensureVisible(find.text(t.auth.changePassword.submit));
    await tester.pumpAndSettle();
    await tester.tap(find.text(t.auth.changePassword.submit));
    await tester.pumpAndSettle();

    expect(find.text(t.auth.changePassword.currentIncorrect), findsOneWidget);
    // Stays on the screen.
    expect(find.byType(ChangePasswordScreen), findsOneWidget);
  });
}
