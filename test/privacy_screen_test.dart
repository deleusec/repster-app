import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/features/legal/presentation/privacy_screen.dart';

void main() {
  testWidgets('PrivacyScreen renders header, sections and content', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.dark(), home: const PrivacyScreen()),
    );
    await tester.pumpAndSettle();

    // No layout/build exception.
    expect(tester.takeException(), isNull);

    // Header + intro kicker (policy body is English-only).
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Last updated'), findsOneWidget);
    expect(find.text('April 3, 2026'), findsOneWidget);

    // Expected sections (one lower in the scroll to validate scrolling).
    expect(find.text('1. Data controller'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('11. Contact'),
      400,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('11. Contact'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
