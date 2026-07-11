import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';

/// Small info pill (timed, tempo, rest, ...).
class MetaChip extends StatelessWidget {
  const MetaChip({required this.label, this.icon, this.color, super.key});

  final String label;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final fg = color ?? onSurface.withValues(alpha: 0.6);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: onSurface.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 11, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

/// Row of meta chips (timed / tempo / rest) under the exercise title.
class ExerciseMetaChips extends StatelessWidget {
  const ExerciseMetaChips({required this.exercise, super.key});

  final WorkoutExercise exercise;

  @override
  Widget build(BuildContext context) {
    final ex = exercise;
    final showTempo =
        !ex.isTimeBased && ex.tempo.isNotEmpty && ex.tempo != '0-0-0-0';
    if (!ex.isTimeBased && !showTempo && ex.restTime <= 0) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          if (ex.isTimeBased)
            MetaChip(
              label: t.session.exercise.timed,
              icon: LucideIcons.timer,
              color: AppColors.accentAmber,
            ),
          if (showTempo)
            MetaChip(label: t.session.exercise.tempoChip(tempo: ex.tempo)),
          if (ex.restTime > 0)
            MetaChip(
              label: t.session.exercise.restChip(n: ex.restTime),
              icon: LucideIcons.clock,
            ),
        ],
      ),
    );
  }
}

/// "Last time: S1 - 10x80kg . S2 - ..." under the exercise title.
class ExerciseLastPerfs extends StatelessWidget {
  const ExerciseLastPerfs({
    required this.exercise,
    required this.perfs,
    this.meta,
    super.key,
  });

  final WorkoutExercise exercise;
  final List<LastPerf> perfs;
  final LastPerfMeta? meta;

  @override
  Widget build(BuildContext context) {
    if (perfs.isEmpty) return const SizedBox.shrink();
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final m = meta;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            t.session.exercise.lastTime,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: onSurface.withValues(alpha: 0.5),
            ),
          ),
          if (m != null && m.isFallback && m.originalTarget != null)
            Text(
              exercise.isTimeBased
                  ? t.session.exercise.differentTargetSeconds(
                      n: m.originalTarget!,
                    )
                  : t.session.exercise.differentTargetReps(
                      n: m.originalTarget!,
                    ),
              style: TextStyle(
                fontSize: 10,
                color: onSurface.withValues(alpha: 0.5),
              ),
            ),
          for (var i = 0; i < perfs.length; i++)
            MetaChip(
              label: t.session.exercise.perfEntry(
                n: i + 1,
                value: _perfLabel(perfs[i]),
              ),
            ),
        ],
      ),
    );
  }

  String _perfLabel(LastPerf p) {
    if (exercise.isTimeBased && p.seconds != null) {
      final base = formatHoldDuration(p.seconds!);
      return p.weight > 0 ? '$base · ${formatWeight(p.weight)}kg' : base;
    }
    final w = p.weight == 0 ? t.session.bw : '${formatWeight(p.weight)}kg';
    return '${p.reps}×$w';
  }
}

/// "Modified . this session only (was: ...)" tag.
class ExerciseModifiedTag extends StatelessWidget {
  const ExerciseModifiedTag({required this.exercise, super.key});

  final WorkoutExercise exercise;

  @override
  Widget build(BuildContext context) {
    if (!exercise.sessionModified) return const SizedBox.shrink();
    final was = exercise.originalName;
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        was != null
            ? t.session.exercise.modifiedWas(name: was)
            : t.session.exercise.modified,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.accentAmber.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}

/// Action buttons (variant / swap / completed) to the right of the title.
class ExerciseActions extends StatelessWidget {
  const ExerciseActions({
    required this.exercise,
    required this.onSwap,
    this.onVariants,
    this.onHistory,
    super.key,
  });

  final WorkoutExercise exercise;
  final VoidCallback onSwap;
  final VoidCallback? onVariants;
  final VoidCallback? onHistory;

  @override
  Widget build(BuildContext context) {
    final ex = exercise;
    final hasVariants = ex.variants != null && ex.variants!.length > 1;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasVariants && onVariants != null) ...[
          _ActionButton(
            icon: LucideIcons.shuffle,
            tint: Theme.of(context).colorScheme.primary,
            badge: ex.variants!.length,
            onTap: onVariants!,
          ),
          const SizedBox(width: 8),
        ],
        if (onHistory != null) ...[
          _ActionButton(icon: LucideIcons.history, onTap: onHistory!),
          const SizedBox(width: 8),
        ],
        _ActionButton(icon: LucideIcons.arrowLeftRight, onTap: onSwap),
        if (ex.allSetsCompleted) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accentEmerald.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              t.session.exercise.completedBadge,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accentEmerald,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.onTap,
    this.tint,
    this.badge,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color? tint;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: onSurface.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(AppRadius.controlSm),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.controlSm),
            onTap: onTap,
            child: Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 17,
                color: tint ?? onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            top: -3,
            right: -3,
            child: Container(
              constraints: const BoxConstraints(minWidth: 17),
              height: 17,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                '$badge',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
