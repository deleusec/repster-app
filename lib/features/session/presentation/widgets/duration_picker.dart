import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';

const _presets = [15, 30, 45, 60, 90, 120];
const _quickSteps = [(-30, '−30s'), (-5, '−5s'), (5, '+5s'), (30, '+30s')];

/// Per-set duration picker (time-based exercise). Presets, quick adjustments
/// and manual entry (`45` or `1m30`). Returns the confirmed seconds or `null`.
Future<int?> showDurationPicker(BuildContext context, {required int value}) {
  return showGlassSheet<int>(
    context,
    builder: (_) => _DurationSheet(initial: value),
  );
}

class _DurationSheet extends StatefulWidget {
  const _DurationSheet({required this.initial});

  final int initial;

  @override
  State<_DurationSheet> createState() => _DurationSheetState();
}

class _DurationSheetState extends State<_DurationSheet> {
  late int _seconds;
  bool _editing = false;
  late final TextEditingController _input;

  @override
  void initState() {
    super.initState();
    _seconds = widget.initial < 1 ? 1 : widget.initial;
    _input = TextEditingController();
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _adjust(int delta) =>
      setState(() => _seconds = (_seconds + delta).clamp(1, 3600));

  void _commit() {
    final raw = _input.text.trim().toLowerCase();
    int? parsed;
    final m = RegExp(r'^(\d+)m(\d{0,2})$').firstMatch(raw);
    if (m != null) {
      final mm = m.group(2)!;
      parsed = int.parse(m.group(1)!) * 60 + int.parse(mm.isEmpty ? '0' : mm);
    } else {
      parsed = int.tryParse(raw);
    }
    setState(() {
      if (parsed != null) _seconds = parsed.clamp(1, 3600);
      _editing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    const amber = AppColors.accentAmber;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 4),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: onSurface.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  t.session.duration.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: onSurface,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 76,
              child: Center(
                child: _editing
                    ? SizedBox(
                        width: 180,
                        child: TextField(
                          controller: _input,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          onSubmitted: (_) => _commit(),
                          onTapOutside: (_) => _commit(),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -2,
                            height: 1,
                            color: amber,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: t.session.duration.hint,
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: amber, width: 2),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: amber, width: 2),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _input.text = formatHoldDuration(_seconds);
                          setState(() => _editing = true);
                        },
                        child: Text(
                          formatHoldDuration(_seconds),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -2,
                            height: 1,
                            color: amber,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final p in _presets)
                  _PresetChip(
                    label: formatHoldDuration(p),
                    selected: _seconds == p,
                    onTap: () => setState(() => _seconds = p),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  for (final step in _quickSteps) ...[
                    Expanded(
                      child: _StepButton(
                        label: step.$2,
                        onTap: () => _adjust(step.$1),
                      ),
                    ),
                    if (step != _quickSteps.last) const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(_seconds),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                  ),
                  child: Text(
                    t.session.duration.confirm(
                      value: formatHoldDuration(_seconds),
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    const amber = AppColors.accentAmber;
    return Material(
      color: selected
          ? amber.withValues(alpha: 0.15)
          : onSurface.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? amber : onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: onSurface.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: onSurface.withValues(alpha: 0.85),
            ),
          ),
        ),
      ),
    );
  }
}
