import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/session/presentation/widgets/duration_picker.dart';
import 'package:repster/features/session/presentation/widgets/stepper_control.dart';
import 'package:repster/features/session/presentation/widgets/weight_ruler_picker.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';

enum _Cmp { up, down, equal }

String _repsPrevPill(LastPerf p) {
  final w = p.weight == 0 ? t.session.bw : '${formatWeight(p.weight)}kg';
  return '${p.reps}×$w';
}

String _timedPrevPill(LastPerf p) {
  final base = formatHoldDuration(p.seconds ?? 0);
  return p.weight > 0 ? '$base · ${formatWeight(p.weight)}kg' : base;
}

/// Shared header for a set card (number / check, label, target, edit/delete
/// buttons, comparison + "last time" pill).
class _SetHeader extends StatelessWidget {
  const _SetHeader({
    required this.set,
    required this.objectiveLabel,
    required this.prevPill,
    required this.comparison,
    this.onDelete,
    this.onEdit,
  });

  final WorkoutSet set;
  final String objectiveLabel;
  final String? prevPill;
  final _Cmp? comparison;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final done = set.completed;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: done
            ? AppColors.accentEmerald.withValues(alpha: 0.06)
            : onSurface.withValues(alpha: 0.03),
        border: Border(
          bottom: BorderSide(
            color: done
                ? AppColors.accentEmerald.withValues(alpha: 0.12)
                : onSurface.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: done
                  ? AppColors.accentEmerald.withValues(alpha: 0.2)
                  : onSurface.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: done
                ? const Icon(
                    LucideIcons.check,
                    size: 14,
                    color: AppColors.accentEmerald,
                  )
                : Text(
                    '${set.setNumber}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: onSurface.withValues(alpha: 0.6),
                    ),
                  ),
          ),
          const SizedBox(width: 10),
          // Title + target shrink/ellipsize to leave room for the right-hand
          // cluster (comparison chip + "last time" pill) instead of
          // overflowing on narrow screens.
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    t.session.set.setLabel(n: set.setNumber),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: done ? AppColors.accentEmerald : onSurface,
                    ),
                  ),
                ),
                if (!done) ...[
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      '· $objectiveLabel',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: onSurface.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (onDelete != null && !done)
            _MiniIconButton(icon: LucideIcons.trash2, onTap: onDelete!),
          if (onEdit != null && done)
            _MiniIconButton(icon: LucideIcons.pencil, onTap: onEdit!),
          if (comparison != null && done) ...[
            const SizedBox(width: 6),
            _ComparisonChip(cmp: comparison!),
          ],
          if (prevPill != null) ...[
            const SizedBox(width: 6),
            _PrevPill(label: prevPill!),
          ],
        ],
      ),
    );
  }
}

/// Card for a reps-based set.
class SetCard extends StatelessWidget {
  const SetCard({
    required this.set,
    required this.prevPerf,
    required this.onChangedReps,
    required this.onComplete,
    required this.onUncomplete,
    required this.onConfirmWeight,
    this.onDelete,
    super.key,
  });

  final WorkoutSet set;
  final LastPerf? prevPerf;
  final ValueChanged<int> onChangedReps;
  final VoidCallback onComplete;
  final VoidCallback onUncomplete;
  final ValueChanged<double> onConfirmWeight;
  final VoidCallback? onDelete;

  _Cmp? get _comparison {
    final prev = prevPerf;
    if (prev == null || !set.completed) return null;
    final prevT = prev.reps * prev.weight;
    final curT = set.actualReps * set.weight;
    final bodyweight = prev.weight == 0 && set.weight == 0;
    if (bodyweight) {
      if (set.actualReps > prev.reps) return _Cmp.up;
      if (set.actualReps < prev.reps) return _Cmp.down;
      return _Cmp.equal;
    }
    if (curT > prevT || set.weight > prev.weight) return _Cmp.up;
    if (curT < prevT) return _Cmp.down;
    return _Cmp.equal;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final done = set.completed;
    final prev = prevPerf;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: done
            ? AppColors.accentEmerald.withValues(alpha: 0.05)
            : onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: done
              ? AppColors.accentEmerald.withValues(alpha: 0.25)
              : onSurface.withValues(alpha: 0.07),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SetHeader(
              set: set,
              objectiveLabel: t.session.set.targetReps(n: set.targetReps),
              prevPill: prev == null ? null : _repsPrevPill(prev),
              comparison: _comparison,
              onDelete: onDelete,
              onEdit: onUncomplete,
            ),
            if (done) _doneBody(context) else _editBody(context),
          ],
        ),
      ),
    );
  }

  Widget _doneBody(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _DoneMetric(label: t.session.set.reps, value: '${set.actualReps}'),
          const SizedBox(width: 16),
          Text(
            '×',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: onSurface.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(width: 16),
          _DoneMetric(
            label: t.session.set.load,
            value: set.weight == 0
                ? t.session.bw
                : '${formatWeight(set.weight)} kg',
          ),
          if (set.weight > 0) ...[
            // Mirrors the PWA's `ml-auto`: a single Spacer pushes the tonnage
            // block hard right. It only works because the metrics to its left
            // are natural width (no Flexible competing for the free space).
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  t.session.set.tonnage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: onSurface.withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${(set.actualReps * set.weight).round()} kg',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _editBody(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: StepperControl(
              label: t.session.set.reps,
              displayValue: '${set.actualReps}',
              accent: true,
              onDecrement: () =>
                  onChangedReps(set.actualReps > 0 ? set.actualReps - 1 : 0),
              onIncrement: () => onChangedReps(set.actualReps + 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 6, right: 6),
            child: Text(
              '×',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
          Expanded(
            child: _WeightButton(
              weight: set.weight,
              onTap: () async {
                final v = await showWeightRulerPicker(
                  context,
                  value: set.weight,
                );
                if (v != null) onConfirmWeight(v);
              },
            ),
          ),
          const SizedBox(width: 10),
          _CheckButton(onTap: onComplete),
        ],
      ),
    );
  }
}

/// Card for a timed set (time-based exercise).
class TimedSetCard extends StatelessWidget {
  const TimedSetCard({
    required this.set,
    required this.prevPerf,
    required this.onUncomplete,
    required this.onConfirmWeight,
    required this.onConfirmTargetSeconds,
    required this.onStartTimer,
    required this.onCompleteManually,
    this.onDelete,
    super.key,
  });

  final WorkoutSet set;
  final LastPerf? prevPerf;
  final VoidCallback onUncomplete;
  final ValueChanged<double> onConfirmWeight;
  final ValueChanged<int> onConfirmTargetSeconds;
  final VoidCallback onStartTimer;

  /// Completes the set without starting the timer (value = target duration).
  final VoidCallback onCompleteManually;
  final VoidCallback? onDelete;

  _Cmp? get _comparison {
    final prev = prevPerf;
    if (prev == null || !set.completed || prev.seconds == null) return null;
    final cur = set.actualSeconds ?? 0;
    if (cur > prev.seconds!) return _Cmp.up;
    if (cur < prev.seconds!) return _Cmp.down;
    return _Cmp.equal;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final done = set.completed;
    final prev = prevPerf;
    final target = set.targetSeconds ?? kDefaultHoldSeconds;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: done
            ? AppColors.accentEmerald.withValues(alpha: 0.05)
            : onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: done
              ? AppColors.accentEmerald.withValues(alpha: 0.25)
              : onSurface.withValues(alpha: 0.07),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SetHeader(
              set: set,
              objectiveLabel: t.session.set.targetDuration(
                value: formatHoldDuration(target),
              ),
              prevPill: prev == null || prev.seconds == null
                  ? null
                  : _timedPrevPill(prev),
              comparison: _comparison,
              onDelete: onDelete,
              onEdit: onUncomplete,
            ),
            if (done) _doneBody(context) else _editBody(context, target),
          ],
        ),
      ),
    );
  }

  Widget _doneBody(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Flexible(
            child: _DoneMetric(
              label: t.session.set.held,
              value: formatHoldDuration(set.actualSeconds ?? 0),
            ),
          ),
          if (set.weight > 0) ...[
            const SizedBox(width: 16),
            Text(
              '×',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: onSurface.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: _DoneMetric(
                label: t.session.set.load,
                value: '${formatWeight(set.weight)} kg',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _editBody(BuildContext context, int target) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _PickerField(
                  label: t.session.set.duration,
                  value: formatHoldDuration(target),
                  accent: true,
                  onTap: () async {
                    final v = await showDurationPicker(context, value: target);
                    if (v != null) onConfirmTargetSeconds(v);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 6, right: 6),
                child: Text(
                  '×',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Expanded(
                child: _WeightButton(
                  weight: set.weight,
                  onTap: () async {
                    final v = await showWeightRulerPicker(
                      context,
                      value: set.weight,
                    );
                    if (v != null) onConfirmWeight(v);
                  },
                ),
              ),
              const SizedBox(width: 10),
              _PlayButton(onTap: onStartTimer),
            ],
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: onCompleteManually,
            style: TextButton.styleFrom(
              foregroundColor: scheme.onSurface.withValues(alpha: 0.5),
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(vertical: 4),
            ),
            child: Text(
              t.session.set.validateWithoutTimer,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared subcomponents ───────────────────────────────────────────────────

class _DoneMetric extends StatelessWidget {
  const _DoneMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: onSurface.withValues(alpha: 0.4),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            height: 1,
            color: AppColors.accentEmerald,
          ),
        ),
      ],
    );
  }
}

class _WeightButton extends StatelessWidget {
  const _WeightButton({required this.weight, required this.onTap});

  final double weight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _PickerField(
      label: t.session.set.load,
      value: weight == 0 ? t.session.bw : formatWeight(weight),
      suffix: weight > 0 ? 'kg' : null,
      onTap: onTap,
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.onTap,
    this.suffix,
    this.accent = false,
  });

  final String label;
  final String value;
  final String? suffix;
  final bool accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    const amber = AppColors.accentAmber;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 6),
        Material(
          color: accent
              ? amber.withValues(alpha: 0.1)
              : onSurface.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppRadius.xl),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            onTap: onTap,
            child: Container(
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xl),
                border: Border.all(
                  color: accent
                      ? amber.withValues(alpha: 0.4)
                      : onSurface.withValues(alpha: 0.08),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        color: accent ? amber : onSurface,
                      ),
                    ),
                    if (suffix != null) ...[
                      const SizedBox(width: 2),
                      Text(
                        suffix!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CheckButton extends StatelessWidget {
  const _CheckButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: [
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(LucideIcons.check, size: 24, color: Colors.white),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const amber = AppColors.accentAmber;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: amber,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: [
            BoxShadow(
              color: amber.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.play_arrow_rounded,
          size: 26,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _MiniIconButton extends StatelessWidget {
  const _MiniIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: onSurface.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 14, color: onSurface.withValues(alpha: 0.6)),
        ),
      ),
    );
  }
}

class _ComparisonChip extends StatelessWidget {
  const _ComparisonChip({required this.cmp});

  final _Cmp cmp;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final (color, bg, icon, label) = switch (cmp) {
      _Cmp.up => (
        AppColors.accentEmerald,
        AppColors.accentEmerald.withValues(alpha: 0.15),
        LucideIcons.trendingUp,
        t.session.set.cmpUp,
      ),
      _Cmp.down => (
        AppColors.accentOrange,
        AppColors.accentOrange.withValues(alpha: 0.1),
        LucideIcons.trendingDown,
        '–',
      ),
      _Cmp.equal => (
        onSurface.withValues(alpha: 0.6),
        onSurface.withValues(alpha: 0.06),
        null,
        '=',
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10, color: color),
            const SizedBox(width: 2),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrevPill extends StatelessWidget {
  const _PrevPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: onSurface.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.clock,
            size: 10,
            color: onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
