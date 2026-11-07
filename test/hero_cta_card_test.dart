import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/dashboard/presentation/widgets/hero_cta_card.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';

Template _template() => Template(
  id: 't',
  name: 'Push',
  description: '',
  tags: const [MuscleGroup.chest],
  slots: const [
    TemplateSlot(
      slotId: 's0',
      order: 0,
      supersetWithNext: false,
      variants: [
        TemplateExercise(
          id: 'e0',
          name: 'Bench',
          sets: 4,
          reps: 8,
          tempo: '3-1-2-0',
          restTime: 120,
          notes: '',
          order: 0,
        ),
      ],
    ),
  ],
  isActive: true,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

Future<void> _pump(WidgetTester tester, {Template? suggested}) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        // A ListView, like the dashboard: bounded width, unbounded height —
        // where a filled button used to blow up on the web's first layout.
        body: ListView(
          children: [
            HeroCtaCard(suggested: suggested, onStart: (_) {}, onCreate: () {}),
          ],
        ),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 400));
}

void main() {
  testWidgets('lays out with a suggested template', (tester) async {
    await _pump(tester, suggested: _template());
    expect(tester.takeException(), isNull);
    expect(find.text('Push'), findsOne);
  });

  testWidgets('lays out with no template to suggest', (tester) async {
    await _pump(tester);
    expect(tester.takeException(), isNull);
  });

  testWidgets("is lit in the suggested template's muscle colour", (
    tester,
  ) async {
    await _pump(tester, suggested: _template());
    final surface = tester.widget<EdgeLitSurface>(
      find.descendant(
        of: find.byType(HeroCtaCard),
        matching: find.byType(EdgeLitSurface),
      ),
    );
    expect(surface.accent, MuscleGroup.chest.accent);
    expect(surface.radius, AppRadius.sheet);
  });

  testWidgets('says how long the session should take', (tester) async {
    await _pump(tester, suggested: _template());
    expect(find.textContaining('min'), findsOneWidget);
  });
}
