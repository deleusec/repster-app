import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/shared/widgets/back_nav_bar.dart';

Future<void> _pump(WidgetTester tester, Widget child) => tester.pumpWidget(
  MaterialApp(
    theme: AppTheme.dark(),
    home: Scaffold(
      body: Padding(padding: const EdgeInsets.all(16), child: child),
    ),
  ),
);

void main() {
  testWidgets('plain bar shows only the back button', (tester) async {
    var backs = 0;
    await _pump(tester, BackNavBar(onBack: () => backs++));

    expect(find.byType(NavIconButton), findsOneWidget);
    expect(find.byIcon(LucideIcons.chevronLeft), findsOneWidget);

    await tester.tap(find.byType(NavIconButton));
    expect(backs, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('title and action each get their own button', (tester) async {
    var backs = 0;
    var actions = 0;
    await _pump(
      tester,
      BackNavBar(
        onBack: () => backs++,
        title: 'PROFILE',
        actionIcon: LucideIcons.pencil,
        onAction: () => actions++,
      ),
    );

    expect(find.text('PROFILE'), findsOneWidget);
    expect(find.byType(NavIconButton), findsNWidgets(2));

    await tester.tap(find.byIcon(LucideIcons.chevronLeft));
    await tester.tap(find.byIcon(LucideIcons.pencil));
    expect(backs, 1);
    expect(actions, 1);
  });

  testWidgets('a title with no action stays centred', (tester) async {
    await _pump(tester, BackNavBar(onBack: () {}, title: 'LEGAL'));

    // The spacer opposite the back button is what keeps it centred; without
    // it the label drifts right by the width of one button.
    final bar = tester.getRect(find.byType(BackNavBar));
    final label = tester.getRect(find.text('LEGAL'));
    expect(
      label.center.dx,
      moreOrLessEquals(bar.center.dx, epsilon: 0.5),
      reason: 'the label must sit on the bar axis',
    );
  });
}
