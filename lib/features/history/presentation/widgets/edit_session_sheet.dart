import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';
import 'package:repster/shared/widgets/app_text_field.dart';
import 'package:repster/shared/widgets/numeric_input.dart';

/// Editable metadata of a completed session. Mirrors the PWA's edit form: the
/// performed sets stay immutable, only these four fields can be corrected.
class SessionDetailsEdit {
  const SessionDetailsEdit({
    required this.templateName,
    required this.startedAt,
    required this.durationSeconds,
    required this.notes,
  });

  final String templateName;
  final DateTime startedAt;
  final int durationSeconds;
  final String notes;
}

/// Opens the "edit session" sheet. Returns the new values, or `null` if
/// dismissed. Persisting them is the caller's job.
Future<SessionDetailsEdit?> showEditSessionSheet(
  BuildContext context, {
  required WorkoutSession session,
}) {
  return showGlassSheet<SessionDetailsEdit>(
    context,
    builder: (_) => _EditSheet(session: session),
  );
}

class _EditSheet extends StatefulWidget {
  const _EditSheet({required this.session});

  final WorkoutSession session;

  @override
  State<_EditSheet> createState() => _EditSheetState();
}

class _EditSheetState extends State<_EditSheet> {
  late final TextEditingController _name;
  late final TextEditingController _notes;
  late DateTime _date;
  late int _timeH;
  late int _timeMin;
  late int _durationH;
  late int _durationMin;
  String? _nameError;

  @override
  void initState() {
    super.initState();
    final s = widget.session;
    _name = TextEditingController(text: s.templateName);
    _notes = TextEditingController(text: s.notes);
    _date = DateTime(s.startedAt.year, s.startedAt.month, s.startedAt.day);
    _timeH = s.startedAt.hour;
    _timeMin = s.startedAt.minute;
    _durationH = s.duration ~/ 3600;
    _durationMin = (s.duration % 3600) ~/ 60;
  }

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      // A session cannot have happened in the future.
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = t.history.detail.edit.nameRequired);
      return;
    }
    Navigator.of(context).pop(
      SessionDetailsEdit(
        templateName: name,
        startedAt: DateTime(
          _date.year,
          _date.month,
          _date.day,
          _timeH,
          _timeMin,
        ),
        durationSeconds: _durationH * 3600 + _durationMin * 60,
        notes: _notes.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final edit = t.history.detail.edit;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SheetHandle(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  edit.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: onSurface,
                  ),
                ),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      controller: _name,
                      label: edit.name,
                      hint: edit.namePlaceholder,
                      errorText: _nameError,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) {
                        if (_nameError != null) {
                          setState(() => _nameError = null);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    _FieldLabel(edit.date),
                    const SizedBox(height: 6),
                    _DateButton(
                      label: DateFormat(
                        t.history.detail.edit.dateFormat,
                      ).format(_date),
                      onTap: _pickDate,
                    ),
                    const SizedBox(height: 16),
                    _FieldLabel(edit.time),
                    const SizedBox(height: 6),
                    _UnitPair(
                      firstValue: _timeH,
                      firstMax: 23,
                      firstSuffix: edit.hours,
                      secondValue: _timeMin,
                      secondMax: 59,
                      secondSuffix: edit.minutes,
                      onFirst: (v) => setState(() => _timeH = v),
                      onSecond: (v) => setState(() => _timeMin = v),
                    ),
                    const SizedBox(height: 16),
                    _FieldLabel(edit.durationLabel),
                    const SizedBox(height: 6),
                    _UnitPair(
                      firstValue: _durationH,
                      firstMax: 23,
                      firstSuffix: edit.hours,
                      secondValue: _durationMin,
                      secondMax: 59,
                      secondSuffix: edit.minutes,
                      onFirst: (v) => setState(() => _durationH = v),
                      onSecond: (v) => setState(() => _durationMin = v),
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _notes,
                      label: t.history.detail.notes,
                      hint: edit.notesPlaceholder,
                      minLines: 3,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: AppButton(
                label: edit.save,
                icon: LucideIcons.check,
                expand: true,
                onPressed: _submit,
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
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
      ),
    );
  }
}

class _DateButton extends StatelessWidget {
  const _DateButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: onSurface.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(AppRadius.control),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.control),
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: Row(
            children: [
              Icon(
                LucideIcons.calendar,
                size: 16,
                color: onSurface.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: onSurface,
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

/// Two numeric fields side by side (hours + minutes), each with its unit.
///
/// Fixed widths, not stretched: [NumericInput] wraps its field in a sized box
/// inside a `mainAxisSize: min` Row when a suffix is set, so an unbounded width
/// fails to lay out.
class _UnitPair extends StatelessWidget {
  const _UnitPair({
    required this.firstValue,
    required this.firstMax,
    required this.firstSuffix,
    required this.secondValue,
    required this.secondMax,
    required this.secondSuffix,
    required this.onFirst,
    required this.onSecond,
  });

  final int firstValue;
  final int firstMax;
  final String firstSuffix;
  final int secondValue;
  final int secondMax;
  final String secondSuffix;
  final ValueChanged<int> onFirst;
  final ValueChanged<int> onSecond;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NumericInput(
          value: firstValue,
          max: firstMax,
          suffix: firstSuffix,
          width: 76,
          height: 48,
          onChanged: (v) => onFirst((v ?? 0).toInt()),
        ),
        const SizedBox(width: 16),
        NumericInput(
          value: secondValue,
          max: secondMax,
          suffix: secondSuffix,
          width: 76,
          height: 48,
          onChanged: (v) => onSecond((v ?? 0).toInt()),
        ),
      ],
    );
  }
}
