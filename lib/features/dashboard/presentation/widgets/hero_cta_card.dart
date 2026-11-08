import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_duration.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/session_mark.dart';

/// The home page's one bold element: the next session, ready to start.
///
/// It is the only surface on the page with a colour of its own — the
/// session emoji's, pooled in the corner, with a trace of rose below — so the
/// home page changes mood with what you train next: a flame lights it orange,
/// a moon yellow, a mountain green. Everything around it stays grey.
///
/// When there is nothing to suggest yet, the same card invites the user to
/// create a first template, lit in rose.
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
    final template = suggested;

    return EdgeLitSurface(
      radius: AppRadius.sheet,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      accent: template == null ? scheme.glow : template.emoji.color,
      accentSecondary: template == null ? null : scheme.glow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: template != null
            ? _withTemplate(context, template)
            : _empty(context),
      ),
    );
  }

  List<Widget> _withTemplate(BuildContext context, Template template) {
    final scheme = Theme.of(context).colorScheme;
    final count = template.primaryExercises.length;
    final minutes = (estimateTemplateSeconds(template) / 60).round();
    final meta = [
      t.dashboard.exerciseCount(n: count),
      if (minutes > 0) t.dashboard.hero.duration(n: minutes),
    ].join(' · ');

    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                t.dashboard.hero.eyebrow,
                style: AppText.microLabel.copyWith(
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w600,
                  color: scheme.textTertiary,
                ),
              ),
            ),
          ),
          SessionMark(emoji: template.emoji, size: 44),
        ],
      ),
      const SizedBox(height: 4),
      Text(
        template.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppText.heroTitle.copyWith(color: scheme.textPrimary),
      ),
      const SizedBox(height: 6),
      Text(meta, style: AppText.body.copyWith(color: scheme.textSecondary)),
      const SizedBox(height: 18),
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

  List<Widget> _empty(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return [
      Text(
        t.dashboard.hero.emptyTitle,
        style: AppText.title.copyWith(color: scheme.textPrimary),
      ),
      const SizedBox(height: 4),
      Text(
        t.dashboard.hero.emptyMessage,
        style: AppText.body.copyWith(color: scheme.textSecondary),
      ),
      const SizedBox(height: 18),
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
