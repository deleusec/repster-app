import 'package:repster/features/dashboard/domain/workout_session_summary.dart';

/// Unlocked reward shown on the profile. The emoji and translated label live in
/// the presentation layer (`ProfileBadgeKindL10n`) to keep the domain pure.
enum ProfileBadgeKind { firstSession, tenSessions, tenTonnes, planner }

/// Aggregates derived from sessions for the profile header (tonnage, sets,
/// badges).
///
/// Pure logic: no Flutter dependency, testable in isolation.
class ProfileStats {
  const ProfileStats({
    required this.sessionCount,
    required this.totalTonnageKg,
    required this.totalSets,
    required this.badges,
  });

  factory ProfileStats.from({
    required List<WorkoutSessionSummary> sessions,
    required int templateCount,
  }) {
    var tonnage = 0.0;
    var sets = 0;
    for (final s in sessions) {
      tonnage += s.totalTonnageKg;
      sets += s.totalSets;
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
      badges: badges,
    );
  }

  final int sessionCount;
  final double totalTonnageKg;
  final int totalSets;
  final List<ProfileBadgeKind> badges;
}
