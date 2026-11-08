import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/pressable.dart';

/// Small uppercase field label (session drawers).
class FormFieldLabel extends StatelessWidget {
  const FormFieldLabel(this.text, {super.key});

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

/// Shared decoration for drawer input fields.
InputDecoration _fieldDecoration(BuildContext context, {String? suffix}) {
  final onSurface = Theme.of(context).colorScheme.onSurface;
  return InputDecoration(
    isDense: true,
    filled: true,
    fillColor: onSurface.withValues(alpha: 0.05),
    suffixText: suffix,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
      ),
    ),
  );
}

/// Integer number field (rest, sets, reps, duration).
class NumberField extends StatelessWidget {
  const NumberField({required this.controller, this.suffix, super.key});

  final TextEditingController controller;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      decoration: _fieldDecoration(context, suffix: suffix),
    );
  }
}

/// Tempo field (formats `3120` -> `3-1-2-0`).
class TempoField extends StatelessWidget {
  const TempoField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      // Text (not number) keyboard to allow typing "X"; the formatter keeps
      // only digits and X.
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.characters,
      onChanged: (v) {
        final formatted = formatTempoInput(v);
        if (formatted != v) {
          controller.value = TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length),
          );
        }
      },
      style: const TextStyle(fontSize: 16, letterSpacing: 2),
      decoration: _fieldDecoration(context).copyWith(hintText: '3-1-X-0'),
    );
  }
}

/// Multiline notes field.
class NotesField extends StatelessWidget {
  const NotesField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 2,
      maxLines: 3,
      decoration: _fieldDecoration(
        context,
      ).copyWith(hintText: t.session.fields.notesHint),
    );
  }
}

/// "Also save to the template" check row of the session drawers. Off by
/// default: a change made mid-session is for today unless said otherwise.
class KeepInTemplateRow extends StatelessWidget {
  const KeepInTemplateRow({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final accent = scheme.glow;
    return Pressable(
      scale: 1,
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: value
              ? accent.withValues(alpha: 0.08)
              : onSurface.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: value
                ? accent.withValues(alpha: 0.35)
                : onSurface.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: value ? accent : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.controlSm),
                border: Border.all(
                  color: value ? accent : onSurface.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: value
                  ? const Icon(LucideIcons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.session.fields.keepInTemplate,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: onSurface.withValues(alpha: value ? 0.95 : 0.8),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    t.session.fields.keepInTemplateHint,
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
    );
  }
}
