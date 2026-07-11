/// Training goals shown on the onboarding and profile screens.
enum AuthUserGoal {
  strength,
  hypertrophy,
  endurance,
  weightLoss,
  maintenance;

  /// Key persisted in `user_metadata.goal` on Supabase. Must stay stable.
  String toMetadataValue() => switch (this) {
    AuthUserGoal.strength => 'strength',
    AuthUserGoal.hypertrophy => 'hypertrophy',
    AuthUserGoal.endurance => 'endurance',
    AuthUserGoal.weightLoss => 'weightloss',
    AuthUserGoal.maintenance => 'maintenance',
  };

  static AuthUserGoal? fromMetadataValue(Object? raw) {
    if (raw is! String) return null;
    return switch (raw.toLowerCase()) {
      'strength' => AuthUserGoal.strength,
      'hypertrophy' => AuthUserGoal.hypertrophy,
      'endurance' => AuthUserGoal.endurance,
      'weightloss' || 'weight_loss' => AuthUserGoal.weightLoss,
      'maintenance' => AuthUserGoal.maintenance,
      _ => null,
    };
  }

  /// Emoji associated with the goal.
  String get emoji => switch (this) {
    AuthUserGoal.strength => '💪',
    AuthUserGoal.hypertrophy => '🏋️',
    AuthUserGoal.endurance => '🏃',
    AuthUserGoal.weightLoss => '🔥',
    AuthUserGoal.maintenance => '⚖️',
  };
}
