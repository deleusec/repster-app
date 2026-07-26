import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/profile/domain/profile_stats.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/l10n/muscle_group_l10n.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';

/// Card highlighting the most-trained muscle group.
class ProfileFavoriteCard extends StatelessWidget {
  const ProfileFavoriteCard({required this.favorite, super.key});

  final FavoriteMuscleGroup favorite;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final accent = favorite.group.accent;
    final count = favorite.sessionCount;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: accent.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${favorite.group.emoji} ${favorite.group.localizedLabel}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: accent,
              ),
            ),
          ),
          Text(
            t.profile.sessionCount(n: count),
            style: TextStyle(
              fontSize: 12,
              color: onSurface.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
