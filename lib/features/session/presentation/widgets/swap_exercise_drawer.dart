import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/exercises/domain/catalog_exercise.dart';
import 'package:repster/features/session/presentation/widgets/exercise_name_field.dart';
import 'package:repster/features/session/presentation/widgets/session_form_fields.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';

/// Data returned by the swap drawer.
class SwapExerciseData {
  const SwapExerciseData({
    required this.name,
    required this.restTime,
    required this.notes,
    required this.tempo,
    this.exerciseId,
  });

  final String name;
  final int restTime;
  final String notes;
  final String tempo;

  /// Catalog identity of the picked exercise, `null` when the name was typed
  /// by hand. Drives the history lookup.
  final String? exerciseId;
}

/// "Edit exercise" drawer (swap for this session only).
Future<SwapExerciseData?> showSwapDrawer(
  BuildContext context, {
  required String currentName,
  required int currentRestTime,
  required String currentNotes,
  required String currentTempo,
  required Future<List<CatalogExercise>> Function(String query) search,
  String? currentExerciseId,
}) {
  return AppDrawerSheet.show<SwapExerciseData>(
    context,
    title: t.session.swap.title,
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
    child: _SwapSheet(
      currentName: currentName,
      currentRestTime: currentRestTime,
      currentNotes: currentNotes,
      currentTempo: currentTempo,
      search: search,
      currentExerciseId: currentExerciseId,
    ),
  );
}

class _SwapSheet extends StatefulWidget {
  const _SwapSheet({
    required this.currentName,
    required this.currentRestTime,
    required this.currentNotes,
    required this.currentTempo,
    required this.search,
    this.currentExerciseId,
  });

  final String currentName;
  final int currentRestTime;
  final String currentNotes;
  final String currentTempo;
  final Future<List<CatalogExercise>> Function(String query) search;
  final String? currentExerciseId;

  @override
  State<_SwapSheet> createState() => _SwapSheetState();
}

class _SwapSheetState extends State<_SwapSheet> {
  late final TextEditingController _name;
  late final TextEditingController _rest;
  late final TextEditingController _tempo;
  late final TextEditingController _notes;

  /// Name/id of the last known catalog pick, so a hand-edited name drops the
  /// identity instead of inheriting someone else's history.
  late String _pickedName;
  late String? _pickedId;

  @override
  void initState() {
    super.initState();
    _pickedName = widget.currentName;
    _pickedId = widget.currentExerciseId;
    _name = TextEditingController(text: widget.currentName);
    _rest = TextEditingController(text: '${widget.currentRestTime}');
    _tempo = TextEditingController(text: widget.currentTempo);
    _notes = TextEditingController(text: widget.currentNotes);
  }

  @override
  void dispose() {
    _name.dispose();
    _rest.dispose();
    _tempo.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _onSelected(CatalogExercise e) {
    setState(() {
      _name.text = e.displayName;
      _pickedName = e.displayName;
      _pickedId = e.id;
    });
  }

  void _apply() {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context).pop(
      SwapExerciseData(
        name: name,
        restTime: int.tryParse(_rest.text.trim()) ?? 0,
        notes: _notes.text.trim(),
        tempo: _tempo.text.trim(),
        exerciseId: name == _pickedName ? _pickedId : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.session.swap.currently(name: widget.currentName),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: onSurface.withValues(alpha: 0.55),
            ),
          ),
          Text(
            t.session.swap.sessionOnly,
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
            addLabel: t.session.swap.useLabel,
            onSelected: _onSelected,
            onSubmit: _apply,
          ),
          const SizedBox(height: 14),
          FormFieldLabel(t.session.fields.rest),
          const SizedBox(height: 6),
          NumberField(controller: _rest, suffix: 'sec'),
          const SizedBox(height: 14),
          FormFieldLabel(t.session.fields.tempo),
          const SizedBox(height: 6),
          TempoField(controller: _tempo),
          const SizedBox(height: 14),
          FormFieldLabel(t.session.fields.notesOptional),
          const SizedBox(height: 6),
          NotesField(controller: _notes),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _apply,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.arrowLeftRight, size: 16),
                const SizedBox(width: 8),
                Text(
                  t.session.swap.apply,
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
