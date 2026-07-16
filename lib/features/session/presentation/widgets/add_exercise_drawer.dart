import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/exercises/domain/catalog_exercise.dart';
import 'package:repster/features/session/presentation/widgets/exercise_name_field.dart';
import 'package:repster/features/session/presentation/widgets/session_form_fields.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';

/// Data returned by the add-exercise drawer.
class AddExerciseData {
  const AddExerciseData({
    required this.name,
    required this.isTimeBased,
    required this.setsCount,
    required this.targetReps,
    required this.targetSeconds,
    required this.restTime,
    required this.tempo,
    required this.notes,
  });

  final String name;
  final bool isTimeBased;
  final int setsCount;
  final int targetReps;
  final int targetSeconds;
  final int restTime;
  final String tempo;
  final String notes;
}

/// "Add an exercise" drawer (for this session only).
Future<AddExerciseData?> showAddExerciseDrawer(
  BuildContext context, {
  required Future<List<CatalogExercise>> Function(String query) search,
}) {
  return AppDrawerSheet.show<AddExerciseData>(
    context,
    title: t.session.add.title,
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
    child: _AddSheet(search: search),
  );
}

class _AddSheet extends StatefulWidget {
  const _AddSheet({required this.search});

  final Future<List<CatalogExercise>> Function(String query) search;

  @override
  State<_AddSheet> createState() => _AddSheetState();
}

class _AddSheetState extends State<_AddSheet> {
  final _name = TextEditingController();
  final _sets = TextEditingController(text: '3');
  final _reps = TextEditingController(text: '10');
  final _seconds = TextEditingController(text: '30');
  final _rest = TextEditingController(text: '90');
  final _tempo = TextEditingController(text: '2-0-2-0');
  final _notes = TextEditingController();
  bool _isTimeBased = false;

  @override
  void dispose() {
    _name.dispose();
    _sets.dispose();
    _reps.dispose();
    _seconds.dispose();
    _rest.dispose();
    _tempo.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _onSelected(CatalogExercise e) {
    setState(() => _name.text = e.displayName);
  }

  int _int(TextEditingController c, int fallback) =>
      int.tryParse(c.text.trim()) ?? fallback;

  void _add() {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context).pop(
      AddExerciseData(
        name: name,
        isTimeBased: _isTimeBased,
        setsCount: _int(_sets, 3).clamp(1, 10),
        targetReps: _int(_reps, 10).clamp(1, 50),
        targetSeconds: _int(_seconds, 30) < 1 ? 30 : _int(_seconds, 30),
        restTime: _int(_rest, 90),
        tempo: _tempo.text.trim(),
        notes: _notes.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.session.add.subtitle,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.accentAmber.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 16),
          FormFieldLabel(t.session.fields.exerciseName),
          const SizedBox(height: 6),
          ExerciseNameField(
            controller: _name,
            search: widget.search,
            addLabel: t.session.add.addLabel,
            autofocus: true,
            onSelected: _onSelected,
            onSubmit: _add,
          ),
          const SizedBox(height: 14),
          FormFieldLabel(t.session.fields.type),
          const SizedBox(height: 6),
          _TypeToggle(
            isTimeBased: _isTimeBased,
            onChanged: (v) => setState(() {
              _isTimeBased = v;
              if (v) {
                _tempo.text = '0-0-0-0';
              } else if (_tempo.text == '0-0-0-0') {
                _tempo.text = '2-0-2-0';
              }
            }),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormFieldLabel(t.session.fields.sets),
                    const SizedBox(height: 6),
                    NumberField(controller: _sets),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormFieldLabel(
                      _isTimeBased
                          ? t.session.fields.durationSec
                          : t.session.fields.targetReps,
                    ),
                    const SizedBox(height: 6),
                    NumberField(
                      controller: _isTimeBased ? _seconds : _reps,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormFieldLabel(t.session.fields.restShort),
                    const SizedBox(height: 6),
                    NumberField(controller: _rest, suffix: 'sec'),
                  ],
                ),
              ),
              if (!_isTimeBased) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FormFieldLabel(t.session.fields.tempo),
                      const SizedBox(height: 6),
                      TempoField(controller: _tempo),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          FormFieldLabel(t.session.fields.notesOptional),
          const SizedBox(height: 6),
          NotesField(controller: _notes),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _add,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.plus, size: 16),
                const SizedBox(width: 8),
                Text(
                  t.session.add.addToSession,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
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
            child: _ToggleOption(
              icon: LucideIcons.hash,
              label: t.session.add.reps,
              selected: !isTimeBased,
              onTap: () => onChanged(false),
            ),
          ),
          Expanded(
            child: _ToggleOption(
              icon: LucideIcons.timer,
              label: t.session.add.time,
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

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
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
        height: 38,
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
