import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';

/// An incomplete exercise listed in the finish modal.
class IncompleteExercise {
  const IncompleteExercise({
    required this.name,
    required this.completed,
    required this.total,
  });

  final String name;
  final int completed;
  final int total;
}

/// Session finish modal: summary (sets + tonnage), warning for uncompleted
/// sets, notes and confirmation. [onConfirm] performs the save; the modal
/// shows a spinner then closes if it succeeds.
Future<void> showFinishSheet(
  BuildContext context, {
  required double tonnage,
  required int completedSets,
  required int totalSets,
  required List<IncompleteExercise> incomplete,
  required Future<bool> Function(String notes) onConfirm,
}) {
  return showGlassSheet<void>(
    context,
    builder: (_) => _FinishSheet(
      tonnage: tonnage,
      completedSets: completedSets,
      totalSets: totalSets,
      incomplete: incomplete,
      onConfirm: onConfirm,
    ),
  );
}

class _FinishSheet extends StatefulWidget {
  const _FinishSheet({
    required this.tonnage,
    required this.completedSets,
    required this.totalSets,
    required this.incomplete,
    required this.onConfirm,
  });

  final double tonnage;
  final int completedSets;
  final int totalSets;
  final List<IncompleteExercise> incomplete;
  final Future<bool> Function(String notes) onConfirm;

  @override
  State<_FinishSheet> createState() => _FinishSheetState();
}

class _FinishSheetState extends State<_FinishSheet> {
  final _notes = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    setState(() => _saving = true);
    final ok = await widget.onConfirm(_notes.text);
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop();
    } else {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final totalMissing = widget.incomplete.fold<int>(
      0,
      (sum, e) => sum + (e.total - e.completed),
    );

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
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.session.finish.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: t.session.finish.summaryReps(
                            completed: widget.completedSets,
                            total: widget.totalSets,
                          ),
                        ),
                        TextSpan(
                          text: formatTonnage(widget.tonnage),
                          style: TextStyle(
                            color: scheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: t.session.finish.summaryTonnageSuffix),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 13,
                      color: onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.incomplete.isNotEmpty) ...[
                    _IncompleteWarning(
                      totalMissing: totalMissing,
                      items: widget.incomplete,
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextField(
                    controller: _notes,
                    minLines: 3,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: t.session.finish.notesHint,
                      filled: true,
                      fillColor: onSurface.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _GhostButton(
                          label: t.session.continueLabel,
                          onTap: _saving
                              ? null
                              : () => Navigator.of(context).pop(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: _saving ? null : _confirm,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.xl),
                            ),
                          ),
                          child: _saving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(LucideIcons.flag, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      t.session.finish.confirm,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
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

class _IncompleteWarning extends StatelessWidget {
  const _IncompleteWarning({required this.totalMissing, required this.items});

  final int totalMissing;
  final List<IncompleteExercise> items;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    const amber = AppColors.accentAmber;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: amber.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: amber.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.triangleAlert, size: 14, color: amber),
              const SizedBox(width: 8),
              Text(
                t.session.finish.unvalidatedSets(n: totalMissing),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 176),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final ex in items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              ex.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: onSurface.withValues(alpha: 0.75),
                              ),
                            ),
                          ),
                          Text(
                            '${ex.completed}/${ex.total}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: amber.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.session.finish.incompleteHint,
            style: TextStyle(
              fontSize: 11,
              height: 1.3,
              color: onSurface.withValues(alpha: 0.45),
            ),
          ),
        ],
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: onSurface.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
    );
  }
}
