import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repster/core/emoji/fluent_emoji.dart';

import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/presentation/templates_screen.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/pressable.dart';

class _OneTemplate extends TemplatesController {
  @override
  Future<List<Template>> build() async => [
    Template(
      id: 't1',
      name: 'Push Day',
      description: '',
      emoji: FluentEmojis.fire,
      slots: const [],
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
      isActive: true,
    ),
  ];
}

/// Width of the tappable box behind a header chip label.
Size _chipSize(WidgetTester tester, String label) => tester.getSize(
  find.ancestor(of: find.text(label), matching: find.byType(Pressable)).first,
);

Future<void> _pump(WidgetTester tester) async {
  // Wider than a phone on purpose. This test is about the header, and the
  // cards below it overflow under the test fallback font, whose glyphs are
  // wider than Manrope's — noise that has nothing to do with what is asserted
  // here.
  tester.view.physicalSize = const Size(700, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [templatesControllerProvider.overrideWith(_OneTemplate.new)],
      child: MaterialApp(theme: AppTheme.dark(), home: const TemplatesScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  tearDown(() => LocaleSettings.setLocaleSync(AppLocale.en));

  testWidgets('the two header actions are the same size', (tester) async {
    LocaleSettings.setLocaleSync(AppLocale.fr);
    await _pump(tester);

    final manage = _chipSize(tester, t.templates.list.manage);
    final create = _chipSize(tester, t.templates.list.newAction);
    expect(manage, create);
  });

  testWidgets('still equal where the labels are not', (tester) async {
    // "Gestionar" against "Crear" — nearly twice as long. Matching the words
    // by hand would have fixed French and left this one lopsided.
    LocaleSettings.setLocaleSync(AppLocale.es);
    await _pump(tester);

    final manage = _chipSize(tester, t.templates.list.manage);
    final create = _chipSize(tester, t.templates.list.newAction);
    expect(create.width, manage.width);
    expect(create.height, manage.height);
  });

  testWidgets('the action says what it does, not what it is', (tester) async {
    LocaleSettings.setLocaleSync(AppLocale.fr);
    await _pump(tester);

    // A verb, like its neighbour — "Nouvelle" left the noun unsaid.
    expect(find.text('Créer'), findsOneWidget);
    expect(find.text('Gérer'), findsOneWidget);
  });
}
