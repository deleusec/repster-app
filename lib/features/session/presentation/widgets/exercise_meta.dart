import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/pressable.dart';

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

/// Age past which a reference is dimmed: beyond ~6 weeks it is context, not a
/// mark to chase.
const _staleAfter = Duration(days: 42);

/// "Last time · 5 d ago" then one chip per set, under the exercise title.
///
/// One chip per set rather than an aggregate: a set that dropped from 10 to 8
/// reps is exactly what you need to see before starting, and any summary hides
/// it. Chips are capped at today's set count (a past 5th set is not actionable
/// on a 3-set exercise) with a `+n` marker so the truncation is never silent.
/// Tapping opens the full history.
class ExerciseLastPerfs extends StatelessWidget {
  const ExerciseLastPerfs({
    required this.exercise,
    required this.perfs,
    this.meta,
    this.onTap,
    super.key,
  });

  final WorkoutExercise exercise;
  final List<LastPerf> perfs;
  final LastPerfMeta? meta;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (perfs.isEmpty) return const SizedBox.shrink();
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final performedAt = meta?.performedAt;
    final isStale =
        performedAt != null &&
        DateTime.now().difference(performedAt) > _staleAfter;
    final dim = onSurface.withValues(alpha: isStale ? 0.35 : 0.55);
    final chipFg = onSurface.withValues(alpha: isStale ? 0.45 : 0.75);
    final targetWas = _targetWasLabel();

    final shown = _shownCount();
    final hidden = perfs.length - shown;

    final header = Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              style: AppText.caption.copyWith(color: dim),
              children: [
                TextSpan(
                  text: t.session.exercise.lastTimeLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                // Said out loud when the reference was borrowed from another
                // workout: same exercise, different day, different freshness.
                if (meta != null && !meta!.fromSameWorkout)
                  TextSpan(text: ' · ${t.session.exercise.otherWorkout}'),
                if (performedAt != null)
                  TextSpan(text: ' · ${relativeAge(performedAt)}'),
                if (targetWas != null) TextSpan(text: ' · $targetWas'),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onTap != null) ...[
          const SizedBox(width: 4),
          Icon(LucideIcons.chevronRight, size: 14, color: dim),
        ],
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onTap == null)
            header
          else
            Pressable(
              onTap: onTap,
              scale: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: header,
              ),
            ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (var i = 0; i < shown; i++)
                MetaChip(label: _perfLabel(perfs[i]), color: chipFg),
              if (hidden > 0)
                MetaChip(
                  label: t.session.exercise.morePerfs(n: hidden),
                  color: dim,
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// Chips are capped at today's set count: beyond it a past set has nothing to
  /// inform. Falls back to the whole list for an exercise with no set yet.
  int _shownCount() {
    if (exercise.sets.isEmpty) return perfs.length;
    return perfs.length < exercise.sets.length
        ? perfs.length
        : exercise.sets.length;
  }

  /// What that session was aiming for, when today's format differs. Shown so a
  /// reference recorded at another target reads as comparable-with-care rather
  /// than as a contradiction.
  String? _targetWasLabel() {
    final past = meta?.target;
    if (past == null || past <= 0 || exercise.sets.isEmpty) return null;
    final today = exercise.isTimeBased
        ? (exercise.sets.first.targetSeconds ?? 0)
        : exercise.sets.first.targetReps;
    if (today <= 0 || today == past) return null;
    return exercise.isTimeBased
        ? t.session.exercise.targetWasSeconds(n: past)
        : t.session.exercise.targetWasReps(n: past);
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
            tint: Theme.of(context).colorScheme.glow,
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
        Pressable(
          onTap: onTap,
          scale: 0.9,
          child: Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: onSurface.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadius.controlSm),
            ),
            child: Icon(
              icon,
              size: 17,
              color: tint ?? onSurface.withValues(alpha: 0.7),
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
                color: scheme.glow,
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
