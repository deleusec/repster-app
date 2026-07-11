import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/l10n/muscle_group_l10n.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';

/// Template card in the list (Templates page): group thumbnail, name +
/// description + tags + exercise count, and — depending on the mode — either an
/// action bar (Edit / Details / Copy / Delete) or a drag handle plus an
/// active/inactive toggle.
class TemplateListCard extends StatelessWidget {
  const TemplateListCard({
    required this.template,
    required this.manageMode,
    required this.confirmingDelete,
    required this.onStart,
    required this.onEdit,
    required this.onDetails,
    required this.onDuplicate,
    required this.onDelete,
    required this.onRequestDelete,
    required this.onToggleActive,
    this.dragHandle,
    super.key,
  });

  final Template template;
  final bool manageMode;
  final bool confirmingDelete;
  final VoidCallback onStart;
  final VoidCallback onEdit;
  final VoidCallback onDetails;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;
  final VoidCallback onRequestDelete;
  final VoidCallback onToggleActive;
  final Widget? dragHandle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final active = template.isActive;

    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: active ? 0.03 : 0.015),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: onSurface.withValues(alpha: active ? 0.07 : 0.04),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        // Transparent Material inside the clip: otherwise the InkWell
        // hover/splash effects paint on the ancestor Material and bleed past the
        // rounded corners (visible on web hover).
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (manageMode && dragHandle != null) dragHandle!,
                  Expanded(child: _content(context, scheme)),
                  if (manageMode) _toggle(scheme),
                ],
              ),
              if (!manageMode) _actionsBar(context, scheme),
            ],
          ),
        ),
      ),
    );

    if (!active && manageMode) {
      return Opacity(opacity: 0.5, child: card);
    }
    return card;
  }

  Widget _content(BuildContext context, ColorScheme scheme) {
    final onSurface = scheme.onSurface;
    final group = template.tags.isNotEmpty
        ? template.tags.first
        : MuscleGroup.custom;
    final count = template.primaryExercises.length;
    final tags = template.tags.take(3).toList(growable: false);
    final extra = template.tags.length - tags.length;

    return InkWell(
      onTap: manageMode ? null : onStart,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: onSurface.withValues(
                        alpha: template.isActive || !manageMode ? 1 : 0.5,
                      ),
                    ),
                  ),
                  if (template.description.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      template.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (final t in tags) _TagPill(group: t),
                      if (extra > 0)
                        Text(
                          '+$extra',
                          style: TextStyle(
                            fontSize: 12,
                            color: onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      Text(
                        '· ${t.templates.card.exerciseCount(n: count)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!manageMode) ...[
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.play_arrow_rounded,
                  size: 18,
                  color: scheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _toggle(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 4),
      child: IconButton(
        onPressed: onToggleActive,
        visualDensity: VisualDensity.compact,
        tooltip: template.isActive
            ? t.templates.card.deactivate
            : t.templates.card.activate,
        icon: Icon(
          template.isActive ? LucideIcons.circleCheck : LucideIcons.circle,
          size: 22,
          color: template.isActive
              ? scheme.primary
              : scheme.onSurface.withValues(alpha: 0.45),
        ),
      ),
    );
  }

  Widget _actionsBar(BuildContext context, ColorScheme scheme) {
    final divider = scheme.onSurface.withValues(alpha: 0.07);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: divider)),
      ),
      child: SizedBox(
        height: 46,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ActionButton(
              icon: LucideIcons.pencil,
              label: t.common.actions.edit,
              onTap: onEdit,
            ),
            _vDivider(divider),
            _ActionButton(
              icon: LucideIcons.info,
              label: t.templates.card.details,
              onTap: onDetails,
            ),
            _vDivider(divider),
            _ActionButton(
              icon: LucideIcons.copy,
              label: t.templates.card.copy,
              onTap: onDuplicate,
            ),
            _vDivider(divider),
            if (confirmingDelete)
              _ActionButton(
                icon: LucideIcons.trash2,
                label: t.common.actions.confirm,
                onTap: onDelete,
                danger: true,
                active: true,
              )
            else
              _ActionButton(
                icon: LucideIcons.trash2,
                label: t.templates.card.deleteShort,
                onTap: onRequestDelete,
                danger: true,
              ),
          ],
        ),
      ),
    );
  }

  Widget _vDivider(Color color) => Container(width: 1, color: color);
}

class _TagPill extends StatelessWidget {
  const _TagPill({required this.group});
  final MuscleGroup group;

  @override
  Widget build(BuildContext context) {
    final accent = group.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        group.localizedLabel,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: accent,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = (danger && active)
        ? scheme.error
        : scheme.onSurface.withValues(alpha: 0.55);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
