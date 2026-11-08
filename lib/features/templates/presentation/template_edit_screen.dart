import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/exercises/application/exercises_search.dart';
import 'package:repster/features/exercises/domain/catalog_exercise.dart';
import 'package:repster/features/templates/application/template_editor_controller.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/presentation/widgets/muscle_group_picker.dart';
import 'package:repster/features/templates/presentation/widgets/slot_editor_card.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_loading.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/form_error_box.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';

class TemplateEditScreen extends ConsumerStatefulWidget {
  const TemplateEditScreen({this.templateId, super.key});

  /// `null` = new template, otherwise editing an existing one.
  final String? templateId;

  @override
  ConsumerState<TemplateEditScreen> createState() => _TemplateEditScreenState();
}

class _TemplateEditScreenState extends ConsumerState<TemplateEditScreen> {
  late final TextEditingController _nameCtl;
  late final TextEditingController _descCtl;
  bool _saving = false;
  bool _hydrated = false;
  String? _globalError;

  bool get _isEdit => widget.templateId != null;

  /// Catalog search (certified Repster exercises + the user's own), localized
  /// to the current app language. Feeds each slot's name autocomplete.
  Future<List<CatalogExercise>> _search(String query) =>
      ref.read(exercisesSearchProvider).search(query);

  @override
  void initState() {
    super.initState();
    _nameCtl = TextEditingController();
    _descCtl = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.templateId == null) {
        ref.read(templateEditorControllerProvider.notifier).addSlot();
        _hydrated = true;
      }
    });
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _descCtl.dispose();
    super.dispose();
  }

  void _hydrate(Template t) {
    if (_hydrated) return;
    ref.read(templateEditorControllerProvider.notifier).hydrate(t);
    _nameCtl.text = t.name;
    _descCtl.text = t.description;
    _hydrated = true;
  }

  Future<void> _save() async {
    final ed = ref.read(templateEditorControllerProvider);
    if (!ed.isValid) {
      setState(() => _globalError = t.templates.editor.validationError);
      return;
    }
    setState(() {
      _saving = true;
      _globalError = null;
    });
    try {
      final ctl = ref.read(templatesControllerProvider.notifier);
      if (widget.templateId == null) {
        final id = await ctl.create(
          name: ed.name,
          description: ed.description,
          tags: ed.tags,
          slots: ed.slots,
        );
        if (!mounted) return;
        context.pushReplacement('/templates/$id');
      } else {
        await ctl.save(
          id: widget.templateId!,
          name: ed.name,
          description: ed.description,
          tags: ed.tags,
          slots: ed.slots,
        );
        if (!mounted) return;
        context.pop();
      }
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _globalError = humanizeAppError(e));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_isEdit) {
      body = AsyncValueWidget<Template>(
        value: ref.watch(templateByIdProvider(widget.templateId!)),
        onRetry: () => ref.invalidate(templatesControllerProvider),
        data: (t) {
          if (!_hydrated) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _hydrate(t));
          }
          return _buildForm();
        },
      );
    } else {
      body = _buildForm();
    }

    return GlowScaffold(
      child: Column(
        children: [
          _NavBar(
            title: _isEdit
                ? t.templates.editor.editTitle
                : t.templates.editor.newTitle,
            saving: _saving,
            onBack: () => context.pop(),
            onSave: _saving ? null : _save,
          ),
          Expanded(child: body),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Consumer(
      builder: (context, ref, _) {
        final editor = ref.watch(templateEditorControllerProvider);
        final ctl = ref.read(templateEditorControllerProvider.notifier);
        final slots = editor.slots;
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            if (_globalError != null) ...[
              FormErrorBox(message: _globalError!),
              const SizedBox(height: 12),
            ],
            _InfoCard(
              nameCtl: _nameCtl,
              descCtl: _descCtl,
              editor: editor,
              onName: (v) {
                ctl.setName(v);
                if (_globalError != null) setState(() => _globalError = null);
              },
              onDescription: ctl.setDescription,
              onToggleTag: ctl.toggleTag,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 12),
              child: Text(
                t.templates.editor.exercisesHeader(count: slots.length),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
            for (var i = 0; i < slots.length; i++) ...[
              SlotEditorCard(
                key: ValueKey(slots[i].slotId),
                slot: slots[i],
                position: i + 1,
                isFirst: i == 0,
                isLast: i == slots.length - 1,
                canRemove: slots.length > 1,
                search: _search,
                onUpdateVariant: (vi, update) =>
                    ctl.updateVariant(i, vi, update),
                onAddVariant: () => ctl.addVariant(i),
                onRemoveVariant: (vi) => ctl.removeVariant(i, vi),
                onToggleSuperset: () => ctl.toggleSupersetWithNext(i),
                onRemoveSlot: () => ctl.removeSlot(i),
                onMoveUp: () => ctl.reorderSlots(i, i - 1),
                onMoveDown: () => ctl.reorderSlots(i, i + 2),
              ),
              if (i < slots.length - 1)
                _SlotConnector(superset: slots[i].supersetWithNext)
              else
                const SizedBox(height: 12),
            ],
            _AddExerciseButton(onTap: ctl.addSlot),
            const SizedBox(height: 20),
            _SaveButton(saving: _saving, onTap: _saving ? null : _save),
          ],
        );
      },
    );
  }
}

// ─── Nav bar ─────────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  const _NavBar({
    required this.title,
    required this.saving,
    required this.onBack,
    required this.onSave,
  });

  final String title;
  final bool saving;
  final VoidCallback onBack;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Row(
        children: [
          _NavIcon(icon: LucideIcons.chevronLeft, onTap: onBack),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
                color: onSurface,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: onSave,
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                child: saving
                    ? const AppSpinner(size: 16, color: Colors.white)
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.check,
                            size: 15,
                            color: scheme.onPrimary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            t.common.actions.save,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: scheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: onSurface.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, size: 18, color: onSurface.withValues(alpha: 0.7)),
        ),
      ),
    );
  }
}

// ─── Info card (name / description / groups) ─────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.nameCtl,
    required this.descCtl,
    required this.editor,
    required this.onName,
    required this.onDescription,
    required this.onToggleTag,
  });

  final TextEditingController nameCtl;
  final TextEditingController descCtl;
  final TemplateEditorState editor;
  final ValueChanged<String> onName;
  final ValueChanged<String> onDescription;
  final ValueChanged<MuscleGroup> onToggleTag;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: scheme.translucentCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FieldLabel(t.templates.fields.name),
          const SizedBox(height: 6),
          _Field(
            controller: nameCtl,
            hint: t.templates.fields.nameHint,
            onChanged: onName,
          ),
          const SizedBox(height: 14),
          _FieldLabel(t.templates.fields.description),
          const SizedBox(height: 6),
          _Field(
            controller: descCtl,
            hint: t.templates.fields.descriptionHint,
            maxLines: 2,
            onChanged: onDescription,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _FieldLabel(t.templates.fields.muscleGroups),
              const Spacer(),
              if (editor.tags.isNotEmpty)
                Text(
                  t.templates.fields.selectedCount(n: editor.tags.length),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: scheme.primary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          MuscleGroupPicker(
            selected: editor.tags.toSet(),
            onToggle: onToggleTag,
          ),
        ],
      ),
    );
  }
}

// ─── Slot connector ──────────────────────────────────────────────────────────

class _SlotConnector extends StatelessWidget {
  const _SlotConnector({required this.superset});

  final bool superset;

  @override
  Widget build(BuildContext context) {
    if (!superset) return const SizedBox(height: 12);
    final primary = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 1,
            color: primary.withValues(alpha: 0.4),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: primary.withValues(alpha: 0.25)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.link2, size: 10, color: primary),
                const SizedBox(width: 4),
                Text(
                  t.templates.slot.supersetLabel,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 10,
            height: 1,
            color: primary.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}

class _AddExerciseButton extends StatelessWidget {
  const _AddExerciseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: onSurface.withValues(alpha: 0.15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.plus,
                size: 16,
                color: onSurface.withValues(alpha: 0.65),
              ),
              const SizedBox(width: 8),
              Text(
                t.templates.editor.addExercise,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: onSurface.withValues(alpha: 0.65),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.saving, required this.onTap});

  final bool saving;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.primary,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Container(
          height: 52,
          alignment: Alignment.center,
          child: saving
              ? const AppSpinner(size: 20, color: Colors.white, stroke: 2.5)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.check, size: 18, color: scheme.onPrimary),
                    const SizedBox(width: 8),
                    Text(
                      t.templates.editor.save,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: scheme.onPrimary,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          color: onSurface.withValues(alpha: 0.55),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.onChanged,
    this.hint,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      style: TextStyle(fontSize: 15, color: onSurface),
      cursorColor: scheme.primary,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: onSurface.withValues(alpha: 0.05),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 15,
          color: onSurface.withValues(alpha: 0.4),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide(color: onSurface.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide(color: onSurface.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide(color: scheme.primary.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}
