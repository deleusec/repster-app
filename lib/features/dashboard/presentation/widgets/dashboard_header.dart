import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/dashboard/presentation/widgets/streak_badge.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/pressable.dart';

/// Dashboard header: contextual greeting, first name in large type, an
/// optional streak badge and a tappable avatar.
class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    required this.user,
    required this.streakWeeks,
    required this.onAvatarTap,
    super.key,
  });

  final AuthUser user;
  final int streakWeeks;
  final VoidCallback onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? t.dashboard.greeting.morning
        : hour < 18
        ? t.dashboard.greeting.afternoon
        : t.dashboard.greeting.evening;
    final name = user.firstName.isEmpty
        ? t.dashboard.defaultName
        : user.firstName;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting.toUpperCase(),
                style: AppText.microLabel.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  color: scheme.textTertiary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.display.copyWith(color: scheme.textPrimary),
              ),
              if (streakWeeks >= 2) ...[
                const SizedBox(height: 10),
                StreakBadge(weeks: streakWeeks),
              ],
            ],
          ),
        ),
        const SizedBox(width: 12),
        _Avatar(user: user, onTap: onAvatarTap),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.user, required this.onTap});

  final AuthUser user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const radius = 14.0;
    return Pressable(
      onTap: onTap,
      scale: 0.94,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: scheme.onSurface.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: scheme.glow.withValues(alpha: 0.22),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        child: user.avatarUrl != null
            ? Image.network(
                user.avatarUrl!,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Icon(
                  LucideIcons.user,
                  color: scheme.onSurface.withValues(alpha: 0.5),
                ),
              )
            : Text(
                _initial(user),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
      ),
    );
  }

  static String _initial(AuthUser user) {
    final name = user.firstName.trim();
    if (name.isNotEmpty) return name.substring(0, 1).toUpperCase();
    final email = user.email;
    return email.isEmpty ? '?' : email.substring(0, 1).toUpperCase();
  }
}
