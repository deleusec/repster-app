import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/contact/data/contact_repository.dart';
import 'package:repster/features/contact/presentation/contact_screen.dart';
import 'package:repster/i18n/translations.g.dart';

class _FakeAuth extends AuthController {
  _FakeAuth(this._user);
  final AuthUser _user;
  @override
  Future<AuthUser?> build() async => _user;
}

class _MockContactRepository extends Mock implements ContactRepository {}

AuthUser _user() => AuthUser(
  id: 'u1',
  email: 'alex@example.com',
  joinedAt: DateTime(2026),
  fullName: 'Alex Martin',
);

Widget _wrap(ContactRepository repo) {
  return ProviderScope(
    overrides: [
      authControllerProvider.overrideWith(() => _FakeAuth(_user())),
      contactRepositoryProvider.overrideWithValue(repo),
    ],
    // Wait for auth to resolve (as in the app, where it's already loaded)
    // before mounting the screen: its initState prefills the fields.
    child: MaterialApp(
      theme: AppTheme.dark(),
      home: Consumer(
        builder: (context, ref, _) {
          final auth = ref.watch(authControllerProvider);
          return auth.hasValue
              ? const ContactScreen()
              : const SizedBox.shrink();
        },
      ),
    ),
  );
}

void main() {
  testWidgets('renders the form with categories, prefilled infos and counter', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_wrap(_MockContactRepository()));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text(t.contact.header.title), findsOneWidget);
    // SectionLabel renders in uppercase.
    expect(find.text(t.contact.sections.type.toUpperCase()), findsOneWidget);
    expect(
      find.text(t.contact.sections.yourInfo.toUpperCase()),
      findsOneWidget,
    );
    for (final label in [
      t.contact.categories.bug.label,
      t.contact.categories.feature.label,
      t.contact.categories.general.label,
      t.contact.categories.other.label,
    ]) {
      expect(find.text(label), findsWidgets);
    }
    // Info prefilled from the authenticated user.
    expect(find.text('Alex Martin'), findsOneWidget);
    expect(find.text('alex@example.com'), findsOneWidget);
    // Message counter.
    expect(find.text(t.contact.counter(current: 0, max: 1000)), findsOneWidget);
    // Contextual hint for the default category ("Message").
    expect(
      find.textContaining(t.contact.categories.general.guidance),
      findsOneWidget,
    );
  });

  testWidgets('character counter updates as the message is typed', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_wrap(_MockContactRepository()));
    await tester.pumpAndSettle();

    // 3rd field = message (name, email, message).
    await tester.enterText(find.byType(TextField).at(2), 'Bonjour!');
    await tester.pump();
    expect(find.text(t.contact.counter(current: 8, max: 1000)), findsOneWidget);
  });

  testWidgets('submits with selected category and shows success view', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final repo = _MockContactRepository();
    when(
      () => repo.submit(
        name: any(named: 'name'),
        email: any(named: 'email'),
        category: any(named: 'category'),
        message: any(named: 'message'),
      ),
    ).thenAnswer((_) async {});

    await tester.pumpWidget(_wrap(repo));
    await tester.pumpAndSettle();

    // Select the "Bug" category.
    await tester.tap(find.text(t.contact.categories.bug.label));
    await tester.pump();

    // Valid message (>= 10 characters).
    await tester.enterText(
      find.byType(TextField).at(2),
      'Le chrono ne démarre pas après la première série.',
    );
    await tester.pump();

    await tester.ensureVisible(find.text(t.contact.submit));
    await tester.pumpAndSettle();
    await tester.tap(find.text(t.contact.submit));
    await tester.pumpAndSettle();

    verify(
      () => repo.submit(
        name: 'Alex Martin',
        email: 'alex@example.com',
        category: 'bug',
        message: 'Le chrono ne démarre pas après la première série.',
      ),
    ).called(1);

    expect(find.text(t.contact.success.title), findsOneWidget);
    // Confirmation tailored to the "Bug" category.
    expect(
      find.textContaining(t.contact.categories.bug.successLine),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
