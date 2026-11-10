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
import 'package:repster/features/templates/presentation/widgets/session_tile.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_action_sheet.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/app_dialog.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/back_nav_bar.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';

enum _ProgramAction { rename, delete }

/// An open program: its switch, and its sessions in order. Holding a session
/// reorders it.
class ProgramScreen extends ConsumerWidget {
  const ProgramScreen({required this.id, super.key});

  final String id;

  Future<void> _menu(
    BuildContext context,
    WidgetRef ref,
    Program program,
  ) async {
    final action = await AppActionSheet.show<_ProgramAction>(
      context,
      title: program.name,
      actions: [
        AppSheetAction(
          value: _ProgramAction.rename,
          label: t.templates.programs.rename,
          icon: LucideIcons.pencil,
        ),
        AppSheetAction(
          value: _ProgramAction.delete,
          label: t.common.actions.delete,
          icon: LucideIcons.trash2,
          isDestructive: true,
        ),
      ],
    );
    if (action == null || !context.mounted) return;

    final programs = ref.read(programsControllerProvider.notifier);
    try {
      switch (action) {
        case _ProgramAction.rename:
          final name = await showProgramNameSheet(
            context,
            initial: program.name,
          );
          if (name == null || name == program.name) return;
          await programs.rename(program.id, name);
        case _ProgramAction.delete:
          final ok = await AppDialog.confirm(
            context,
            title: t.templates.programs.deleteProgramTitle(name: program.name),
            message: t.templates.programs.deleteProgramMessage,
            confirmLabel: t.common.actions.delete,
            destructive: true,
          );
          if (ok != true || !context.mounted) return;
          // Leave first: the page has nothing to show once it is gone.
          context.pop();
          await programs.delete(program.id);
          if (context.mounted) {
            AppToast.showSuccess(context, t.templates.programs.programDeleted);
          }
      }
    } on Object {
      if (context.mounted) {
        AppToast.showError(context, t.templates.programs.error);
      }
    }
  }

  Future<void> _setActive(
    BuildContext context,
    WidgetRef ref,
    Program program, {
    required bool isActive,
  }) async {
    try {
      await ref
          .read(programsControllerProvider.notifier)
          .setActive(program.id, isActive: isActive);
    } on Object {
      if (context.mounted) {
        AppToast.showError(context, t.templates.programs.error);
      }
    }
  }

  Future<void> _reorder(
    BuildContext context,
    WidgetRef ref,
    List<Template> sessions,
    int oldIndex,
    int newIndex,
  ) async {
    final ids = [for (final s in sessions) s.id];
    final id = ids.removeAt(oldIndex);
    ids.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, id);
    try {
      await ref.read(templatesControllerProvider.notifier).reorder(ids);
    } on Object {
      if (context.mounted) {
        AppToast.showError(context, t.templates.list.reorderError);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final program = ref
        .watch(programsControllerProvider)
        .valueOrNull
        ?.where((p) => p.id == id)
        .firstOrNull;
    // Still loading, or just deleted (the page is on its way out).
    if (program == null) return const GlowScaffold(child: SizedBox.shrink());

    final sessions = [
      for (final t
          in ref.watch(templatesControllerProvider).valueOrNull ??
              const <Template>[])
        if (t.programId == id) t,
    ];

    return GlowScaffold(
      child: ReorderableListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        buildDefaultDragHandles: false,
        proxyDecorator: (child, _, _) =>
            Material(type: MaterialType.transparency, child: child),
        onReorderStart: (_) => HapticFeedback.mediumImpact(),
        onReorder: (from, to) => _reorder(context, ref, sessions, from, to),
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackNavBar(
              onBack: () => context.pop(),
              actionIcon: LucideIcons.ellipsis,
              onAction: () => _menu(context, ref, program),
            ),
            const SizedBox(height: 20),
            Text(
              program.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppText.heroTitle.copyWith(color: scheme.textPrimary),
            ),
            const SizedBox(height: 4),
            Text(
              t.templates.programs.sessionCount(n: sessions.length),
              style: AppText.body.copyWith(color: scheme.textSecondary),
            ),
            const SizedBox(height: 20),
            _ActivationCard(
              isActive: program.isActive,
              onChanged: (v) => _setActive(context, ref, program, isActive: v),
            ),
            const SizedBox(height: 24),
            if (sessions.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 12),
                child: Column(
                  children: [
                    Text(
                      t.templates.programs.emptyTitle,
                      style: AppText.cardTitle.copyWith(
                        color: scheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.templates.programs.emptyMessage,
                      textAlign: TextAlign.center,
                      style: AppText.body.copyWith(color: scheme.textSecondary),
                    ),
                  ],
                ),
              ),
          ],
        ),
        footer: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: AppButton(
            label: t.templates.programs.addSession,
            icon: LucideIcons.plus,
            variant: sessions.isEmpty
                ? AppButtonVariant.primary
                : AppButtonVariant.outline,
            size: AppButtonSize.lg,
            onPressed: () => showAddSessionSheet(context, ref, program),
          ),
        ),
        itemCount: sessions.length,
        itemBuilder: (context, i) {
          final session = sessions[i];
          return Padding(
            key: ValueKey(session.id),
            padding: const EdgeInsets.only(bottom: 12),
            child: ReorderableDelayedDragStartListener(
              index: i,
              child: SessionRow(
                template: session,
                onOpen: () => context.push(Routes.templateDetail(session.id)),
                onStart: () => startTemplateSession(context, ref, session.id),
                onMore: () => showSessionActions(context, ref, session),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// The program's switch, on the one lit surface of the page: the card takes
/// the brand's light while the program is active.
class _ActivationCard extends StatelessWidget {
  const _ActivationCard({required this.isActive, required this.onChanged});

  final bool isActive;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return EdgeLitSurface(
      accent: isActive ? scheme.glow : null,
      pressScale: 0.98,
      haptic: true,
      onTap: () => onChanged(!isActive),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isActive
                        ? t.templates.programs.switchOn
                        : t.templates.programs.switchOff,
                    style: AppText.cardTitle.copyWith(
                      color: scheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t.templates.programs.switchHint,
                    style: AppText.caption.copyWith(
                      color: scheme.textSecondary,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            _Switch(on: isActive),
          ],
        ),
      ),
    );
  }
}

/// A pill switch in the brand's light. Display only — the card is the
/// control, so the whole row answers the tap.
class _Switch extends StatelessWidget {
  const _Switch({required this.on});

  final bool on;

  static const _duration = Duration(milliseconds: 180);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      toggled: on,
      child: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeOut,
        width: 48,
        height: 28,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: on ? scheme.glow : scheme.onSurface.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: AnimatedAlign(
          duration: _duration,
          curve: Curves.easeOut,
          alignment: on ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
