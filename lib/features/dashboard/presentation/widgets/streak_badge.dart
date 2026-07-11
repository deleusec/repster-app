import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/i18n/translations.g.dart';

/// "🔥 N weeks in a row" badge. Shown from 2 weeks onward.
class StreakBadge extends StatelessWidget {
  const StreakBadge({required this.weeks, super.key});

  final int weeks;

  @override
  Widget build(BuildContext context) {
    const accent = AppColors.accentOrange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: accent.withValues(alpha: 0.20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.flame, size: 12, color: accent),
          const SizedBox(width: 6),
          Text(
            t.dashboard.streakBadge(n: weeks),
            style: const TextStyle(
              color: accent,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
