import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/profile/domain/profile_stats.dart';
import 'package:repster/features/profile/presentation/profile_badge_l10n.dart';
import 'package:repster/i18n/translations.g.dart';

/// Earned badges, as a wrap of chips.
class ProfileBadgesSection extends StatelessWidget {
  const ProfileBadgesSection({required this.badges, super.key});

  final List<ProfileBadgeKind> badges;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (badges.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: scheme.primary.withValues(alpha: 0.15)),
        ),
        child: Text(
          t.profile.badges.empty,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: scheme.onSurface.withValues(alpha: 0.35),
          ),
        ),
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [for (final b in badges) _BadgeChip(badge: b)],
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.badge});

  final ProfileBadgeKind badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: scheme.translucentTile,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(badge.emoji, style: const TextStyle(fontSize: 16, height: 1)),
          const SizedBox(width: 8),
          Text(
            badge.localizedLabel,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
