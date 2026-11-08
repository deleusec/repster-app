import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/features/session/domain/exercise_history.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';
import 'package:repster/shared/widgets/app_loading.dart';

/// Read-only per-exercise history: past sessions grouped by date (most recent
/// first), each with its completed sets (reps × weight, or held duration).
Future<void> showExerciseHistorySheet(
  BuildContext context, {
  required String name,
  required Future<List<ExerciseHistoryEntry>> future,
}) {
  return showGlassSheet<void>(
    context,
    builder: (_) => _HistorySheet(name: name, future: future),
  );
}

class _HistorySheet extends StatefulWidget {
  const _HistorySheet({required this.name, required this.future});

  final String name;
  final Future<List<ExerciseHistoryEntry>> future;

  @override
  State<_HistorySheet> createState() => _HistorySheetState();
}

class _HistorySheetState extends State<_HistorySheet> {
  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 8, bottom: 4),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: onSurface.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.history,
                    size: 18,
                    color: onSurface.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      t.session.history.title(name: widget.name),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<List<ExerciseHistoryEntry>>(
      future: widget.future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return _Centered(child: _Loading());
        }
        if (snap.hasError) {
          return _Centered(child: _Message(t.errors.generic));
        }
        final entries = snap.data ?? const <ExerciseHistoryEntry>[];
        if (entries.isEmpty) {
          return _Centered(child: _Message(t.session.history.empty));
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          itemCount: entries.length,
          separatorBuilder: (_, _) => const SizedBox(height: 18),
          itemBuilder: (context, i) => _EntryTile(entry: entries[i]),
        );
      },
    );
  }
}

class _EntryTile extends StatelessWidget {
  const _EntryTile({required this.entry});

  final ExerciseHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final raw = DateFormat(t.session.history.dateFormat).format(entry.date);
    final date = raw.isEmpty ? raw : raw[0].toUpperCase() + raw.substring(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            color: onSurface.withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < entry.sets.length; i++) ...[
          if (i > 0) const SizedBox(height: 6),
          _SetRow(set: entry.sets[i]),
        ],
      ],
    );
  }
}

class _SetRow extends StatelessWidget {
  const _SetRow({required this.set});

  final ExerciseHistorySet set;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(
            t.session.history.setLabel(n: set.setNumber),
            style: TextStyle(
              fontSize: 13,
              color: onSurface.withValues(alpha: 0.45),
            ),
          ),
        ),
        Text(
          _value(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: onSurface.withValues(alpha: 0.92),
          ),
        ),
      ],
    );
  }

  String _value() {
    if (set.seconds != null) {
      final dur = formatHoldDuration(set.seconds ?? 0);
      return set.weight > 0 ? '$dur · ${formatWeight(set.weight)} kg' : dur;
    }
    if (set.weight > 0) {
      return '${set.reps} × ${formatWeight(set.weight)} kg';
    }
    return '${set.reps} × ${t.session.bw}';
  }
}

class _Centered extends StatelessWidget {
  const _Centered({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
    child: Center(child: child),
  );
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSpinner(size: 14, color: onSurface.withValues(alpha: 0.4)),
        const SizedBox(width: 10),
        Text(
          t.session.history.loading,
          style: TextStyle(
            fontSize: 13,
            color: onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _Message extends StatelessWidget {
  const _Message(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 13, color: onSurface.withValues(alpha: 0.5)),
    );
  }
}
