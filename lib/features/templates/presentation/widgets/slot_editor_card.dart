import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/exercises/domain/catalog_exercise.dart';
import 'package:repster/features/session/presentation/widgets/exercise_name_field.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';

/// Collapsible editor card for a program exercise (slot). Header: number,
/// name + summary, variant badge, superset, move up/down, delete. Body
/// (expanded): variant tabs, name, type (reps/time), sets/reps-duration/tempo/
/// rest, notes.
class SlotEditorCard extends StatefulWidget {
  const SlotEditorCard({
    required this.slot,
    required this.position,
    required this.isFirst,
    required this.isLast,
    required this.search,
    required this.onUpdateVariant,
    required this.onAddVariant,
    required this.onRemoveVariant,
    required this.onToggleSuperset,
    required this.onRemoveSlot,
    required this.onMoveUp,
    required this.onMoveDown,
    this.canRemove = true,
    super.key,
  });

  final TemplateSlot slot;
  final int position;
  final bool isFirst;
  final bool isLast;
  final bool canRemove;

  /// Catalog search (certified + own exercises), localized to the app language.
  final Future<List<CatalogExercise>> Function(String query) search;
  final void Function(
    int variantIndex,
    TemplateExercise Function(TemplateExercise) update,
  )
  onUpdateVariant;
  final VoidCallback onAddVariant;
  final void Function(int variantIndex) onRemoveVariant;
  final VoidCallback onToggleSuperset;
  final VoidCallback onRemoveSlot;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  State<SlotEditorCard> createState() => _SlotEditorCardState();
}

class _SlotEditorCardState extends State<SlotEditorCard> {
  late bool _expanded;
  int _activeIndex = 0;
  late final TextEditingController _nameCtl;
  late final TextEditingController _notesCtl;
  late final TextEditingController _tempoCtl;
  final FocusNode _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Expand by default an exercise that still has no name (newly added).
    _expanded = widget.slot.variants.first.name.trim().isEmpty;
    final ex = widget.slot.variants[_activeIndex];
    _nameCtl = TextEditingController(text: ex.name);
    _notesCtl = TextEditingController(text: ex.notes);
    _tempoCtl = TextEditingController(text: ex.tempo);
  }

  @override
  void didUpdateWidget(SlotEditorCard old) {
    super.didUpdateWidget(old);
    if (_activeIndex >= widget.slot.variants.length) {
      _activeIndex = widget.slot.variants.length - 1;
    }
    final ex = widget.slot.variants[_activeIndex];
    if (_nameCtl.text != ex.name) _nameCtl.text = ex.name;
    if (_notesCtl.text != ex.notes) _notesCtl.text = ex.notes;
    if (_tempoCtl.text != ex.tempo) _tempoCtl.text = ex.tempo;
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _notesCtl.dispose();
    _tempoCtl.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  TemplateExercise get _ex => widget.slot.variants[_activeIndex];

  void _update(TemplateExercise Function(TemplateExercise) f) =>
      widget.onUpdateVariant(_activeIndex, f);

  void _switchVariant(int i) {
    setState(() {
      _activeIndex = i;
      final ex = widget.slot.variants[i];
      _nameCtl.text = ex.name;
      _notesCtl.text = ex.notes;
      _tempoCtl.text = ex.tempo;
    });
  }

  String _summary(TemplateExercise ex) {
    final main = ex.isTimeBased
        ? '${ex.sets}×${formatHoldDuration(ex.durationSeconds ?? 30)}'
        : '${ex.sets}×${ex.reps}';
    return '$main · ${ex.restTime}s';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: scheme.translucentCard,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        // Material inside the clip so the header InkWell ink is clipped to the
        // rounded corners rather than bleeding onto the ancestor Material.
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _header(context),
              if (_expanded) ...[
                Divider(height: 1, color: scheme.hairline),
                _body(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final primary = widget.slot.variants.first;
    final variantCount = widget.slot.variants.length;
    return InkWell(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
        child: Row(
          children: [
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: onSurface.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Text(
                '${widget.position}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      if (primary.isTimeBased) ...[
                        const Icon(
                          LucideIcons.timer,
                          size: 12,
                          color: AppColors.accentAmber,
                        ),
                        const SizedBox(width: 5),
                      ],
                      Flexible(
                        child: Text(
                          primary.name.trim().isEmpty
                              ? t.templates.slot.newExercise
                              : primary.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: primary.name.trim().isEmpty
                                ? onSurface.withValues(alpha: 0.5)
                                : onSurface,
                          ),
                        ),
                      ),
                      if (variantCount > 1) ...[
                        const SizedBox(width: 6),
                        _VariantBadge(count: variantCount),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _summary(primary),
                    style: TextStyle(
                      fontSize: 12,
                      color: onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            _HeaderIconBtn(
              icon: LucideIcons.link2,
              tint: widget.slot.supersetWithNext && !widget.isLast
                  ? scheme.primary
                  : null,
              active: widget.slot.supersetWithNext && !widget.isLast,
              onTap: widget.isLast ? null : widget.onToggleSuperset,
            ),
            _HeaderIconBtn(
              icon: LucideIcons.chevronUp,
              onTap: widget.isFirst ? null : widget.onMoveUp,
            ),
            _HeaderIconBtn(
              icon: LucideIcons.chevronDown,
              onTap: widget.isLast ? null : widget.onMoveDown,
            ),
            _HeaderIconBtn(
              icon: LucideIcons.trash2,
              tint: scheme.error,
              onTap: widget.canRemove ? widget.onRemoveSlot : null,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Icon(
                _expanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                size: 16,
                color: onSurface.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final variants = widget.slot.variants;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (variants.length > 1) ...[
            _VariantTabs(
              variants: variants,
              activeIndex: _activeIndex,
              onSelect: _switchVariant,
              onAdd: widget.onAddVariant,
              onRemove: variants.length > 1
                  ? () => widget.onRemoveVariant(_activeIndex)
                  : null,
            ),
            const SizedBox(height: 12),
          ],
          _FieldLabel(t.templates.fields.exerciseName),
          const SizedBox(height: 6),
          ExerciseNameField(
            controller: _nameCtl,
            focusNode: _nameFocus,
            collapseWhenUnfocused: true,
            minQueryChars: 2,
            search: widget.search,
            addLabel: t.session.swap.useLabel,
            // Guard against the controller listener firing on programmatic
            // text writes (variant switch / didUpdateWidget), which would push
            // a redundant provider update mid-build.
            onChanged: (v) {
              if (v == _ex.name) return;
              _update((ex) => ex.copyWith(name: v));
            },
            onSelected: (e) {
              _nameCtl.text = e.displayName;
              _nameFocus.unfocus();
            },
            onSubmit: _nameFocus.unfocus,
          ),
          const SizedBox(height: 14),
          _FieldLabel(t.templates.fields.type),
          const SizedBox(height: 6),
          _TypeToggle(
            isTimeBased: _ex.isTimeBased,
            onChanged: (time) => _update(
              (ex) => ex.copyWith(
                isTimeBased: time,
                durationSeconds: time && ex.durationSeconds == null
                    ? 30
                    : ex.durationSeconds,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _NumField(
                  label: t.templates.fields.sets,
                  value: _ex.sets,
                  min: 1,
                  max: 20,
                  onChanged: (v) => _update((ex) => ex.copyWith(sets: v)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ex.isTimeBased
                    ? _NumField(
                        label: t.templates.fields.duration,
                        value: _ex.durationSeconds ?? 30,
                        min: 1,
                        max: 3600,
                        onChanged: (v) =>
                            _update((ex) => ex.copyWith(durationSeconds: v)),
                      )
                    : _NumField(
                        label: t.templates.fields.targetReps,
                        value: _ex.reps,
                        min: 1,
                        max: 100,
                        onChanged: (v) => _update((ex) => ex.copyWith(reps: v)),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _NumField(
                  label: t.templates.fields.rest,
                  value: _ex.restTime,
                  min: 0,
                  max: 3600,
                  onChanged: (v) => _update((ex) => ex.copyWith(restTime: v)),
                ),
              ),
              if (!_ex.isTimeBased) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _FieldLabel(t.templates.fields.tempo),
                      const SizedBox(height: 6),
                      _PlainField(
                        controller: _tempoCtl,
                        hint: t.templates.fields.tempoHint,
                        keyboardType: TextInputType.text,
                        onChanged: (v) {
                          final f = formatTempoInput(v);
                          if (f != v) {
                            _tempoCtl.value = TextEditingValue(
                              text: f,
                              selection: TextSelection.collapsed(
                                offset: f.length,
                              ),
                            );
                          }
                          _update((ex) => ex.copyWith(tempo: f));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          _FieldLabel(t.templates.fields.notes),
          const SizedBox(height: 6),
          _PlainField(
            controller: _notesCtl,
            hint: t.templates.fields.notesHint,
            maxLines: 2,
            onChanged: (v) => _update((ex) => ex.copyWith(notes: v)),
          ),
          if (variants.length == 1) ...[
            const SizedBox(height: 12),
            _AddVariantButton(onTap: widget.onAddVariant),
          ],
          if (!widget.isLast && widget.slot.supersetWithNext) ...[
            const SizedBox(height: 12),
            _SupersetNote(color: scheme.primary),
          ],
        ],
      ),
    );
  }
}

// ─── Sub-components ──────────────────────────────────────────────────────────

class _HeaderIconBtn extends StatelessWidget {
  const _HeaderIconBtn({
    required this.icon,
    required this.onTap,
    this.tint,
    this.active = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color? tint;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final disabled = onTap == null;
    final color = tint ?? onSurface.withValues(alpha: 0.55);
    return Opacity(
      opacity: disabled ? 0.25 : 1,
      child: Material(
        color: active
            ? (tint ?? onSurface).withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: onTap,
          child: SizedBox(
            width: 30,
            height: 30,
            child: Icon(icon, size: 16, color: color),
          ),
        ),
      ),
    );
  }
}

class _VariantBadge extends StatelessWidget {
  const _VariantBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.shuffle, size: 10, color: primary),
          const SizedBox(width: 3),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _VariantTabs extends StatelessWidget {
  const _VariantTabs({
    required this.variants,
    required this.activeIndex,
    required this.onSelect,
    required this.onAdd,
    required this.onRemove,
  });

  final List<TemplateExercise> variants;
  final int activeIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onAdd;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < variants.length; i++) ...[
                  if (i > 0) const SizedBox(width: 6),
                  _VariantTab(
                    label: variants[i].name.trim().isEmpty
                        ? t.templates.slot.variantN(n: i + 1)
                        : variants[i].name,
                    isPrimary: i == 0,
                    isTimeBased: variants[i].isTimeBased,
                    active: i == activeIndex,
                    onTap: () => onSelect(i),
                  ),
                ],
                const SizedBox(width: 6),
                _AddVariantChip(onTap: onAdd),
              ],
            ),
          ),
        ),
        if (onRemove != null)
          _HeaderIconBtn(
            icon: LucideIcons.trash2,
            tint: scheme.error,
            onTap: onRemove,
          ),
      ],
    );
  }
}

class _VariantTab extends StatelessWidget {
  const _VariantTab({
    required this.label,
    required this.isPrimary,
    required this.isTimeBased,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool isPrimary;
  final bool isTimeBased;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Material(
      color: active
          ? scheme.primary.withValues(alpha: 0.15)
          : onSurface.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: active
                  ? scheme.primary.withValues(alpha: 0.30)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isPrimary)
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    t.templates.slot.primary,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: (active ? scheme.primary : onSurface).withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ),
              if (isTimeBased) ...[
                const Icon(
                  LucideIcons.timer,
                  size: 11,
                  color: AppColors.accentAmber,
                ),
                const SizedBox(width: 4),
              ],
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: active
                        ? scheme.primary
                        : onSurface.withValues(alpha: 0.6),
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

class _AddVariantChip extends StatelessWidget {
  const _AddVariantChip({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIcons.plus, size: 13, color: primary),
              const SizedBox(width: 4),
              Text(
                t.templates.slot.variant,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddVariantButton extends StatelessWidget {
  const _AddVariantButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Container(
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: primary.withValues(alpha: 0.30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LucideIcons.shuffle, size: 14, color: primary),
              const SizedBox(width: 8),
              Text(
                t.templates.slot.addVariant,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupersetNote extends StatelessWidget {
  const _SupersetNote({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(LucideIcons.link2, size: 12, color: color),
        const SizedBox(width: 6),
        Text(
          t.templates.slot.supersetNote,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: color.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }
}

class _TypeToggle extends StatelessWidget {
  const _TypeToggle({required this.isTimeBased, required this.onChanged});

  final bool isTimeBased;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TypeOption(
              icon: LucideIcons.hash,
              label: t.templates.slot.reps,
              selected: !isTimeBased,
              onTap: () => onChanged(false),
            ),
          ),
          Expanded(
            child: _TypeOption(
              icon: LucideIcons.timer,
              label: t.templates.slot.time,
              selected: isTimeBased,
              accent: AppColors.accentAmber,
              onTap: () => onChanged(true),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeOption extends StatelessWidget {
  const _TypeOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.accent,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final fg = selected
        ? (accent ?? onSurface)
        : onSurface.withValues(alpha: 0.5);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? scheme.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: onSurface.withValues(alpha: 0.55),
      ),
    );
  }
}

class _PlainField extends StatelessWidget {
  const _PlainField({
    required this.controller,
    required this.onChanged,
    this.hint,
    this.maxLines = 1,
    this.keyboardType,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? hint;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: keyboardType,
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

/// Numeric field with a built-in −/+ stepper.
class _NumField extends StatelessWidget {
  const _NumField({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  void _set(int v) => onChanged(v.clamp(min, max));

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FieldLabel(label),
        const SizedBox(height: 6),
        Container(
          height: 46,
          decoration: BoxDecoration(
            color: onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: Row(
            children: [
              _StepBtn(
                icon: LucideIcons.minus,
                onTap: value > min ? () => _set(value - 1) : null,
              ),
              Expanded(
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: onSurface,
                  ),
                ),
              ),
              _StepBtn(
                icon: LucideIcons.plus,
                onTap: value < max ? () => _set(value + 1) : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepBtn extends StatelessWidget {
  const _StepBtn({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Opacity(
      opacity: onTap == null ? 0.3 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Icon(icon, size: 16, color: onSurface.withValues(alpha: 0.7)),
        ),
      ),
    );
  }
}
