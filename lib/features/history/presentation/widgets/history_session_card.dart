import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/l10n/muscle_group_l10n.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';
import 'package:repster/shared/widgets/pressable.dart';

/// History session card: group badge, name + date/time, metrics
/// (duration / emerald volume / sets), tags, and a delete bar with inline
/// confirmation.
///
/// The body is the press that opens the session; the bar below has its own,
/// so a tap on "delete" never scales the whole card.
class HistorySessionCard extends StatefulWidget {
  const HistorySessionCard({
    required this.summary,
    required this.onTap,
    required this.onDelete,
    super.key,
  });

  final WorkoutSessionSummary summary;
  final VoidCallback onTap;
  final Future<void> Function() onDelete;

  @override
  State<HistorySessionCard> createState() => _HistorySessionCardState();
}

class _HistorySessionCardState extends State<HistorySessionCard> {
  bool _confirming = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final s = widget.summary;
    final group = s.tags.isNotEmpty ? s.tags.first : MuscleGroup.custom;
    final divider = scheme.hairline;

    return EdgeLitSurface(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Pressable(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MuscleGroupBadge(group: group, size: 44, fontSize: 22),
                  const SizedBox(width: 12),
                  Expanded(child: _content(scheme)),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(
                      LucideIcons.chevronRight,
                      size: 18,
                      color: scheme.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: divider)),
            ),
            child: SizedBox(height: 44, child: _actionBar(scheme, divider)),
          ),
        ],
      ),
    );
  }

  Widget _content(ColorScheme scheme) {
    final s = widget.summary;
    final tags = s.tags.take(3).toList(growable: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.templateName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppText.cardTitle.copyWith(
            letterSpacing: -0.2,
            color: scheme.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(LucideIcons.calendar, size: 12, color: scheme.textTertiary),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                sessionStamp(s.startedAt),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.caption.copyWith(color: scheme.textSecondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _Metric(
              icon: LucideIcons.timer,
              value: formatDuration(s.durationSeconds),
              color: scheme.textSecondary,
            ),
            const SizedBox(width: 14),
            _Metric(
              icon: LucideIcons.dumbbell,
              value: formatTonnage(s.totalTonnageKg),
              color: AppColors.accentEmerald,
            ),
            const SizedBox(width: 14),
            _Metric(
              icon: LucideIcons.repeat,
              value: '${s.totalSets}',
              color: scheme.textSecondary,
            ),
          ],
        ),
        if (tags.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [for (final t in tags) _TagPill(group: t)],
          ),
        ],
      ],
    );
  }

  Widget _actionBar(ColorScheme scheme, Color divider) {
    if (!_confirming) {
      return _BarButton(
        icon: LucideIcons.trash2,
        label: t.common.actions.delete,
        color: scheme.textSecondary,
        onTap: () => setState(() => _confirming = true),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _BarButton(
            icon: LucideIcons.x,
            label: t.common.actions.cancel,
            color: scheme.textSecondary,
            onTap: () => setState(() => _confirming = false),
          ),
        ),
        Container(width: 1, color: divider),
        Expanded(
          child: _BarButton(
            icon: LucideIcons.trash2,
            label: t.common.actions.confirm,
            color: scheme.error,
            onTap: () {
              setState(() => _confirming = false);
              unawaited(widget.onDelete());
            },
          ),
        ),
      ],
    );
  }
}

class _BarButton extends StatelessWidget {
  const _BarButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
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
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.value, required this.color});

  final IconData icon;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppText.caption.copyWith(
            fontWeight: FontWeight.w600,
            fontFeatures: const [FontFeature.tabularFigures()],
            color: color,
          ),
        ),
      ],
    );
  }
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
        color: accent.withValues(alpha: 0.14),
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
