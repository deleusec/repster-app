import 'package:repster/core/emoji/fluent_emoji.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

/// Preselected for a new template.
const kDefaultSessionEmoji = FluentEmojis.personLiftingWeights;

/// The picture a template or session shows: the chosen one, else the first
/// muscle group's (the Fluent counterpart of [MuscleGroup.emoji]).
FluentEmoji sessionEmoji(FluentEmoji? chosen, List<MuscleGroup> tags) =>
    chosen ?? (tags.isEmpty ? MuscleGroup.custom : tags.first).fluentEmoji;

extension MuscleGroupFluentEmoji on MuscleGroup {
  FluentEmoji get fluentEmoji => switch (this) {
    MuscleGroup.chest => FluentEmojis.shield,
    MuscleGroup.back => FluentEmojis.eagle,
    MuscleGroup.shoulders => FluentEmojis.snowCappedMountain,
    MuscleGroup.biceps => FluentEmojis.flexedBiceps,
    MuscleGroup.triceps => FluentEmojis.bowAndArrow,
    MuscleGroup.forearms => FluentEmojis.raisedFist,
    MuscleGroup.quads => FluentEmojis.leg,
    MuscleGroup.hamstrings => FluentEmojis.personRunning,
    MuscleGroup.glutes => FluentEmojis.peach,
    MuscleGroup.calves => FluentEmojis.foot,
    MuscleGroup.abs => FluentEmojis.brick,
    MuscleGroup.custom => FluentEmojis.bullseye,
  };
}
