import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/muscle_group_chip.dart';
import 'package:repster/shared/widgets/screen_header.dart';
import 'package:repster/shared/widgets/section_label.dart';

class SessionDetailScreen extends ConsumerWidget {
  const SessionDetailScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionByIdProvider(sessionId));
    return GlowScaffold(
      child: AsyncValueWidget<WorkoutSession>(
        value: sessionAsync,
        onRetry: () => ref.invalidate(sessionByIdProvider(sessionId)),
        data: _Body.new,
      ),
    );
  }
}

String _formatDate(DateTime when) {
  final label = DateFormat(t.history.detail.dateFormat).format(when);
  return label.substring(0, 1).toUpperCase() + label.substring(1);
}

class _Body extends StatelessWidget {
  const _Body(this.session);
  final WorkoutSession session;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final stagger = StaggeredList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        // ── Back button + hero title ──────────────────────────────────────
        stagger.wrap(const _NavBar()),
        const SizedBox(height: 20),
        stagger.wrap(
          ScreenHeader(
            title: session.templateName,
            subtitle: _formatDate(session.startedAt),
          ),
        ),
        const SizedBox(height: 20),

        // ── Stat tiles ────────────────────────────────────────────────────
        stagger.wrap(
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: LucideIcons.dumbbell,
                  label: t.history.detail.tonnage,
                  value: formatTonnage(session.totalTonnage),
                  color: AppColors.accentEmerald,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatTile(
                  icon: LucideIcons.timer,
                  label: t.history.detail.duration,
                  value: formatDuration(session.duration),
                  color: AppColors.accentBlue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatTile(
                  icon: LucideIcons.repeat,
                  label: t.history.detail.sets,
                  value: '${session.completedSets}',
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ),

        // ── Tags ──────────────────────────────────────────────────────────
        if (session.tags.isNotEmpty) ...[
          const SizedBox(height: 14),
          stagger.wrap(
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final tag in session.tags)
                  MuscleGroupChip(group: tag, dense: true),
              ],
            ),
          ),
        ],

        // ── Per-exercise breakdown ────────────────────────────────────────
        const SizedBox(height: 24),
        stagger.wrap(SectionLabel(t.history.detail.perExercise)),
        const SizedBox(height: 12),
        for (var i = 0; i < session.exercises.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: stagger.wrap(
              _ExerciseCard(exercise: session.exercises[i], index: i),
            ),
          ),

        // ── Notes ─────────────────────────────────────────────────────────
        if (session.notes.isNotEmpty) ...[
          const SizedBox(height: 4),
          stagger.wrap(_NotesCard(session.notes)),
        ],
      ],
    );
  }
}

/// Top nav row for the pushed detail page: just the back button, left-aligned.
class _NavBar extends StatelessWidget {
  const _NavBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavButton(icon: LucideIcons.chevronLeft, onTap: () => context.pop()),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.controlSm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.controlSm),
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppRadius.controlSm),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: Icon(icon, size: 17, color: onSurface.withValues(alpha: 0.6)),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: scheme.translucentCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: scheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.exercise, required this.index});

  final WorkoutExercise exercise;
  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final done = exercise.sets.where((s) => s.completed).toList();
    final isTime = exercise.isTimeBased;

    return DecoratedBox(
      decoration: scheme.translucentCard,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header: index badge + name + summary
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: onSurface.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (isTime) ...[
                              const Icon(
                                LucideIcons.timer,
                                size: 14,
                                color: AppColors.accentAmber,
                              ),
                              const SizedBox(width: 5),
                            ],
                            Flexible(
                              child: Text(
                                exercise.name.isEmpty
                                    ? '—'
                                    : exercise.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _summary(done.length, isTime),
                          style: TextStyle(
                            fontSize: 12,
                            color: onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Set table (completed sets only)
            if (done.isNotEmpty) _SetTable(exercise: exercise, sets: done),
          ],
        ),
      ),
    );
  }

  String _summary(int count, bool isTime) {
    final sets = t.history.detail.setsCount(n: count);
    if (isTime) {
      return '$sets · ${formatHoldDuration(exercise.holdTime)}';
    }
    final volume = exercise.tonnage;
    if (volume <= 0) return '$sets · ${t.history.detail.bodyweight}';
    return '$sets · ${formatTonnage(volume)}';
  }
}

/// Aligned columns for the per-set table. Weight-based exercises show
/// Set / Reps / Load / Tonnage; time-based ones show Set / Held / Load.
class _SetTable extends StatelessWidget {
  const _SetTable({required this.exercise, required this.sets});

  final WorkoutExercise exercise;
  final List<WorkoutSet> sets;

  static const _flexSet = 22;
  static const _flexA = 26;
  static const _flexB = 26;
  static const _flexC = 30;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isTime = exercise.isTimeBased;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Divider(scheme.hairline),
        // Header row
        _Row(
          background: scheme.onSurface.withValues(alpha: 0.04),
          cells: isTime
              ? [
                  _HeaderCell(t.history.detail.colSet, _flexSet),
                  _HeaderCell(t.history.detail.colHeld, _flexA),
                  _HeaderCell(t.history.detail.colLoad, _flexB),
                ]
              : [
                  _HeaderCell(t.history.detail.colSet, _flexSet),
                  _HeaderCell(t.history.detail.colReps, _flexA),
                  _HeaderCell(t.history.detail.colLoad, _flexB),
                  _HeaderCell(t.history.detail.tonnage, _flexC),
                ],
        ),
        // Data rows
        for (final s in sets) ...[
          _Divider(scheme.hairline),
          _Row(
            cells: isTime ? _timeCells(scheme, s) : _weightCells(scheme, s),
          ),
        ],
        // Subtotal
        _Divider(scheme.hairline),
        _Row(
          background: scheme.onSurface.withValues(alpha: 0.04),
          cells: [
            _TextCell(
              isTime
                  ? t.history.detail.totalHeld
                  : t.history.detail.totalExercise,
              flex: _flexSet + _flexA,
              color: scheme.onSurface.withValues(alpha: 0.5),
              size: 11.5,
            ),
            _TextCell(
              isTime
                  ? formatHoldDuration(exercise.holdTime)
                  : formatTonnage(exercise.tonnage),
              flex: isTime ? _flexB : _flexB + _flexC,
              color: isTime
                  ? AppColors.accentBlue
                  : AppColors.accentEmerald,
              weight: FontWeight.w700,
              align: TextAlign.end,
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _weightCells(ColorScheme scheme, WorkoutSet s) {
    final onSurface = scheme.onSurface;
    final volume = s.actualReps * s.weight;
    return [
      _TextCell(
        '#${s.setNumber}',
        flex: _flexSet,
        color: onSurface.withValues(alpha: 0.5),
      ),
      _TextCell('${s.actualReps}', flex: _flexA, weight: FontWeight.w600),
      _TextCell(_load(s.weight), flex: _flexB, weight: FontWeight.w600),
      _TextCell(
        volume <= 0 ? '–' : formatTonnage(volume),
        flex: _flexC,
        color: volume <= 0
            ? onSurface.withValues(alpha: 0.35)
            : AppColors.accentEmerald,
        weight: FontWeight.w600,
      ),
    ];
  }

  List<Widget> _timeCells(ColorScheme scheme, WorkoutSet s) {
    final onSurface = scheme.onSurface;
    final secs = s.actualSeconds ?? s.targetSeconds ?? 0;
    return [
      _TextCell(
        '#${s.setNumber}',
        flex: _flexSet,
        color: onSurface.withValues(alpha: 0.5),
      ),
      _TextCell(
        formatHoldDuration(secs),
        flex: _flexA,
        weight: FontWeight.w600,
      ),
      _TextCell(_load(s.weight), flex: _flexB, weight: FontWeight.w600),
    ];
  }

  String _load(double weight) =>
      weight == 0 ? t.session.bw : '${formatWeight(weight)} kg';
}

class _Row extends StatelessWidget {
  const _Row({required this.cells, this.background});

  final List<Widget> cells;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background ?? Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        child: Row(children: cells),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text, this.flex);
  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      flex: flex,
      child: Text(
        text.toUpperCase(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: scheme.onSurface.withValues(alpha: 0.45),
        ),
      ),
    );
  }
}

class _TextCell extends StatelessWidget {
  const _TextCell(
    this.text, {
    required this.flex,
    this.color,
    this.weight,
    this.size,
    this.align = TextAlign.start,
  });

  final String text;
  final int flex;
  final Color? color;
  final FontWeight? weight;
  final double? size;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: align,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: size ?? 13,
          fontWeight: weight ?? FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) => Container(height: 1, color: color);
}

class _NotesCard extends StatelessWidget {
  const _NotesCard(this.notes);
  final String notes;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: scheme.translucentCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.fileText,
                size: 14,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 6),
              Text(
                t.history.detail.notes,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(notes, style: const TextStyle(fontSize: 13, height: 1.5)),
        ],
      ),
    );
  }
}
