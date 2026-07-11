import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';
import 'package:repster/shared/widgets/soft_glow.dart';

/// Hero call-to-action card. When a template is suggested it offers to start a
/// session; otherwise it invites the user to create a first template.
class HeroCtaCard extends StatelessWidget {
  const HeroCtaCard({
    required this.suggested,
    required this.onStart,
    required this.onCreate,
    super.key,
  });

  /// Template suggested for the next session (the first active template).
  final Template? suggested;
  final ValueChanged<Template> onStart;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.cardLg),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.cardLg),
          color: onSurface.withValues(alpha: 0.05),
          border: Border.all(color: onSurface.withValues(alpha: 0.09)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -48,
              right: -48,
              child: SoftGlow(
                color: scheme.primary.withValues(alpha: 0.22),
                size: 176,
                blur: 44,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.dashboard.hero.eyebrow,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.8,
                      color: onSurface.withValues(alpha: 0.35),
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (suggested != null)
                    ..._withTemplate(context, suggested!, onSurface)
                  else
                    ..._empty(context, onSurface),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _withTemplate(
    BuildContext context,
    Template template,
    Color onSurface,
  ) {
    final group = template.tags.isNotEmpty
        ? template.tags.first
        : MuscleGroup.custom;
    final count = template.primaryExercises.length;
    return [
      Row(
        children: [
          MuscleGroupBadge(group: group, size: 44, fontSize: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  t.dashboard.exerciseCount(n: count),
                  style: TextStyle(
                    fontSize: 12,
                    color: onSurface.withValues(alpha: 0.40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      AppButton(
        label: t.dashboard.hero.start,
        // Filled play, matching the PWA (Lucide's font glyph is outline-only,
        // so we use Material's rounded solid triangle, sized up to compensate
        // for its built-in padding).
        icon: Icons.play_arrow_rounded,
        iconSize: 26,
        size: AppButtonSize.lg,
        expand: true,
        onPressed: () => onStart(template),
      ),
    ];
  }

  List<Widget> _empty(BuildContext context, Color onSurface) {
    return [
      Text(
        t.dashboard.hero.emptyTitle,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        t.dashboard.hero.emptyMessage,
        style: TextStyle(
          fontSize: 12,
          color: onSurface.withValues(alpha: 0.40),
        ),
      ),
      const SizedBox(height: 16),
      AppButton(
        label: t.dashboard.hero.create,
        icon: LucideIcons.zap,
        size: AppButtonSize.lg,
        expand: true,
        onPressed: onCreate,
      ),
    ];
  }
}
