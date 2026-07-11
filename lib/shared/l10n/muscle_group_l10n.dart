import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/i18n/translations.g.dart';

/// Translated labels for muscle groups and their sections. Lives in the
/// shared/presentation layer to keep the domain (`MuscleGroup`) pure.
extension MuscleGroupL10n on MuscleGroup {
  String get localizedLabel => switch (this) {
    MuscleGroup.chest => t.muscleGroups.chest,
    MuscleGroup.back => t.muscleGroups.back,
    MuscleGroup.shoulders => t.muscleGroups.shoulders,
    MuscleGroup.biceps => t.muscleGroups.biceps,
    MuscleGroup.triceps => t.muscleGroups.triceps,
    MuscleGroup.forearms => t.muscleGroups.forearms,
    MuscleGroup.quads => t.muscleGroups.quads,
    MuscleGroup.hamstrings => t.muscleGroups.hamstrings,
    MuscleGroup.glutes => t.muscleGroups.glutes,
    MuscleGroup.calves => t.muscleGroups.calves,
    MuscleGroup.abs => t.muscleGroups.abs,
    MuscleGroup.custom => t.muscleGroups.custom,
  };
}

extension MuscleGroupSectionL10n on MuscleGroupSection {
  String get localizedTitle => switch (kind) {
    MuscleGroupSectionKind.chestBack => t.muscleGroups.sections.chestBack,
    MuscleGroupSectionKind.shouldersArms =>
      t.muscleGroups.sections.shouldersArms,
    MuscleGroupSectionKind.legsGlutes => t.muscleGroups.sections.legsGlutes,
    MuscleGroupSectionKind.abs => t.muscleGroups.sections.abs,
    MuscleGroupSectionKind.other => t.muscleGroups.sections.other,
  };
}
