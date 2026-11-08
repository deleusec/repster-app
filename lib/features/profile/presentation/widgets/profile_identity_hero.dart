import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/auth/domain/auth_user_goal.dart';
import 'package:repster/features/auth/presentation/goal_l10n.dart';
import 'package:repster/features/profile/presentation/widgets/profile_avatar_block.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';

/// Accent color associated with a goal.
Color _goalAccent(AuthUserGoal goal, ColorScheme scheme) => switch (goal) {
  AuthUserGoal.strength => AppColors.accentAmber,
  AuthUserGoal.hypertrophy => scheme.glow,
  AuthUserGoal.endurance => AppColors.accentBlue,
  AuthUserGoal.weightLoss => AppColors.accentOrange,
  AuthUserGoal.maintenance => AppColors.accentEmerald,
};

/// Identity block: avatar, name, email, goal pill and bio.
class ProfileIdentityHero extends StatelessWidget {
  const ProfileIdentityHero({required this.user, super.key});

  final AuthUser user;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final goal = user.goal;
    final name = user.fullName?.trim().isNotEmpty ?? false
        ? user.fullName!.trim()
        : t.profile.defaultName;
    final bio = user.bio?.trim();

    return Column(
      children: [
        ProfileAvatarBlock(user: user),
        const SizedBox(height: 16),
        Text(
          name,
          textAlign: TextAlign.center,
          // Display name — matches the PWA's text-[1.75rem] font-black (28px).
          style: AppText.display.copyWith(
            fontSize: 28,
            color: scheme.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          user.email,
          style: AppText.caption.copyWith(
            fontSize: 13,
            color: scheme.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            if (goal != null) _GoalPill(goal: goal),
            Text(
              t.profile.since(month: monthLabel(user.joinedAt)),
              style: AppText.caption.copyWith(color: scheme.textTertiary),
            ),
          ],
        ),
        if (bio != null && bio.isNotEmpty) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              bio,
              textAlign: TextAlign.center,
              style: AppText.caption.copyWith(
                fontSize: 13,
                height: 1.45,
                color: scheme.textSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _GoalPill extends StatelessWidget {
  const _GoalPill({required this.goal});

  final AuthUserGoal goal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = _goalAccent(goal, scheme);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Text(
        '${goal.emoji} ${goal.localizedLabel}',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: accent,
        ),
      ),
    );
  }
}
