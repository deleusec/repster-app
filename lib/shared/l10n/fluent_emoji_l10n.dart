import 'package:repster/core/emoji/fluent_emoji.dart';
import 'package:repster/i18n/translations.g.dart';

/// Translated names of the Fluent catalogue, kept out of `core/emoji` so the
/// catalogue stays pure Dart.
extension FluentEmojiL10n on FluentEmoji {
  /// Falls back on the key for an emoji the locale file does not name yet.
  String get localizedLabel => t.emoji.labels[key] ?? key;
}

extension FluentEmojiGroupL10n on FluentEmojiGroup {
  String get localizedLabel => t.emoji.groups[name] ?? name;
}
