import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/pressable.dart';
import 'package:repster/shared/widgets/session_mark.dart';

/// Template card in the list (Templates page): emoji thumbnail, name +
/// description + exercise count, and — depending on the mode — either an
/// action bar (Edit / Details / Copy / Delete) or a drag handle plus an
/// active/inactive toggle.
///
/// The card body is the "start" control: pressing it scales the whole card.
/// The action bar below has its own, smaller presses so the two never fight.
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
    final active = template.isActive;

    final card = EdgeLitSurface(
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
    );

    if (!active && manageMode) {
      return Opacity(opacity: 0.45, child: card);
    }
    return card;
  }

  Widget _content(BuildContext context, ColorScheme scheme) {
    final count = template.primaryExercises.length;

    final body = Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SessionMark(emoji: template.emoji, size: 44),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.cardTitle.copyWith(color: scheme.textPrimary),
                ),
                if (template.description.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    template.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.caption.copyWith(
                      color: scheme.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Text(
                  t.templates.card.exerciseCount(n: count),
                  style: AppText.caption.copyWith(color: scheme.textTertiary),
                ),
              ],
            ),
          ),
          if (!manageMode) ...[
            const SizedBox(width: 10),
            _PlayMark(color: scheme.primary),
          ],
        ],
      ),
    );

    if (manageMode) return body;
    return Pressable(onTap: onStart, haptic: true, child: body);
  }

  Widget _toggle(ColorScheme scheme) {
    final active = template.isActive;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Tooltip(
        message: active
            ? t.templates.card.deactivate
            : t.templates.card.activate,
        child: Pressable(
          onTap: onToggleActive,
          scale: 0.9,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              active ? LucideIcons.circleCheck : LucideIcons.circle,
              size: 22,
              color: active ? scheme.glow : scheme.textTertiary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionsBar(BuildContext context, ColorScheme scheme) {
    final divider = scheme.hairline;
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
              )
            else
              _ActionButton(
                icon: LucideIcons.trash2,
                label: t.templates.card.deleteShort,
                onTap: onRequestDelete,
              ),
          ],
        ),
      ),
    );
  }

  Widget _vDivider(Color color) => Container(width: 1, color: color);
}

/// The start affordance: a filled play in a disc of the brand's light.
class _PlayMark extends StatelessWidget {
  const _PlayMark({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    final glow = Theme.of(context).colorScheme.glow;
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: glow.withValues(alpha: 0.14),
      ),
      child: Icon(Icons.play_arrow_rounded, size: 20, color: glow),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  /// The armed delete: red, so the second tap knows what it is confirming.
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = danger ? scheme.error : scheme.textSecondary;
    return Expanded(
      child: Pressable(
        onTap: onTap,
        scale: 0.94,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppText.caption.copyWith(
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
