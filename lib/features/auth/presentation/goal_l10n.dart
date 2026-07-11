import 'package:repster/features/auth/domain/auth_user_goal.dart';
import 'package:repster/i18n/translations.g.dart';

/// Translated label for an [AuthUserGoal]. Lives in the presentation layer to
/// keep the domain pure (the enum only knows its persistence key and emoji).
extension AuthUserGoalL10n on AuthUserGoal {
  String get localizedLabel => switch (this) {
    AuthUserGoal.strength => t.goals.strength,
    AuthUserGoal.hypertrophy => t.goals.hypertrophy,
    AuthUserGoal.endurance => t.goals.endurance,
    AuthUserGoal.weightLoss => t.goals.weightLoss,
    AuthUserGoal.maintenance => t.goals.maintenance,
  };
}
