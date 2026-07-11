import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/session/presentation/start_session.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_slot.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/app_card.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/muscle_group_chip.dart';
import 'package:repster/shared/widgets/page_header.dart';

class TemplateDetailScreen extends ConsumerWidget {
  const TemplateDetailScreen({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templateAsync = ref.watch(templateByIdProvider(id));
    return Scaffold(
      appBar: PageHeader(
        title: t.templates.detail.title,
        showBack: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.pencil),
            tooltip: t.common.actions.edit,
            onPressed: () => context.push(Routes.templateEdit(id)),
          ),
        ],
      ),
      body: AsyncValueWidget<Template>(
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
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              Text(
                template.name,
                // Page title → bold (w700), matching the PWA (text-[26px]
                // font-bold), not extrabold.
                style: AppText.pageTitle,
              ),
              if (template.description.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  template.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: scheme.onSurface.withValues(alpha: 0.7),
                    height: 1.4,
                  ),
                ),
              ],
              if (template.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final t in template.tags)
                      MuscleGroupChip(group: t, dense: true),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              if (template.slots.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      t.templates.detail.noExercises,
                      style: TextStyle(
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                )
              else
                for (var i = 0; i < template.slots.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _SlotPreview(
                      slot: template.slots[i],
                      position: i + 1,
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
              onPressed: template.slots.isEmpty
                  ? null
                  : () => startTemplateSession(context, ref, template.id),
            ),
          ),
        ),
      ],
    );
  }
}

class _SlotPreview extends StatelessWidget {
  const _SlotPreview({required this.slot, required this.position});
  final TemplateSlot slot;
  final int position;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final primary = slot.primary;
    final hasVariants = slot.variants.length > 1;
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$position',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  primary.name.isEmpty ? t.common.unnamed : primary.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (slot.supersetWithNext)
                _Badge(
                  icon: LucideIcons.link2,
                  label: t.templates.detail.superset,
                  color: scheme.primary,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              _Metric(
                icon: LucideIcons.repeat,
                label: t.templates.detail.setsCount(n: primary.sets),
              ),
              if (primary.isTimeBased)
                _Metric(
                  icon: LucideIcons.timer,
                  label: t.templates.detail.seconds(
                    n: primary.durationSeconds ?? 30,
                  ),
                )
              else
                _Metric(
                  icon: LucideIcons.dumbbell,
                  label: '${primary.reps} ${t.common.units.reps}',
                ),
              _Metric(
                icon: LucideIcons.gauge,
                label: t.templates.detail.tempo(value: primary.tempo),
              ),
              _Metric(
                icon: LucideIcons.hourglass,
                label: t.templates.detail.rest(n: primary.restTime),
              ),
            ],
          ),
          if (hasVariants) ...[
            const SizedBox(height: 8),
            Text(
              _variantsLabel(slot.variants.length),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: scheme.primary,
              ),
            ),
          ],
          if (primary.notes.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              primary.notes,
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurface.withValues(alpha: 0.6),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

String _variantsLabel(int totalVariants) {
  return t.templates.detail.variantsMore(n: totalVariants - 1);
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: scheme.onSurface.withValues(alpha: 0.55)),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: scheme.onSurface.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
