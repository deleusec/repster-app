import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

/// Unlocked reward shown on the profile. The emoji and translated label live in
/// the presentation layer (`ProfileBadgeKindL10n`) to keep the domain pure.
enum ProfileBadgeKind { firstSession, tenSessions, tenTonnes, planner }

/// Most-trained muscle group and its occurrence count.
class FavoriteMuscleGroup {
  const FavoriteMuscleGroup(this.group, this.sessionCount);

  final MuscleGroup group;
  final int sessionCount;
}

/// Aggregates derived from sessions for the profile header (tonnage, sets,
/// favorite group, badges).
///
/// Pure logic: no Flutter dependency, testable in isolation.
class ProfileStats {
  const ProfileStats({
    required this.sessionCount,
    required this.totalTonnageKg,
    required this.totalSets,
    required this.favorite,
    required this.badges,
  });

  factory ProfileStats.from({
    required List<WorkoutSessionSummary> sessions,
    required int templateCount,
  }) {
    var tonnage = 0.0;
    var sets = 0;
    final tagCounts = <MuscleGroup, int>{};
    for (final s in sessions) {
      tonnage += s.totalTonnageKg;
      sets += s.totalSets;
      for (final tag in s.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }

    FavoriteMuscleGroup? favorite;
    for (final entry in tagCounts.entries) {
      if (favorite == null || entry.value > favorite.sessionCount) {
        favorite = FavoriteMuscleGroup(entry.key, entry.value);
      }
    }

    final badges = <ProfileBadgeKind>[
      if (sessions.isNotEmpty) ProfileBadgeKind.firstSession,
      if (sessions.length >= 10) ProfileBadgeKind.tenSessions,
      if (tonnage >= 10000) ProfileBadgeKind.tenTonnes,
      if (templateCount >= 3) ProfileBadgeKind.planner,
    ];

    return ProfileStats(
      sessionCount: sessions.length,
      totalTonnageKg: tonnage,
      totalSets: sets,
      favorite: favorite,
      badges: badges,
    );
  }

  final int sessionCount;
  final double totalTonnageKg;
  final int totalSets;
  final FavoriteMuscleGroup? favorite;
  final List<ProfileBadgeKind> badges;
}
