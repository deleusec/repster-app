import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repster/i18n/translations.g.dart';

/// Guardrail for i18n: locale switching via slang + rebuild under
/// [TranslationProvider]. Covers the mechanism used by `LanguageController`.
void main() {
  tearDown(() => LocaleSettings.setLocaleSync(AppLocale.en));

  test('supports the five configured locales, English as base', () {
    expect(AppLocale.values, contains(AppLocale.en));
    expect(AppLocaleUtils.supportedLocalesRaw, ['en', 'de', 'es', 'fr', 'it']);
  });

  test('t resolves to the current locale synchronously', () {
    LocaleSettings.setLocaleSync(AppLocale.en);
    expect(t.nav.settings, 'Settings');

    LocaleSettings.setLocaleSync(AppLocale.fr);
    expect(t.nav.settings, 'Réglages');

    LocaleSettings.setLocaleSync(AppLocale.de);
    expect(t.nav.settings, 'Einstellungen');
  });

  test('language names are localized (exonyms), not autonyms', () {
    LocaleSettings.setLocaleSync(AppLocale.en);
    expect(t.common.language.de, 'German');

    LocaleSettings.setLocaleSync(AppLocale.fr);
    expect(t.common.language.de, 'Allemand');
  });

  testWidgets('TranslationProvider rebuilds descendants on locale change', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    await tester.pumpWidget(
      TranslationProvider(
        child: Builder(
          builder: (context) {
            // Subscribe to the provider => rebuild on language change.
            TranslationProvider.of(context);
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Text(t.nav.settings),
            );
          },
        ),
      ),
    );
    expect(find.text('Settings'), findsOneWidget);

    await LocaleSettings.setLocale(AppLocale.fr);
    await tester.pump();
    expect(find.text('Réglages'), findsOneWidget);
  });
}
