import 'package:flutter/material.dart';
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
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_action_sheet.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/app_dialog.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';
import 'package:repster/shared/widgets/app_text_field.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/pressable.dart';
import 'package:repster/shared/widgets/session_mark.dart';

// The flows shared by the Programme grid and a program's page: naming a
// program, moving a session, and a session's action menu.

// ── Naming a program ────────────────────────────────────────────────────────

/// Asks for a program name. [initial] switches the sheet to "rename".
/// Returns the trimmed name, or `null` if dismissed.
Future<String?> showProgramNameSheet(BuildContext context, {String? initial}) {
  return AppDrawerSheet.show<String>(
    context,
    title: initial == null
        ? t.templates.programs.nameTitleNew
        : t.templates.programs.nameTitleRename,
    child: _ProgramNameForm(initial: initial),
  );
}

class _ProgramNameForm extends StatefulWidget {
  const _ProgramNameForm({this.initial});

  final String? initial;

  @override
  State<_ProgramNameForm> createState() => _ProgramNameFormState();
}

class _ProgramNameFormState extends State<_ProgramNameForm> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          controller: _controller,
          hint: t.templates.programs.nameHint,
          autofocus: true,
          maxLength: 80,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: 14),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (context, value, _) => AppButton(
            label: widget.initial == null
                ? t.templates.programs.createAction
                : t.common.actions.save,
            size: AppButtonSize.lg,
            onPressed: value.text.trim().isEmpty ? null : _submit,
          ),
        ),
      ],
    );
  }
}

/// Names and creates a program. Returns it, or `null` if cancelled or failed.
Future<Program?> createProgramFlow(BuildContext context, WidgetRef ref) async {
  final name = await showProgramNameSheet(context);
  if (name == null) return null;
  try {
    return await ref.read(programsControllerProvider.notifier).create(name);
  } on Object {
    if (context.mounted) {
      AppToast.showError(context, t.templates.programs.error);
    }
    return null;
  }
}

// ── Moving a session ────────────────────────────────────────────────────────

/// Files [template] under [program] (`null` takes it out of its program) and
/// says where it went.
Future<void> moveSession(
  BuildContext context,
  WidgetRef ref,
  Template template,
  Program? program,
) async {
  if (template.programId == program?.id) return;
  try {
    await ref
        .read(templatesControllerProvider.notifier)
        .moveToProgram(template.id, program?.id);
    if (!context.mounted) return;
    AppToast.showSuccess(
      context,
      program == null
          ? t.templates.programs.movedOut
          : t.templates.programs.moved(name: program.name),
    );
  } on Object {
    if (context.mounted) {
      AppToast.showError(context, t.templates.programs.error);
    }
  }
}

/// What the "Move to" sheet answers.
sealed class _MoveChoice {
  const _MoveChoice();
}

class _MoveTo extends _MoveChoice {
  const _MoveTo(this.program);

  /// `null`: out of any program.
  final Program? program;
}

class _MoveToNew extends _MoveChoice {
  const _MoveToNew();
}

/// Lets the user pick where [template] goes: one of the programs, a new one,
/// or out of its current one.
Future<void> showMoveSessionSheet(
  BuildContext context,
  WidgetRef ref,
  Template template,
) async {
  final programs =
      ref.read(programsControllerProvider).valueOrNull ?? const <Program>[];
  final choice = await AppDrawerSheet.show<_MoveChoice>(
    context,
    title: t.templates.programs.moveTitle,
    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final p in programs)
            _SheetRow(
              icon: LucideIcons.folder,
              label: p.name,
              selected: p.id == template.programId,
              value: _MoveTo(p),
            ),
          if (template.programId != null)
            _SheetRow(
              icon: LucideIcons.folderOutput,
              label: t.templates.programs.loose,
              value: const _MoveTo(null),
            ),
          _SheetRow(
            icon: LucideIcons.folderPlus,
            label: t.templates.programs.nameTitleNew,
            value: const _MoveToNew(),
          ),
        ],
      ),
    ),
  );
  if (choice == null || !context.mounted) return;

  switch (choice) {
    case _MoveTo(:final program):
      await moveSession(context, ref, template, program);
    case _MoveToNew():
      final program = await createProgramFlow(context, ref);
      if (program == null || !context.mounted) return;
      await moveSession(context, ref, template, program);
  }
}

/// Picks a session to add to [program]: an existing one filed elsewhere, or
/// a new one.
Future<void> showAddSessionSheet(
  BuildContext context,
  WidgetRef ref,
  Program program,
) async {
  final templates =
      ref.read(templatesControllerProvider).valueOrNull ?? const <Template>[];
  final programs =
      ref.read(programsControllerProvider).valueOrNull ?? const <Program>[];
  final names = {for (final p in programs) p.id: p.name};
  final others = templates
      .where((t) => t.programId != program.id)
      .toList(growable: false);

  // `true`: create a new session; a [Template]: move that one in.
  final choice = await AppDrawerSheet.show<Object>(
    context,
    title: t.templates.programs.addSessionTitle(name: program.name),
    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SheetRow(
            icon: LucideIcons.plus,
            label: t.templates.programs.createSession,
            value: true,
          ),
          for (final s in others)
            _SheetRow(
              leading: SessionMark(
                emoji: s.emoji,
                size: 36,
                radius: AppRadius.controlSm,
              ),
              label: s.name,
              caption: names[s.programId] ?? t.templates.programs.loose,
              value: s,
            ),
        ],
      ),
    ),
  );
  if (choice == null || !context.mounted) return;

  if (choice is Template) {
    await moveSession(context, ref, choice, program);
  } else {
    await context.push(Routes.templateNewIn(program.id));
  }
}

/// A row of a picker sheet; tapping pops the sheet with [value].
class _SheetRow extends StatelessWidget {
  const _SheetRow({
    required this.label,
    required this.value,
    this.icon,
    this.leading,
    this.caption,
    this.selected = false,
  });

  final String label;
  final Object value;
  final IconData? icon;
  final Widget? leading;
  final String? caption;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final caption = this.caption;
    return Pressable(
      onTap: () => Navigator.of(context).pop(value),
      scale: 0.98,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            leading ??
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scheme.onSurface.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(AppRadius.controlSm),
                  ),
                  child: Icon(icon, size: 17, color: scheme.textSecondary),
                ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.subtitle.copyWith(color: scheme.textPrimary),
                  ),
                  if (caption != null)
                    Text(
                      caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.caption.copyWith(
                        color: scheme.textTertiary,
                      ),
                    ),
                ],
              ),
            ),
            if (selected) Icon(LucideIcons.check, size: 18, color: scheme.glow),
          ],
        ),
      ),
    );
  }
}

// ── A session's actions ─────────────────────────────────────────────────────

enum _SessionAction { start, edit, toggle, move, duplicate, delete }

/// Opens the action menu of a session and carries out the chosen action.
Future<void> showSessionActions(
  BuildContext context,
  WidgetRef ref,
  Template template,
) async {
  final action = await AppActionSheet.show<_SessionAction>(
    context,
    title: template.name,
    actions: [
      AppSheetAction(
        value: _SessionAction.start,
        label: t.templates.programs.start,
        icon: LucideIcons.play,
      ),
      AppSheetAction(
        value: _SessionAction.edit,
        label: t.common.actions.edit,
        icon: LucideIcons.pencil,
      ),
      AppSheetAction(
        value: _SessionAction.toggle,
        label: template.isActive
            ? t.templates.card.deactivate
            : t.templates.card.activate,
        icon: template.isActive
            ? LucideIcons.circleOff
            : LucideIcons.circleCheck,
      ),
      AppSheetAction(
        value: _SessionAction.move,
        label: t.templates.programs.move,
        icon: LucideIcons.folderInput,
      ),
      AppSheetAction(
        value: _SessionAction.duplicate,
        label: t.templates.programs.duplicate,
        icon: LucideIcons.copy,
      ),
      AppSheetAction(
        value: _SessionAction.delete,
        label: t.common.actions.delete,
        icon: LucideIcons.trash2,
        isDestructive: true,
      ),
    ],
  );
  if (action == null || !context.mounted) return;

  final templates = ref.read(templatesControllerProvider.notifier);
  switch (action) {
    case _SessionAction.start:
      await startTemplateSession(context, ref, template.id);
    case _SessionAction.edit:
      await context.push(Routes.templateEdit(template.id));
    case _SessionAction.move:
      await showMoveSessionSheet(context, ref, template);
    case _SessionAction.toggle:
      try {
        await templates.toggleActive(template.id, isActive: !template.isActive);
      } on Object {
        if (context.mounted) {
          AppToast.showError(context, t.templates.list.toggleError);
        }
      }
    case _SessionAction.duplicate:
      try {
        await templates.duplicate(template.id);
        if (context.mounted) {
          AppToast.showSuccess(context, t.templates.list.duplicated);
        }
      } on Object {
        if (context.mounted) {
          AppToast.showError(context, t.templates.list.duplicateError);
        }
      }
    case _SessionAction.delete:
      final ok = await AppDialog.confirm(
        context,
        title: t.templates.programs.deleteSessionTitle(name: template.name),
        message: t.templates.programs.deleteSessionMessage,
        confirmLabel: t.common.actions.delete,
        destructive: true,
      );
      if (ok != true) return;
      try {
        await templates.delete(template.id);
        if (context.mounted) {
          AppToast.showSuccess(context, t.templates.list.deleted);
        }
      } on Object {
        if (context.mounted) {
          AppToast.showError(context, t.templates.list.deleteError);
        }
      }
  }
}
