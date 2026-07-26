import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/session/application/live_session_controller.dart';
import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/session_block.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/presentation/widgets/exercise_meta.dart';
import 'package:repster/features/session/presentation/widgets/set_card.dart';
import 'package:repster/i18n/translations.g.dart';

/// Superset block view: all exercises on one page, sets interleaved (S1 A,
/// S1 B, S2 A, ...) with A/B tone dots.
class SupersetBlockView extends ConsumerWidget {
  const SupersetBlockView({
    required this.block,
    required this.onOpenSwap,
    required this.onOpenVariants,
    required this.onOpenHistory,
    required this.onStartTimer,
    super.key,
  });

  final SessionBlock block;
  final void Function(int exIdx) onOpenSwap;
  final void Function(int exIdx) onOpenVariants;
  final void Function(int exIdx) onOpenHistory;
  final void Function(int exIdx, int setIdx) onStartTimer;

  Color _tone(BuildContext context, int idx) {
    final scheme = Theme.of(context).colorScheme;
    return switch (idx % 3) {
      0 => scheme.primary,
      1 => scheme.onSurface.withValues(alpha: 0.7),
      _ => scheme.onSurface.withValues(alpha: 0.45),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveSessionControllerProvider);
    final session = state.session;
    if (session == null) return const SizedBox.shrink();
    final exos = [
      for (final i in block.exerciseIndices)
        if (i < session.exercises.length) (idx: i, ex: session.exercises[i]),
    ];
    if (exos.isEmpty) return const SizedBox.shrink();
    final maxSets = exos
        .map((e) => e.ex.sets.length)
        .reduce((a, b) => a > b ? a : b);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Block badge
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIcons.link2, size: 11, color: scheme.primary),
              const SizedBox(width: 4),
              Text(
                t.session.superset.badge(n: exos.length),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: scheme.primary,
                ),
              ),
            ],
          ),
        ),

        // Exercise headers
        for (var k = 0; k < exos.length; k++)
          _ExoHeader(
            exerciseIndex: exos[k].idx,
            exercise: exos[k].ex,
            serial: k + 1,
            isFirst: k == 0,
            lastPerfs: state.lastPerfs,
            lastPerfsMeta: state.lastPerfsMeta,
            onSwap: () => onOpenSwap(exos[k].idx),
            onVariants: () => onOpenVariants(exos[k].idx),
            onHistory: () => onOpenHistory(exos[k].idx),
          ),

        const SizedBox(height: 8),

        // Interleaved sets
        for (var si = 0; si < maxSets; si++)
          for (var k = 0; k < exos.length; k++)
            if (si < exos[k].ex.sets.length)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _InterleavedSet(
                  exerciseIndex: exos[k].idx,
                  exercise: exos[k].ex,
                  setIndex: si,
                  letter: String.fromCharCode(65 + k),
                  tone: _tone(context, k),
                  lastPerfs: state.lastPerfs,
                  onStartTimer: onStartTimer,
                ),
              ),

        // Add-set per exercise
        const SizedBox(height: 4),
        for (var k = 0; k < exos.length; k++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _AddSetToExo(
              label: String.fromCharCode(65 + k),
              exerciseName: exos[k].ex.name,
              onTap: () => ref
                  .read(liveSessionControllerProvider.notifier)
                  .addSet(exos[k].idx),
            ),
          ),
      ],
    );
  }
}

class _ExoHeader extends StatelessWidget {
  const _ExoHeader({
    required this.exerciseIndex,
    required this.exercise,
    required this.serial,
    required this.isFirst,
    required this.lastPerfs,
    required this.lastPerfsMeta,
    required this.onSwap,
    required this.onVariants,
    required this.onHistory,
  });

  final int exerciseIndex;
  final WorkoutExercise exercise;
  final int serial;
  final bool isFirst;
  final Map<String, List<LastPerf>> lastPerfs;
  final Map<String, LastPerfMeta> lastPerfsMeta;
  final VoidCallback onSwap;
  final VoidCallback onVariants;
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final key = exerciseLastPerfKey(exercise);
    final perfs = lastPerfs[key] ?? const <LastPerf>[];
    final meta = lastPerfsMeta[key];
    return Padding(
      padding: EdgeInsets.only(top: isFirst ? 0 : 24, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                serial.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  height: 1,
                  color: isFirst
                      ? scheme.primary.withValues(alpha: 0.8)
                      : onSurface.withValues(alpha: 0.35),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 1,
                  color: isFirst
                      ? scheme.primary.withValues(alpha: 0.4)
                      : onSurface.withValues(alpha: 0.15),
                ),
              ),
              const SizedBox(width: 12),
              ExerciseActions(
                exercise: exercise,
                onSwap: onSwap,
                onVariants: onVariants,
                onHistory: onHistory,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            exercise.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          ExerciseModifiedTag(exercise: exercise),
          if (exercise.notes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                exercise.notes,
                style: TextStyle(
                  fontSize: 12,
                  color: onSurface.withValues(alpha: 0.55),
                ),
              ),
            ),
          ExerciseMetaChips(exercise: exercise),
          ExerciseLastPerfs(
            exercise: exercise,
            perfs: perfs,
            meta: meta,
            onTap: onHistory,
          ),
        ],
      ),
    );
  }
}

class _InterleavedSet extends ConsumerWidget {
  const _InterleavedSet({
    required this.exerciseIndex,
    required this.exercise,
    required this.setIndex,
    required this.letter,
    required this.tone,
    required this.lastPerfs,
    required this.onStartTimer,
  });

  final int exerciseIndex;
  final WorkoutExercise exercise;
  final int setIndex;
  final String letter;
  final Color tone;
  final Map<String, List<LastPerf>> lastPerfs;
  final void Function(int exIdx, int setIdx) onStartTimer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctl = ref.read(liveSessionControllerProvider.notifier);
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final set = exercise.sets[setIndex];
    final key = exerciseLastPerfKey(exercise);
    final perfs = lastPerfs[key] ?? const <LastPerf>[];
    final prev = perfForSet(perfs, setIndex);
    final canDelete = exercise.sets.length > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                letter,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                  color: tone,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  exercise.name.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    color: onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (exercise.isTimeBased)
          TimedSetCard(
            set: set,
            prevPerf: prev,
            onUncomplete: () => ctl.uncompleteSet(exerciseIndex, setIndex),
            onConfirmWeight: (w) => ctl.setExerciseWeight(exerciseIndex, w),
            onConfirmTargetSeconds: (s) =>
                ctl.setExerciseTargetSeconds(exerciseIndex, s),
            onStartTimer: () => onStartTimer(exerciseIndex, setIndex),
            onCompleteManually: () {
              final target = set.targetSeconds ?? 30;
              ctl
                ..updateSet(exerciseIndex, setIndex, actualSeconds: target)
                ..completeSet(exerciseIndex, setIndex);
              HapticFeedback.mediumImpact();
            },
            onDelete: canDelete
                ? () => ctl.removeSet(exerciseIndex, setIndex)
                : null,
          )
        else
          SetCard(
            set: set,
            prevPerf: prev,
            onChangedReps: (v) =>
                ctl.updateSet(exerciseIndex, setIndex, actualReps: v),
            onComplete: () {
              ctl.completeSet(exerciseIndex, setIndex);
              HapticFeedback.mediumImpact();
            },
            onUncomplete: () => ctl.uncompleteSet(exerciseIndex, setIndex),
            onConfirmWeight: (w) => ctl.setExerciseWeight(exerciseIndex, w),
            onDelete: canDelete
                ? () => ctl.removeSet(exerciseIndex, setIndex)
                : null,
          ),
      ],
    );
  }
}

class _AddSetToExo extends StatelessWidget {
  const _AddSetToExo({
    required this.label,
    required this.exerciseName,
    required this.onTap,
  });

  final String label;
  final String exerciseName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Container(
          height: 44,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: onSurface.withValues(alpha: 0.12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.plus,
                size: 15,
                color: onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  t.session.superset.addSetTo(
                    letter: label,
                    name: exerciseName,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
