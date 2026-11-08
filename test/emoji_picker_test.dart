import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repster/core/emoji/fluent_emoji.dart';
import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/features/templates/presentation/widgets/emoji_picker_sheet.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/l10n/fluent_emoji_l10n.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.fr));

  Future<void> pumpField(WidgetTester tester, List<FluentEmoji> picks) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: EmojiField(value: FluentEmojis.fire, onChanged: picks.add),
          ),
        ),
      ),
    );
  }

  Future<void> open(WidgetTester tester) async {
    await tester.tap(find.text(t.templates.emojiPicker.change));
    await tester.pumpAndSettle();
  }

  testWidgets('field shows the current emoji name and opens the sheet', (
    tester,
  ) async {
    await pumpField(tester, []);
    expect(find.text('Flamme'), findsOneWidget);
    await open(tester);
    expect(find.text(t.templates.emojiPicker.title), findsOneWidget);
    expect(
      find.bySemanticsLabel(FluentEmojiGroup.sport.localizedLabel),
      findsNothing,
    );
    expect(
      find.text(FluentEmojiGroup.sport.localizedLabel.toUpperCase()),
      findsOneWidget,
    );
  });

  testWidgets('the chosen emoji is the selected cell', (tester) async {
    await pumpField(tester, []);
    await open(tester);
    await tester.enterText(find.byType(TextField), 'flamme');
    await tester.pumpAndSettle();
    expect(
      tester.getSemantics(
        find.bySemanticsLabel(FluentEmojis.fire.localizedLabel),
      ),
      containsSemantics(isSelected: true),
    );
    expect(
      tester.getSemantics(
        find.bySemanticsLabel(FluentEmojis.heartOnFire.localizedLabel),
      ),
      containsSemantics(isSelected: false),
    );
  });

  testWidgets('search folds accents and matches the English key', (
    tester,
  ) async {
    await pumpField(tester, []);
    await open(tester);
    await tester.enterText(find.byType(TextField), 'GORILLE');
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Gorille'), findsOneWidget);
    expect(find.bySemanticsLabel('Lion'), findsNothing);

    await tester.enterText(find.byType(TextField), 'eagle');
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Aigle'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'zzzzzz-nope');
    await tester.pumpAndSettle();
    expect(find.text(t.templates.emojiPicker.noResults), findsOneWidget);
  });

  testWidgets('tapping a cell reports it and closes the sheet', (tester) async {
    final picks = <FluentEmoji>[];
    await pumpField(tester, picks);
    await open(tester);
    await tester.enterText(find.byType(TextField), 'gorille');
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Gorille'));
    await tester.pumpAndSettle();
    expect(picks, [FluentEmojis.gorilla]);
    expect(find.text(t.templates.emojiPicker.title), findsNothing);
  });

  testWidgets('re-picking the current emoji is a no-op', (tester) async {
    final picks = <FluentEmoji>[];
    await pumpField(tester, picks);
    await open(tester);
    await tester.enterText(find.byType(TextField), 'flamme');
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Flamme'));
    await tester.pumpAndSettle();
    expect(picks, isEmpty);
  });
}
