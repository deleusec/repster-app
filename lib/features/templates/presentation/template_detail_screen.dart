import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/session/presentation/start_session.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_duration.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/back_nav_bar.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/section_label.dart';
import 'package:repster/shared/widgets/session_mark.dart';

/// A template, read before starting it: its mark and name, a one-line
/// summary, then the exercises as a compact list — one line of figures each,
/// no card per exercise, so a ten-exercise session reads at a glance.
class TemplateDetailScreen extends ConsumerWidget {
  const TemplateDetailScreen({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templateAsync = ref.watch(templateByIdProvider(id));
    return GlowScaffold(
      child: AsyncValueWidget<Template>(
        value: templateAsync,
        onRetry: () => ref.invalidate(templatesControllerProvider),
        data: (t) => _Body(template: t),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.template});
  final Template template;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final stagger = StaggeredList();
    final slots = template.slots;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              stagger.wrap(
                BackNavBar(
                  onBack: () => context.pop(),
                  actionIcon: LucideIcons.pencil,
                  actionTooltip: t.common.actions.edit,
                  onAction: () =>
                      context.push(Routes.templateEdit(template.id)),
                ),
              ),
              const SizedBox(height: 20),
              stagger.wrap(_Header(template: template)),
              const SizedBox(height: 24),
              stagger.wrap(
                SectionLabel(
                  t.templates.editor.exercisesHeader(count: slots.length),
                ),
              ),
              const SizedBox(height: 10),
              if (slots.isEmpty)
                stagger.wrap(
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text(
                        t.templates.detail.noExercises,
                        style: AppText.body.copyWith(
                          color: scheme.textTertiary,
                        ),
                      ),
                    ),
                  ),
                )
              else
                stagger.wrap(
                  EdgeLitSurface(
                    child: Column(
                      children: [
                        for (var i = 0; i < slots.length; i++) ...[
                          _SlotRow(slot: slots[i], position: i + 1),
                          if (i < slots.length - 1)
                            _Joint(superset: slots[i].supersetWithNext),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: AppButton(
              label: t.templates.detail.start,
              // Filled play, matching the PWA (see hero_cta_card).
              icon: Icons.play_arrow_rounded,
              iconSize: 26,
              size: AppButtonSize.lg,
              expand: true,
              onPressed: slots.isEmpty
                  ? null
                  : () => startTemplateSession(context, ref, template.id),
            ),
          ),
        ),
      ],
    );
  }
}

/// Mark, name and description, then the figures that size the session.
class _Header extends StatelessWidget {
  const _Header({required this.template});
  final Template template;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final exercises = template.primaryExercises;
    final sets = exercises.fold<int>(0, (sum, e) => sum + e.sets);
    final minutes = (estimateTemplateSeconds(template) / 60).round();
    final summary = [
      t.templates.card.exerciseCount(n: exercises.length),
      t.templates.detail.setsCount(n: sets),
      if (minutes > 0) t.dashboard.hero.duration(n: minutes),
    ].join(' · ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SessionMark(emoji: template.emoji, size: 52, radius: 14),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.title.copyWith(color: scheme.textPrimary),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    summary,
                    style: AppText.caption.copyWith(
                      color: scheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (template.description.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            template.description,
            style: AppText.body.copyWith(
              height: 1.45,
              color: scheme.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}

/// One exercise: its rank, name, and a single line of figures. Variants and
/// a hold are flagged with a small mark, never a second line.
class _SlotRow extends StatelessWidget {
  const _SlotRow({required this.slot, required this.position});
  final TemplateSlot slot;
  final int position;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final primary = slot.primary;
    final extra = slot.variants.length - 1;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: scheme.onSurface.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: Text(
              '$position',
              style: AppText.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: scheme.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        primary.name.isEmpty ? t.common.unnamed : primary.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.subtitle.copyWith(
                          color: scheme.textPrimary,
                        ),
                      ),
                    ),
                    if (extra > 0) ...[
                      const SizedBox(width: 8),
                      _Pill(
                        icon: LucideIcons.shuffle,
                        label: '+$extra',
                        color: scheme.glow,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  _figures(primary),
                  style: AppText.caption.copyWith(color: scheme.textSecondary),
                ),
                if (primary.notes.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    primary.notes,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.caption.copyWith(color: scheme.textTertiary),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// `4 × 8 · tempo 3-1-2-0 · rest 120s`, or `4 × 30 s` for a hold.
  String _figures(TemplateExercise e) {
    final hold = t.templates.detail.seconds(n: e.durationSeconds ?? 30);
    final work = e.isTimeBased ? '${e.sets} × $hold' : '${e.sets} × ${e.reps}';
    return [
      work,
      if (!e.isTimeBased && e.tempo.isNotEmpty)
        t.templates.detail.tempo(value: e.tempo),
      t.templates.detail.rest(n: e.restTime),
    ].join(' · ');
  }
}

/// The seam between two rows: a hairline, or the superset link that ties
/// them, drawn in the brand's light.
class _Joint extends StatelessWidget {
  const _Joint({required this.superset});
  final bool superset;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (!superset) return Divider(height: 1, color: scheme.hairline);
    final glow = scheme.glow;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Expanded(
            child: Container(height: 1, color: glow.withValues(alpha: 0.3)),
          ),
          const SizedBox(width: 8),
          _Pill(
            icon: LucideIcons.link2,
            label: t.templates.detail.superset.toUpperCase(),
            color: glow,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(height: 1, color: glow.withValues(alpha: 0.3)),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppText.microLabel.copyWith(
              letterSpacing: 0.6,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
