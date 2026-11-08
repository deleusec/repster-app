import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/session/application/live_session_controller.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_dialog.dart';
import 'package:repster/shared/widgets/glass_surface.dart';
import 'package:repster/shared/widgets/pressable.dart';

/// "Exercises" side panel: list with progress bars, edit mode (reorder, delete
/// with confirmation) and add. Used as the session screen's `endDrawer`.
class OverviewPanel extends ConsumerStatefulWidget {
  const OverviewPanel({required this.onGoTo, required this.onAdd, super.key});

  final void Function(int index) onGoTo;
  final VoidCallback onAdd;

  @override
  ConsumerState<OverviewPanel> createState() => _OverviewPanelState();
}

class _OverviewPanelState extends ConsumerState<OverviewPanel> {
  bool _editMode = false;

  Future<void> _requestDelete(int i, WorkoutExercise ex, int total) async {
    if (total <= 1) return;
    final completed = ex.completedSetCount;
    if (completed == 0) {
      ref.read(liveSessionControllerProvider.notifier).removeExercise(i);
      return;
    }
    final ok = await _confirmDelete(ex.name, completed);
    if (ok && mounted) {
      ref.read(liveSessionControllerProvider.notifier).removeExercise(i);
    }
  }

  Future<bool> _confirmDelete(String name, int completed) async {
    final ok = await AppDialog.confirm(
      context,
      title: t.session.confirm.deleteExerciseTitle(name: name),
      message: t.session.confirm.deleteExerciseMessage(n: completed),
      confirmLabel: t.common.actions.delete,
      destructive: true,
    );
    return ok ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(liveSessionControllerProvider);
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final session = state.session;
    final exercises = session?.exercises ?? const <WorkoutExercise>[];
    final currentIdx = state.currentExerciseIndex;

    const radius = BorderRadius.horizontal(
      left: Radius.circular(AppRadius.sheet),
    );
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: radius),
      width: MediaQuery.sizeOf(context).width * 0.86,
      child: GlassSurface(
        borderRadius: radius,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 12, 8),
                child: Row(
                  children: [
                    Text(
                      t.session.overview.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: onSurface,
                      ),
                    ),
                    const Spacer(),
                    _EditToggle(
                      editMode: _editMode,
                      onTap: () => setState(() => _editMode = !_editMode),
                    ),
                    const SizedBox(width: 8),
                    _CloseButton(
                      onTap: () => Scaffold.of(context).closeEndDrawer(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _editMode
                    ? _buildEditList(exercises, currentIdx)
                    : _buildNavList(context, exercises, currentIdx),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: _AddRow(
                  onTap: () {
                    Scaffold.of(context).closeEndDrawer();
                    widget.onAdd();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavList(
    BuildContext context,
    List<WorkoutExercise> exercises,
    int currentIdx,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      itemCount: exercises.length,
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _NavRow(
          index: i,
          exercise: exercises[i],
          isCurrent: i == currentIdx,
          onTap: () {
            Scaffold.of(context).closeEndDrawer();
            widget.onGoTo(i);
          },
        ),
      ),
    );
  }

  Widget _buildEditList(List<WorkoutExercise> exercises, int currentIdx) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      itemCount: exercises.length,
      buildDefaultDragHandles: false,
      onReorder: (oldIndex, newIndex) {
        var target = newIndex;
        if (target > oldIndex) target -= 1;
        if (target == oldIndex) return;
        ref
            .read(liveSessionControllerProvider.notifier)
            .reorderExercise(oldIndex, target);
      },
      itemBuilder: (context, i) => Padding(
        key: ValueKey(exercises[i].id),
        padding: const EdgeInsets.only(bottom: 12),
        child: _EditRow(
          index: i,
          exercise: exercises[i],
          isCurrent: i == currentIdx,
          total: exercises.length,
          onDelete: () => _requestDelete(i, exercises[i], exercises.length),
        ),
      ),
    );
  }
}

/// Panel close button, aligned with the design system (square icon button
/// rounded to `controlSm`, like the drawer close buttons).
class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Pressable(
      onTap: onTap,
      scale: 0.9,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onSurface.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppRadius.controlSm),
          border: Border.all(color: onSurface.withValues(alpha: 0.08)),
        ),
        child: Icon(
          LucideIcons.x,
          size: 16,
          color: onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

class _EditToggle extends StatelessWidget {
  const _EditToggle({required this.editMode, required this.onTap});

  final bool editMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final fg = editMode ? scheme.glow : onSurface.withValues(alpha: 0.6);
    return Pressable(
      onTap: onTap,
      scale: 0.94,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: editMode
              ? scheme.glow.withValues(alpha: 0.14)
              : onSurface.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              editMode ? LucideIcons.check : LucideIcons.pencil,
              size: 14,
              color: fg,
            ),
            const SizedBox(width: 6),
            Text(
              editMode ? t.common.actions.done : t.common.actions.edit,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.index,
    required this.exercise,
    required this.isCurrent,
    required this.onTap,
  });

  final int index;
  final WorkoutExercise exercise;
  final bool isCurrent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final completed = exercise.completedSetCount;
    final isComplete = completed == exercise.sets.length;
    final glow = scheme.glow;
    return Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isCurrent
              ? glow.withValues(alpha: 0.09)
              : onSurface.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: isCurrent
                ? glow.withValues(alpha: 0.4)
                : onSurface.withValues(alpha: 0.07),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (exercise.isTimeBased) ...[
                  const Icon(
                    LucideIcons.timer,
                    size: 12,
                    color: AppColors.accentAmber,
                  ),
                  const SizedBox(width: 6),
                ],
                if (exercise.inSuperset) ...[
                  Icon(LucideIcons.link2, size: 12, color: glow),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Text(
                    '${index + 1}. ${exercise.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isCurrent ? glow : onSurface,
                    ),
                  ),
                ),
                if (isComplete)
                  const Icon(
                    LucideIcons.check,
                    size: 16,
                    color: AppColors.accentEmerald,
                  )
                else if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: glow.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      t.session.overview.current,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: glow,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                for (var s = 0; s < exercise.sets.length; s++) ...[
                  if (s > 0) const SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: exercise.sets[s].completed
                            ? AppColors.accentEmerald
                            : isCurrent
                            ? onSurface.withValues(alpha: 0.35)
                            : onSurface.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Text(
              t.session.overview.setsValidated(
                completed: completed,
                total: exercise.sets.length,
              ),
              style: TextStyle(
                fontSize: 12,
                color: onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditRow extends StatelessWidget {
  const _EditRow({
    required this.index,
    required this.exercise,
    required this.isCurrent,
    required this.total,
    required this.onDelete,
  });

  final int index;
  final WorkoutExercise exercise;
  final bool isCurrent;
  final int total;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 8, 8, 8),
      decoration: BoxDecoration(
        color: isCurrent
            ? scheme.glow.withValues(alpha: 0.09)
            : onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: isCurrent
              ? scheme.glow.withValues(alpha: 0.4)
              : onSurface.withValues(alpha: 0.07),
        ),
      ),
      child: Row(
        children: [
          // Drag handle (drag & drop to reorder).
          ReorderableDragStartListener(
            index: index,
            child: MouseRegion(
              cursor: SystemMouseCursors.grab,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: Icon(
                  LucideIcons.gripVertical,
                  size: 18,
                  color: onSurface.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Text(
              '${index + 1}. ${exercise.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isCurrent ? scheme.glow : onSurface,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _SquareBtn(
            icon: LucideIcons.trash2,
            onTap: total <= 1 ? null : onDelete,
            danger: true,
          ),
        ],
      ),
    );
  }
}

class _SquareBtn extends StatelessWidget {
  const _SquareBtn({
    required this.icon,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final disabled = onTap == null;
    final color = danger ? scheme.error : onSurface.withValues(alpha: 0.7);
    return Opacity(
      opacity: disabled ? 0.2 : 1,
      child: Pressable(
        onTap: onTap,
        scale: 0.88,
        child: Container(
          width: danger ? 34 : 28,
          height: danger ? 34 : 24,
          decoration: BoxDecoration(
            color: danger
                ? scheme.error.withValues(alpha: 0.1)
                : onSurface.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(icon, size: 15, color: color),
        ),
      ),
    );
  }
}

class _AddRow extends StatelessWidget {
  const _AddRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Pressable(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: onSurface.withValues(alpha: 0.14)),
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
              t.session.add.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
