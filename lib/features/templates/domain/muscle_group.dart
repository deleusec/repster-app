/// Muscle groups used to tag templates and sessions. Closed list.
enum MuscleGroup {
  chest,
  back,
  shoulders,
  biceps,
  triceps,
  forearms,
  quads,
  hamstrings,
  glutes,
  calves,
  abs,
  custom;

  /// Persisted serialization on Supabase (text[]). Stable — do not change.
  String toDb() => name;

  static MuscleGroup? fromDb(String? value) {
    if (value == null) return null;
    for (final g in MuscleGroup.values) {
      if (g.name == value) return g;
    }
    return null;
  }

  static List<MuscleGroup> listFromDb(List<dynamic>? raw) {
    if (raw == null) return const [];
    return raw
        .map((e) => fromDb(e?.toString()))
        .whereType<MuscleGroup>()
        .toList(growable: false);
  }

  String get emoji => switch (this) {
    MuscleGroup.chest => '🛡️',
    MuscleGroup.back => '🦅',
    MuscleGroup.shoulders => '🏔️',
    MuscleGroup.biceps => '💪',
    MuscleGroup.triceps => '🏹',
    MuscleGroup.forearms => '✊',
    MuscleGroup.quads => '🦵',
    MuscleGroup.hamstrings => '🏃',
    MuscleGroup.glutes => '🍑',
    MuscleGroup.calves => '🦶',
    MuscleGroup.abs => '🧱',
    MuscleGroup.custom => '🎯',
  };
}

/// Section groupings for the picker. Values map to the
/// `muscleGroups.sections.*` translation keys.
enum MuscleGroupSectionKind { chestBack, shouldersArms, legsGlutes, abs, other }

/// Display sections used by the picker. The translated label is provided by the
/// `localizedTitle` extension (presentation layer) to keep the domain pure.
class MuscleGroupSection {
  const MuscleGroupSection(this.kind, this.groups);

  final MuscleGroupSectionKind kind;
  final List<MuscleGroup> groups;

  static const List<MuscleGroupSection> all = [
    MuscleGroupSection(MuscleGroupSectionKind.chestBack, [
      MuscleGroup.chest,
      MuscleGroup.back,
    ]),
    MuscleGroupSection(MuscleGroupSectionKind.shouldersArms, [
      MuscleGroup.shoulders,
      MuscleGroup.biceps,
      MuscleGroup.triceps,
      MuscleGroup.forearms,
    ]),
    MuscleGroupSection(MuscleGroupSectionKind.legsGlutes, [
      MuscleGroup.quads,
      MuscleGroup.hamstrings,
      MuscleGroup.glutes,
      MuscleGroup.calves,
    ]),
    MuscleGroupSection(MuscleGroupSectionKind.abs, [MuscleGroup.abs]),
    MuscleGroupSection(MuscleGroupSectionKind.other, [MuscleGroup.custom]),
  ];
}
