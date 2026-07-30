import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';

/// Call-to-action card for the next session. When a template is suggested it
/// offers to start it; otherwise it invites the user to create a first one.
///
/// Wears the page's standard card surface ([AppSurfaces.translucentCard]), so
/// it shares its radius, fill and border weight with the cards around it.
class HeroCtaCard extends StatelessWidget {
  const HeroCtaCard({
    required this.suggested,
    required this.onStart,
    required this.onCreate,
    super.key,
  });

  /// Template suggested for the next session (the one following the last
  /// trained, in the program order).
  final Template? suggested;
  final ValueChanged<Template> onStart;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;

    return DecoratedBox(
      decoration: scheme.translucentCard,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: suggested != null
              ? _withTemplate(context, suggested!, onSurface)
              : _empty(context, onSurface),
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
      // Only over a real suggestion: there is no "next session" to announce
      // when the user has no template yet.
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
