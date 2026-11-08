/// Closed catalogue of the Microsoft Fluent 3D emoji vendored under
/// `assets/emoji/fluent/` (MIT, `github.com/microsoft/fluentui-emoji`).
///
/// A template's picture is one of these, never a system emoji: the whole app
/// then shares one drawing style across platforms. The catalogue is generated
/// by `tool/fluent_emoji/fetch.py` from `tool/fluent_emoji/selection.txt`.
library;

part 'fluent_emoji_catalog.dart';

/// Browsing sections of the picker, in display order. Practical groupings,
/// not Unicode's.
enum FluentEmojiGroup {
  sport,
  body,
  energy,
  faces,
  hearts,
  animals,
  food,
  nature,
  places,
  objects,
}

class FluentEmoji {
  const FluentEmoji._(this.key, this.group, this.tint);

  /// Kebab-case Fluent name (`person-lifting-weights`): the persisted value
  /// and the asset's file name. Says what the image is, never its use.
  final String key;
  final FluentEmojiGroup group;

  /// ARGB colour that lights a surface behind this emoji (its dominant hue,
  /// made vivid). Computed by the generator from the image itself.
  final int tint;

  String get assetPath => 'assets/emoji/fluent/$key.webp';

  /// Every emoji, in picker order (grouped by [group]).
  static const List<FluentEmoji> all = _catalog;

  static final Map<String, FluentEmoji> _byKey = {
    for (final e in _catalog) e.key: e,
  };

  /// `null` for a key outside the catalogue (e.g. one removed since).
  static FluentEmoji? fromKey(String? key) => key == null ? null : _byKey[key];

  static List<FluentEmoji> inGroup(FluentEmojiGroup group) => [
    for (final e in _catalog)
      if (e.group == group) e,
  ];

  @override
  String toString() => 'FluentEmoji($key)';
}
