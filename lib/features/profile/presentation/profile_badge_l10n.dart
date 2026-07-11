import 'package:repster/features/profile/domain/profile_stats.dart';
import 'package:repster/i18n/translations.g.dart';

/// Emoji and translated label for a [ProfileBadgeKind]. Lives in the
/// presentation layer to keep the domain pure (the enum doesn't import the
/// generated translations).
extension ProfileBadgeKindL10n on ProfileBadgeKind {
  String get emoji => switch (this) {
    ProfileBadgeKind.firstSession => '🏋️',
    ProfileBadgeKind.tenSessions => '🔥',
    ProfileBadgeKind.tenTonnes => '💪',
    ProfileBadgeKind.planner => '📋',
  };

  String get localizedLabel => switch (this) {
    ProfileBadgeKind.firstSession => t.profile.badges.firstSession,
    ProfileBadgeKind.tenSessions => t.profile.badges.tenSessions,
    ProfileBadgeKind.tenTonnes => t.profile.badges.tenTonnes,
    ProfileBadgeKind.planner => t.profile.badges.planner,
  };
}
