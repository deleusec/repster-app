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
  Consistency? consistency,
  DateTime? now,
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
              consistency: consistency ?? _consistency(),
              hasHistory: hasHistory,
              now: now,
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

/// Cells painted as a trained day: anything but the empty grey or the
/// transparent future.
int _litCells(WidgetTester tester) {
  final primary = ThemeData().colorScheme.primary;
  var lit = 0;
  for (final container in tester.widgetList<Container>(_cells())) {
    final color = (container.decoration as BoxDecoration?)?.color;
    if (color != null && color.withValues(alpha: 1) == primary) lit++;
  }
  return lit;
}

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

  group('across a daylight-saving change', () {
    // Winter time starts 2026-10-25. Viewed after it, days trained before it
    // used to show grey: the cells were stepped with Durations and sat at
    // 01:00, missing the midnight keys. Only observable under a DST timezone.
    testWidgets('still lights the days trained before the change', (
      tester,
    ) async {
      final now = DateTime(2026, 11, 7, 10);
      final consistency = Consistency.fromDates([
        DateTime(2026, 10, 14, 18),
        DateTime(2026, 10, 20, 7),
        DateTime(2026, 11, 3, 19),
      ], now: now);
      await _pump(tester, width: 390, consistency: consistency, now: now);
      expect(_litCells(tester), 3);
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
