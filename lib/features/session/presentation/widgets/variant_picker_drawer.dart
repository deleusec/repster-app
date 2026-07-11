import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';

/// Variant picker for a slot. Returns the chosen index or `null`.
Future<int?> showVariantPicker(
  BuildContext context, {
  required List<WorkoutVariant> variants,
  required int activeIndex,
  required bool anyCompleted,
}) {
  return showGlassSheet<int>(
    context,
    builder: (_) => _VariantSheet(
      variants: variants,
      activeIndex: activeIndex,
      anyCompleted: anyCompleted,
    ),
  );
}

class _VariantSheet extends StatelessWidget {
  const _VariantSheet({
    required this.variants,
    required this.activeIndex,
    required this.anyCompleted,
  });

  final List<WorkoutVariant> variants;
  final int activeIndex;
  final bool anyCompleted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 4),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: onSurface.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.shuffle, size: 16, color: scheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      t.session.variants.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  anyCompleted
                      ? t.session.variants.lockedMessage
                      : t.session.variants.pickMessage,
                  style: TextStyle(
                    fontSize: 12,
                    color: anyCompleted
                        ? AppColors.accentAmber.withValues(alpha: 0.85)
                        : onSurface.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                if (variants.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      t.session.variants.empty,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onSurface.withValues(alpha: 0.5)),
                    ),
                  ),
                for (var i = 0; i < variants.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  _VariantTile(
                    variant: variants[i],
                    index: i,
                    active: i == activeIndex,
                    disabled: anyCompleted && i != activeIndex,
                    onTap: () => Navigator.of(context).pop(i),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VariantTile extends StatelessWidget {
  const _VariantTile({
    required this.variant,
    required this.index,
    required this.active,
    required this.disabled,
    required this.onTap,
  });

  final WorkoutVariant variant;
  final int index;
  final bool active;
  final bool disabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final v = variant;
    final summary = v.isTimeBased
        ? '${v.sets} × ${formatHoldDuration(v.durationSeconds ?? 30)}'
        : '${v.sets} × ${v.reps}';
    final hasTempo =
        !v.isTimeBased && v.tempo.isNotEmpty && v.tempo != '0-0-0-0';
    final tempoPart = hasTempo
        ? t.session.variants.tempoPart(tempo: v.tempo)
        : '';

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Material(
        color: active
            ? scheme.primary.withValues(alpha: 0.1)
            : onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          onTap: disabled ? null : onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              border: Border.all(
                color: active
                    ? scheme.primary.withValues(alpha: 0.4)
                    : onSurface.withValues(alpha: 0.07),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (index == 0) ...[
                      Text(
                        t.session.variants.main,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    if (v.isTimeBased) ...[
                      const Icon(
                        LucideIcons.timer,
                        size: 12,
                        color: AppColors.accentAmber,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Expanded(
                      child: Text(
                        v.name.isEmpty
                            ? t.session.variants.variantN(n: index + 1)
                            : v.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: onSurface,
                        ),
                      ),
                    ),
                    if (active)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          t.session.overview.current,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: scheme.primary,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$summary · '
                  '${t.session.variants.restSeconds(n: v.restTime)}$tempoPart',
                  style: TextStyle(
                    fontSize: 12,
                    color: onSurface.withValues(alpha: 0.55),
                  ),
                ),
                if (v.notes.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      v.notes,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
