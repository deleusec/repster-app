import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/session/presentation/start_session.dart';
import 'package:repster/features/templates/application/programs_controller.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/program.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/presentation/program_actions.dart';
import 'package:repster/features/templates/presentation/widgets/program_folder_card.dart';
import 'package:repster/features/templates/presentation/widgets/session_tile.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/widgets/app_action_sheet.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/empty_state.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/pressable.dart';
import 'package:repster/shared/widgets/screen_header.dart';

/// Height of a grid cell — folders and session tiles share it.
const double _cellHeight = 168;
const double _gap = 12;

/// Widest a cell grows before the grid adds a column. Two columns on a phone;
/// on a wide window the cells keep their phone proportions instead of
/// stretching into strips.
const double _cellMaxWidth = 220;

/// What is being dragged across the grid.
typedef _Dragged = ({bool isProgram, String id});

/// The Programme tab: programs as folders, and the sessions that belong to
/// none of them, in one grid. Holding a cell picks it up — a session dropped
/// on a folder is filed in it, a cell dropped on one of its kind takes its
/// place.
class TemplatesScreen extends ConsumerWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(templatesControllerProvider);
    final programs = ref.watch(programsControllerProvider);

    final AsyncValue<(List<Template>, List<Program>)> both;
    if (templates.hasValue && programs.hasValue) {
      both = AsyncData((templates.requireValue, programs.requireValue));
    } else if (templates.hasError) {
      both = AsyncError(templates.error!, templates.stackTrace!);
    } else if (programs.hasError) {
      both = AsyncError(programs.error!, programs.stackTrace!);
    } else {
      both = const AsyncLoading();
    }

    return GlowScaffold(
      child: AsyncValueWidget<(List<Template>, List<Program>)>(
        value: both,
        onRetry: () {
          ref
            ..invalidate(templatesControllerProvider)
            ..invalidate(programsControllerProvider);
        },
        data: (data) => _Grid(templates: data.$1, programs: data.$2),
      ),
    );
  }
}

enum _Create { session, program }

class _Grid extends ConsumerWidget {
  const _Grid({required this.templates, required this.programs});

  final List<Template> templates;
  final List<Program> programs;

  Future<void> _create(BuildContext context, WidgetRef ref) async {
    final choice = await AppActionSheet.show<_Create>(
      context,
      title: t.templates.list.newAction,
      actions: [
        AppSheetAction(
          value: _Create.session,
          label: t.templates.programs.newSession,
          icon: LucideIcons.dumbbell,
        ),
        AppSheetAction(
          value: _Create.program,
          label: t.templates.programs.newProgram,
          icon: LucideIcons.folderPlus,
        ),
      ],
    );
    if (choice == null || !context.mounted) return;
    switch (choice) {
      case _Create.session:
        await context.push(Routes.templateNew);
      case _Create.program:
        final program = await createProgramFlow(context, ref);
        if (program == null || !context.mounted) return;
        await context.push(Routes.program(program.id));
    }
  }

  /// Moves [id] to the place [targetId] holds in [ids].
  static List<String> _moved(List<String> ids, String id, String targetId) {
    final to = ids.indexOf(targetId);
    return List.of(ids)
      ..remove(id)
      ..insert(to, id);
  }

  Future<void> _drop(
    BuildContext context,
    WidgetRef ref,
    _Dragged dragged, {
    Program? onProgram,
    Template? onSession,
  }) async {
    try {
      if (onProgram != null && !dragged.isProgram) {
        final session = templates.firstWhere((t) => t.id == dragged.id);
        await moveSession(context, ref, session, onProgram);
      } else if (onProgram != null) {
        await ref
            .read(programsControllerProvider.notifier)
            .reorder(
              _moved(
                [for (final p in programs) p.id],
                dragged.id,
                onProgram.id,
              ),
            );
      } else if (onSession != null) {
        await ref
            .read(templatesControllerProvider.notifier)
            .reorder(
              _moved(
                [
                  for (final t in templates)
                    if (t.programId == null) t.id,
                ],
                dragged.id,
                onSession.id,
              ),
            );
      }
    } on Object {
      if (context.mounted) {
        AppToast.showError(context, t.templates.list.reorderError);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final active = templates.where((t) => t.isActive).length;
    final loose = templates
        .where((t) => t.programId == null)
        .toList(growable: false);

    final header = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ScreenHeader(
            title: t.templates.list.title,
            subtitle: t.templates.list.subtitleActive(n: active),
          ),
        ),
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: _CreateChip(onTap: () => _create(context, ref)),
        ),
      ],
    );

    if (templates.isEmpty && programs.isEmpty) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          header,
          const SizedBox(height: 60),
          EmptyState(
            icon: LucideIcons.dumbbell,
            title: t.templates.list.emptyTitle,
            message: t.templates.list.emptyMessage,
            actionLabel: t.templates.list.emptyAction,
            onAction: () => context.push(Routes.templateNew),
          ),
        ],
      );
    }

    final stagger = StaggeredList();
    return RefreshIndicator(
      onRefresh: () => Future.wait([
        ref.read(templatesControllerProvider.notifier).refresh(),
        ref.read(programsControllerProvider.notifier).refresh(),
      ]),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          header,
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = math.max(
                2,
                ((width + _gap) / (_cellMaxWidth + _gap)).ceil(),
              );
              final size = Size(
                (width - _gap * (columns - 1)) / columns,
                _cellHeight,
              );
              return Wrap(
                spacing: _gap,
                runSpacing: _gap,
                children: [
                  for (final program in programs)
                    stagger.wrap(
                      _Cell(
                        key: ValueKey('program-${program.id}'),
                        size: size,
                        data: (isProgram: true, id: program.id),
                        // A folder takes a session, or swaps with a folder.
                        accepts: (_) => true,
                        onDrop: (d) =>
                            _drop(context, ref, d, onProgram: program),
                        builder: (hovering) => Pressable(
                          onTap: () => context.push(Routes.program(program.id)),
                          child: ProgramFolderCard(
                            program: program,
                            sessions: [
                              for (final t in templates)
                                if (t.programId == program.id) t,
                            ],
                            receiving: hovering != null,
                          ),
                        ),
                      ),
                    ),
                  for (final session in loose)
                    stagger.wrap(
                      _Cell(
                        key: ValueKey('session-${session.id}'),
                        size: size,
                        data: (isProgram: false, id: session.id),
                        accepts: (d) => !d.isProgram,
                        onDrop: (d) =>
                            _drop(context, ref, d, onSession: session),
                        builder: (hovering) => SessionTile(
                          template: session,
                          receiving: hovering != null,
                          onOpen: () =>
                              context.push(Routes.templateDetail(session.id)),
                          onStart: () =>
                              startTemplateSession(context, ref, session.id),
                          onMore: () =>
                              showSessionActions(context, ref, session),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          if (programs.isNotEmpty && loose.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                t.templates.programs.dragHint,
                textAlign: TextAlign.center,
                style: AppText.caption.copyWith(color: scheme.textTertiary),
              ),
            ),
        ],
      ),
    );
  }
}

/// One grid cell: picked up by a long press, and a landing spot for the
/// cells it [accepts].
class _Cell extends StatelessWidget {
  const _Cell({
    required this.size,
    required this.data,
    required this.accepts,
    required this.onDrop,
    required this.builder,
    super.key,
  });

  final Size size;
  final _Dragged data;
  final bool Function(_Dragged) accepts;
  final ValueChanged<_Dragged> onDrop;

  /// Builds the cell; the argument is the cell hovering over it, if any.
  final Widget Function(_Dragged? hovering) builder;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: DragTarget<_Dragged>(
        onWillAcceptWithDetails: (d) => d.data.id != data.id && accepts(d.data),
        onAcceptWithDetails: (d) => onDrop(d.data),
        builder: (context, candidates, _) {
          final child = builder(candidates.firstOrNull);
          return LongPressDraggable<_Dragged>(
            data: data,
            onDragStarted: HapticFeedback.mediumImpact,
            childWhenDragging: Opacity(opacity: 0.25, child: child),
            // The overlay sits above the page's Material: without one the
            // text loses its style.
            feedback: Material(
              type: MaterialType.transparency,
              child: SizedBox.fromSize(
                size: size,
                child: Transform.scale(scale: 1.04, child: builder(null)),
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }
}

/// The header's one action, filled with the brand colour and its halo.
class _CreateChip extends StatelessWidget {
  const _CreateChip({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Pressable(
      onTap: onTap,
      scale: 0.94,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(AppRadius.controlSm),
          boxShadow: [
            BoxShadow(
              color: scheme.glow.withValues(alpha: 0.25),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.plus, size: 15, color: scheme.onPrimary),
            const SizedBox(width: 6),
            Text(
              t.templates.list.newAction,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: scheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
