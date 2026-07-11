import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/session/application/live_session_controller.dart';
import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/presentation/widgets/exercise_meta.dart';
import 'package:repster/features/session/presentation/widgets/set_card.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';

/// An exercise's `lastPerfs` key (based on the first set).
String exerciseLastPerfKey(WorkoutExercise ex) {
  final target = ex.isTimeBased
      ? (ex.sets.isEmpty ? 0 : (ex.sets.first.targetSeconds ?? 0))
      : (ex.sets.isEmpty ? 0 : ex.sets.first.targetReps);
  return lastPerfKey(
    exerciseName: ex.name,
    target: target,
    isTimeBased: ex.isTimeBased,
  );
}

/// Standalone exercise page: header (title, actions, meta, last time), set
/// list, add-set button and volume summary.
class ExerciseView extends ConsumerWidget {
  const ExerciseView({
    required this.exerciseIndex,
    required this.onOpenSwap,
    required this.onOpenVariants,
    required this.onOpenHistory,
    required this.onStartTimer,
    super.key,
  });

  final int exerciseIndex;
  final void Function(int exIdx) onOpenSwap;
  final void Function(int exIdx) onOpenVariants;
  final void Function(int exIdx) onOpenHistory;
  final void Function(int exIdx, int setIdx) onStartTimer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveSessionControllerProvider);
    final ctl = ref.read(liveSessionControllerProvider.notifier);
    final session = state.session;
    if (session == null || exerciseIndex >= session.exercises.length) {
      return const SizedBox.shrink();
    }
    final ex = session.exercises[exerciseIndex];
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final key = exerciseLastPerfKey(ex);
    final perfs = state.lastPerfs[key] ?? const <LastPerf>[];
    final meta = state.lastPerfsMeta[key];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ex.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                  ExerciseModifiedTag(exercise: ex),
                  if (ex.notes.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        ex.notes,
                        style: TextStyle(
                          fontSize: 12,
                          color: onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ExerciseActions(
              exercise: ex,
              onSwap: () => onOpenSwap(exerciseIndex),
              onVariants: () => onOpenVariants(exerciseIndex),
              onHistory: () => onOpenHistory(exerciseIndex),
            ),
          ],
        ),
        ExerciseMetaChips(exercise: ex),
        ExerciseLastPerfs(exercise: ex, perfs: perfs, meta: meta),
        const SizedBox(height: 16),
        for (var si = 0; si < ex.sets.length; si++) ...[
          if (si > 0) const SizedBox(height: 12),
          _buildSetCard(context, ctl, ex, si, perfs),
        ],
        const SizedBox(height: 12),
        _AddSetButton(onTap: () => ctl.addSet(exerciseIndex)),
        _buildVolumeFooter(context, ex),
      ],
    );
  }

  Widget _buildSetCard(
    BuildContext context,
    LiveSessionController ctl,
    WorkoutExercise ex,
    int si,
    List<LastPerf> perfs,
  ) {
    final set = ex.sets[si];
    final prev = si < perfs.length ? perfs[si] : null;
    final canDelete = ex.sets.length > 1;
    if (ex.isTimeBased) {
      return TimedSetCard(
        set: set,
        prevPerf: prev,
        onUncomplete: () => ctl.uncompleteSet(exerciseIndex, si),
        onConfirmWeight: (w) => ctl.setExerciseWeight(exerciseIndex, w),
        onConfirmTargetSeconds: (s) =>
            ctl.setExerciseTargetSeconds(exerciseIndex, s),
        onStartTimer: () => onStartTimer(exerciseIndex, si),
        onCompleteManually: () {
          final target = set.targetSeconds ?? 30;
          ctl
            ..updateSet(exerciseIndex, si, actualSeconds: target)
            ..completeSet(exerciseIndex, si);
          HapticFeedback.mediumImpact();
        },
        onDelete: canDelete ? () => ctl.removeSet(exerciseIndex, si) : null,
      );
    }
    return SetCard(
      set: set,
      prevPerf: prev,
      onChangedReps: (v) => ctl.updateSet(exerciseIndex, si, actualReps: v),
      onComplete: () {
        ctl.completeSet(exerciseIndex, si);
        HapticFeedback.mediumImpact();
      },
      onUncomplete: () => ctl.uncompleteSet(exerciseIndex, si),
      onConfirmWeight: (w) => ctl.setExerciseWeight(exerciseIndex, w),
      onDelete: canDelete ? () => ctl.removeSet(exerciseIndex, si) : null,
    );
  }

  Widget _buildVolumeFooter(BuildContext context, WorkoutExercise ex) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    String? label;
    if (ex.isTimeBased) {
      if (ex.holdTime > 0) {
        label = t.session.exercise.totalHeld(
          value: formatHoldDuration(ex.holdTime),
        );
      }
    } else if (ex.tonnage > 0) {
      label = t.session.exercise.exerciseVolume(value: ex.tonnage.round());
    }
    if (label == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: onSurface.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

class _AddSetButton extends StatelessWidget {
  const _AddSetButton({required this.onTap});

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
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: onSurface.withValues(alpha: 0.15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.plus,
                size: 16,
                color: onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 8),
              Text(
                t.session.set.addSet,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
