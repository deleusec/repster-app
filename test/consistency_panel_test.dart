import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/features/dashboard/domain/consistency.dart';
import 'package:repster/features/dashboard/presentation/widgets/consistency_panel.dart';

final _now = DateTime(2026, 7, 22, 18);

Consistency _consistency() => Consistency.fromDates([
  for (var d = 1; d < 40; d += 3) _now.subtract(Duration(days: d)),
], now: _now);

Future<void> _pump(
  WidgetTester tester, {
  required double width,
  bool hasHistory = true,
}) async {
  tester.view.physicalSize = Size(width, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ConsistencyPanel(
              consistency: _consistency(),
              hasHistory: hasHistory,
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 300));
}

/// Width of the rendered grid — what the panel actually occupies.
double _gridWidth(WidgetTester tester) =>
    tester.getSize(find.byKey(heatmapGridKey)).width;

Finder _cells() => find.descendant(
  of: find.byKey(heatmapGridKey),
  matching: find.byType(Container),
);

void main() {
  group('heatmap layout', () {
    testWidgets('fits a phone without overflowing', (tester) async {
      await _pump(tester, width: 390);
      expect(tester.takeException(), isNull);
      // 18 columns × 7 days.
      expect(_cells(), findsNWidgets(126));
    });

    testWidgets('does not overflow a very narrow window', (tester) async {
      await _pump(tester, width: 280);
      expect(tester.takeException(), isNull);
    });

    testWidgets('spreads instead of stranding itself on a wide window', (
      tester,
    ) async {
      await _pump(tester, width: 1400);
      expect(tester.takeException(), isNull);
      // Cells cap at 18 and gaps at 7, so the grid stops growing — but it grew
      // past the old packed width (18×18 + 17×3 = 375) and is centred.
      final width = _gridWidth(tester);
      expect(width, greaterThan(375));
      expect(width, lessThan(18 * 18 + 17 * 7 + 1));
    });

    testWidgets('grows with the window, up to the cap', (tester) async {
      await _pump(tester, width: 390);
      final narrow = _gridWidth(tester);
      await _pump(tester, width: 700);
      expect(_gridWidth(tester), greaterThan(narrow));
    });
  });

  group('before the first session', () {
    testWidgets('says what will appear instead of showing empty cells', (
      tester,
    ) async {
      await _pump(tester, width: 390, hasHistory: false);
      expect(tester.takeException(), isNull);
      expect(find.byKey(heatmapGridKey), findsNothing);
      expect(find.textContaining(RegExp('.+')), findsWidgets);
    });
  });
}
