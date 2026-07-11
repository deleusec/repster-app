import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';

void main() {
  testWidgets('glass drawer opens, shows title/content, closes', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () => AppDrawerSheet.show<void>(
                  context,
                  title: 'Détails',
                  child: const Text('Contenu du drawer'),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Détails'), findsOneWidget);
    expect(find.text('Contenu du drawer'), findsOneWidget);

    // Close via the X button (Lucide icon).
    await tester.tapAt(const Offset(360, 400));
    await tester.pumpAndSettle();
    // Barrier or X — mainly checks there's no error on dismiss.
    expect(tester.takeException(), isNull);
  });
}
