import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_theme.dart';

/// Opens the stock Material date picker under the app theme.
Future<void> _open(WidgetTester tester, ThemeData theme) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: theme,
      home: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () => showDatePicker(
              context: context,
              initialDate: DateTime(2026, 8, 15),
              firstDate: DateTime(2000),
              lastDate: DateTime(2026, 12, 31),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  for (final (label, theme) in [
    ('dark', AppTheme.dark()),
    ('light', AppTheme.light()),
  ]) {
    testWidgets('$label: date picker picks up the app theme', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await _open(tester, theme);
      expect(tester.takeException(), isNull);

      final picker = tester.widget<DatePickerDialog>(
        find.byType(DatePickerDialog),
      );
      expect(picker, isNotNull);

      final t = theme.datePickerTheme;
      final scheme = theme.colorScheme;

      // The surface must match our popover, not M3's default elevation tint.
      expect(t.backgroundColor, scheme.surfaceContainerHighest);
      expect(t.surfaceTintColor, Colors.transparent);
      expect(t.elevation, 0);
      // The stock filled primary header band is what looked off-brand.
      expect(t.headerBackgroundColor, Colors.transparent);

      // Selection uses the brand colour, in both directions.
      const selected = <WidgetState>{WidgetState.selected};
      expect(t.dayBackgroundColor?.resolve(selected), scheme.primary);
      expect(t.dayForegroundColor?.resolve(selected), scheme.onPrimary);
      expect(t.yearBackgroundColor?.resolve(selected), scheme.primary);

      // A plain day stays readable, a disabled one recedes.
      const none = <WidgetState>{};
      const disabled = <WidgetState>{WidgetState.disabled};
      expect(t.dayForegroundColor?.resolve(none), isNot(scheme.primary));
      expect(
        t.dayForegroundColor?.resolve(disabled),
        isNot(t.dayForegroundColor?.resolve(none)),
      );

      // Radii come from the DS roles, not Material's circles.
      final dayShape = t.dayShape?.resolve(none) as RoundedRectangleBorder?;
      expect(
        dayShape?.borderRadius,
        BorderRadius.circular(AppRadius.controlSm),
      );
      final shape = t.shape as RoundedRectangleBorder?;
      expect(shape?.borderRadius, BorderRadius.circular(AppRadius.sheet));
    });
  }
}
