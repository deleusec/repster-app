import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:repster/core/emoji/fluent_emoji.dart';
import 'package:repster/core/emoji/legacy_tags.dart';
import 'package:repster/features/dashboard/data/workout_session_summary_dto.dart';
import 'package:repster/features/templates/application/template_editor_controller.dart';
import 'package:repster/features/templates/data/template_dto.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/l10n/fluent_emoji_l10n.dart';

void main() {
  group('FluentEmoji catalogue', () {
    test('keys are unique kebab-case and resolve back', () {
      final keys = FluentEmoji.all.map((e) => e.key).toList();
      expect(keys.toSet(), hasLength(keys.length));
      for (final e in FluentEmoji.all) {
        expect(e.key, matches(RegExp(r'^[a-z0-9]+(-[a-z0-9]+)*$')));
        expect(FluentEmoji.fromKey(e.key), same(e));
      }
      expect(FluentEmoji.fromKey(null), isNull);
      expect(FluentEmoji.fromKey('not-an-emoji'), isNull);
    });

    test('every entry ships its asset, and no asset is orphaned', () {
      final dir = Directory('assets/emoji/fluent');
      final files = dir
          .listSync()
          .whereType<File>()
          .map((f) => f.uri.pathSegments.last)
          .toSet();
      for (final e in FluentEmoji.all) {
        expect(files, contains('${e.key}.webp'), reason: e.key);
      }
      expect(files, hasLength(FluentEmoji.all.length));
    });

    test('every entry is named in every locale', () {
      for (final locale in AppLocale.values) {
        final raw = File(
          'lib/i18n/emoji_${locale.languageCode}.i18n.json',
        ).readAsStringSync();
        final labels =
            (jsonDecode(raw) as Map<String, dynamic>)['labels']
                as Map<String, dynamic>;
        for (final e in FluentEmoji.all) {
          expect(labels[e.key], isNotEmpty, reason: '${locale.name} ${e.key}');
        }
        expect(labels, hasLength(FluentEmoji.all.length));
      }
    });

    test('picker order groups the catalogue by family', () {
      var last = -1;
      for (final e in FluentEmoji.all) {
        expect(e.group.index, greaterThanOrEqualTo(last));
        last = e.group.index;
      }
      expect(
        FluentEmoji.inGroup(FluentEmojiGroup.sport),
        contains(FluentEmojis.personLiftingWeights),
      );
    });

    test('labels follow the locale', () {
      LocaleSettings.setLocaleSync(AppLocale.fr);
      expect(FluentEmojis.fire.localizedLabel, 'Flamme');
      expect(FluentEmojiGroup.sport.localizedLabel, 'Sport & entraînement');
      LocaleSettings.setLocaleSync(AppLocale.en);
      expect(FluentEmojis.fire.localizedLabel, 'Fire');
    });
  });

  group('legacyEmojiForTags', () {
    test('maps the first legacy tag, else the old "custom" target', () {
      expect(legacyEmojiForTags(['glutes', 'chest']), FluentEmojis.peach);
      expect(legacyEmojiForTags(['chest']), FluentEmojis.shield);
      expect(legacyEmojiForTags(['custom']), FluentEmojis.bullseye);
      expect(legacyEmojiForTags(['bogus']), FluentEmojis.bullseye);
      expect(legacyEmojiForTags([]), FluentEmojis.bullseye);
      expect(legacyEmojiForTags(null), FluentEmojis.bullseye);
    });
  });

  group('DTOs', () {
    test('TemplateDto reads the key and tolerates unknown or null ones', () {
      Map<String, dynamic> row(Object? emoji) => {
        'id': 't',
        'name': 'X',
        'tags': ['back'],
        'emoji': emoji,
        'created_at': '2026-01-01T00:00:00.000Z',
        'updated_at': '2026-01-01T00:00:00.000Z',
        'template_exercises': <dynamic>[],
      };
      expect(TemplateDto.fromRow(row('fire')).emoji, FluentEmojis.fire);
      expect(TemplateDto.fromRow(row(null)).emoji, FluentEmojis.eagle);
      expect(TemplateDto.fromRow(row('gone')).emoji, FluentEmojis.eagle);
    });

    test('WorkoutSessionSummaryDto carries the snapshot', () {
      final summary = WorkoutSessionSummaryDto.fromRow({
        'id': 's',
        'template_name': 'X',
        'started_at': '2026-01-01T00:00:00.000Z',
        'tags': <dynamic>[],
        'emoji': 'trophy',
        'session_exercises': <dynamic>[],
      });
      expect(summary.emoji, FluentEmojis.trophy);
    });
  });

  group('TemplateEditorState', () {
    test('a new template starts on the default emoji', () {
      expect(TemplateEditorState.empty().emoji, kDefaultSessionEmoji);
    });

    test('hydrating keeps the template emoji', () {
      final template = Template(
        id: 't',
        name: 'Legs',
        description: '',
        slots: const [],
        isActive: true,
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
        emoji: FluentEmojis.mountain,
      );
      expect(
        TemplateEditorState.fromTemplate(template).emoji,
        FluentEmojis.mountain,
      );
    });
  });
}
