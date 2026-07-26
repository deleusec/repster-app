import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/features/legal/presentation/terms_screen.dart';

void main() {
  testWidgets('TermsScreen renders header, sections and content', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.dark(), home: const TermsScreen()),
    );
    await tester.pumpAndSettle();

    // No layout/build exception.
    expect(tester.takeException(), isNull);

    // Header + intro kicker (document body is English-only).
    expect(find.text('Terms of Use'), findsOneWidget);
    expect(find.text('Last updated'), findsOneWidget);
    expect(find.text('July 26, 2026'), findsOneWidget);

    // The health disclaimer is the clause that must never silently drop out.
    expect(find.text('1. Purpose and acceptance'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('6. Health and safety'),
      400,
      scrollable: find.byType(Scrollable),
    );
    expect(
      find.textContaining('not a coach and not a', findRichText: true),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(
      find.text('17. Contact'),
      400,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('17. Contact'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
