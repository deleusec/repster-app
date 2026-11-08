import 'package:repster/core/emoji/fluent_emoji.dart';

/// Picture for a row that predates the picker: `workout_templates.tags` and
/// `workout_sessions.tags` still hold the muscle groups the app used to ask
/// for, and the frozen PWA keeps writing them. The first one maps to the
/// Fluent counterpart of the emoji that group used to show, so old cards
/// look as they did.
FluentEmoji legacyEmojiForTags(List<dynamic>? tags) {
  final first = tags == null || tags.isEmpty ? null : tags.first?.toString();
  return _byLegacyTag[first] ?? FluentEmojis.bullseye;
}

const _byLegacyTag = <String, FluentEmoji>{
  'chest': FluentEmojis.shield,
  'back': FluentEmojis.eagle,
  'shoulders': FluentEmojis.snowCappedMountain,
  'biceps': FluentEmojis.flexedBiceps,
  'triceps': FluentEmojis.bowAndArrow,
  'forearms': FluentEmojis.raisedFist,
  'quads': FluentEmojis.leg,
  'hamstrings': FluentEmojis.personRunning,
  'glutes': FluentEmojis.peach,
  'calves': FluentEmojis.foot,
  'abs': FluentEmojis.brick,
};

/// Preselected for a new template.
const kDefaultSessionEmoji = FluentEmojis.personLiftingWeights;
