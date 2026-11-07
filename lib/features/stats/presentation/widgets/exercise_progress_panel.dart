import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/stats/domain/stats_data.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';
import 'package:repster/shared/widgets/pressable.dart';
import 'package:repster/shared/widgets/stat_panel.dart';

/// Per-exercise progression: picker + estimated 1RM (Epley) curve with
/// record (PR) markers.
class ExerciseProgressPanel extends StatefulWidget {
  const ExerciseProgressPanel({required this.exercises, super.key});

  final List<ExerciseProgress> exercises;

  @override
  State<ExerciseProgressPanel> createState() => _ExerciseProgressPanelState();
}

class _ExerciseProgressPanelState extends State<ExerciseProgressPanel> {
  int _selected = 0;

  @override
  void didUpdateWidget(ExerciseProgressPanel old) {
    super.didUpdateWidget(old);
    if (_selected >= widget.exercises.length) _selected = 0;
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    if (widget.exercises.isEmpty) {
      return StatPanel(
        title: t.stats.exercise.title,
        icon: LucideIcons.chartLine,
        child: Text(
          t.stats.exercise.empty,
          style: TextStyle(
            fontSize: 13,
            color: onSurface.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    final ex = widget.exercises[_selected];
    return StatPanel(
      title: t.stats.exercise.title,
      icon: LucideIcons.chartLine,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Picker(
            exercises: widget.exercises,
            selected: _selected,
            onSelect: (i) => setState(() => _selected = i),
          ),
          const SizedBox(height: 14),
          _Chart(progress: ex),
        ],
      ),
    );
  }
}

class _Picker extends StatelessWidget {
  const _Picker({
    required this.exercises,
    required this.selected,
    required this.onSelect,
  });

  final List<ExerciseProgress> exercises;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        final picked = await showGlassSheet<int>(
          context,
          builder: (_) =>
              _ExercisePickerSheet(exercises: exercises, selected: selected),
        );
        if (picked != null) onSelect(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: scheme.controlSurface,
        child: Row(
          children: [
            Icon(
              LucideIcons.dumbbell,
              size: 15,
              color: onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                exercises[selected].name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: onSurface,
                ),
              ),
            ),
            Icon(
              LucideIcons.chevronDown,
              size: 16,
              color: onSurface.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

/// Exercise picker bottom sheet: search (above 8 exercises), list sorted by
/// frequency, capped height and scrollable.
class _ExercisePickerSheet extends StatefulWidget {
  const _ExercisePickerSheet({required this.exercises, required this.selected});

  final List<ExerciseProgress> exercises;
  final int selected;

  @override
  State<_ExercisePickerSheet> createState() => _ExercisePickerSheetState();
}

class _ExercisePickerSheetState extends State<_ExercisePickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final showSearch = widget.exercises.length > 8;
    final q = _query.trim().toLowerCase();
    final items = [
      for (var i = 0; i < widget.exercises.length; i++)
        if (q.isEmpty || widget.exercises[i].name.toLowerCase().contains(q))
          (index: i, exercise: widget.exercises[i]),
    ];

    final insets = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: insets),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: onSurface.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
              child: Row(
                children: [
                  Text(
                    t.stats.exercise.pickerTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: onSurface,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.exercises.length}',
                    style: TextStyle(
                      fontSize: 13,
                      color: onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
            if (showSearch)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: _SearchField(
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: items.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(28),
                      child: Text(
                        t.stats.exercise.noExercise,
                        style: TextStyle(
                          color: onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      itemCount: items.length,
                      itemBuilder: (context, k) {
                        final item = items[k];
                        final selected = item.index == widget.selected;
                        return _PickerRow(
                          name: item.exercise.name,
                          sessions: item.exercise.sessionCount,
                          selected: selected,
                          onTap: () => Navigator.of(context).pop(item.index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: scheme.controlSurface,
      child: Row(
        children: [
          Icon(
            LucideIcons.search,
            size: 17,
            color: onSurface.withValues(alpha: 0.45),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: TextField(
              autofocus: true,
              onChanged: onChanged,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: scheme.primary,
              style: TextStyle(fontSize: 14, color: onSurface),
              decoration: InputDecoration(
                isCollapsed: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: t.stats.exercise.searchHint,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: onSurface.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerRow extends StatelessWidget {
  const _PickerRow({
    required this.name,
    required this.sessions,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final int sessions;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Pressable(
      onTap: onTap,
      scale: 0.98,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? scheme.glow : scheme.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              t.stats.sessionsCount(n: sessions),
              style: TextStyle(fontSize: 12, color: scheme.textTertiary),
            ),
            if (selected) ...[
              const SizedBox(width: 10),
              Icon(LucideIcons.check, size: 16, color: scheme.glow),
            ],
          ],
        ),
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({required this.progress});

  final ExerciseProgress progress;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final points = progress.points;

    final spots = <FlSpot>[];
    final isPr = <bool>[];
    var runningMax = 0.0;
    for (var i = 0; i < points.length; i++) {
      final e = points[i].estimatedOneRm;
      spots.add(FlSpot(i.toDouble(), e));
      final pr = e > runningMax + 0.01;
      isPr.add(pr);
      if (e > runningMax) runningMax = e;
    }
    final maxY = spots.fold<double>(0, (m, s) => s.y > m ? s.y : m);
    final minY = spots.fold<double>(maxY, (m, s) => s.y < m ? s.y : m);
    final pad = (maxY - minY) * 0.15 + 1;

    final best = points.reduce(
      (a, b) => a.estimatedOneRm >= b.estimatedOneRm ? a : b,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TrendLine(progress: progress),
        const SizedBox(height: 12),
        Row(
          children: [
            _Stat(
              label: t.stats.exercise.oneRmMax,
              value: '${best.estimatedOneRm.round()} kg',
              color: scheme.glow,
            ),
            const SizedBox(width: 20),
            _Stat(
              label: t.stats.exercise.bestLoad,
              value: '${formatWeight(best.topWeight)} kg',
              color: AppColors.accentEmerald,
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 160,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              minY: (minY - pad).clamp(0, double.infinity),
              maxY: maxY + pad,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => scheme.surfaceContainerHigh,
                  getTooltipItems: (touched) => [
                    for (final t in touched)
                      LineTooltipItem(
                        '${t.y.round()} kg',
                        TextStyle(
                          color: onSurface,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  preventCurveOverShooting: true,
                  color: scheme.glow,
                  barWidth: 2.5,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    getDotPainter: (spot, percent, bar, index) =>
                        FlDotCirclePainter(
                          radius: isPr[index] ? 4.5 : 2.5,
                          color: isPr[index]
                              ? AppColors.accentAmber
                              : scheme.glow,
                          strokeColor: Colors.transparent,
                        ),
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    color: scheme.glow.withValues(alpha: 0.14),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              shortDate(points.first.date),
              style: TextStyle(
                fontSize: 11,
                color: onSurface.withValues(alpha: 0.5),
              ),
            ),
            const Spacer(),
            const Icon(
              LucideIcons.star,
              size: 11,
              color: AppColors.accentAmber,
            ),
            const SizedBox(width: 4),
            Text(
              t.stats.exercise.record,
              style: TextStyle(
                fontSize: 11,
                color: onSurface.withValues(alpha: 0.5),
              ),
            ),
            const Spacer(),
            Text(
              shortDate(points.last.date),
              style: TextStyle(
                fontSize: 11,
                color: onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: color,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: onSurface.withValues(alpha: 0.45),
          ),
        ),
      ],
    );
  }
}

/// Turns the curve into a sentence: a reader should not have to eyeball a slope
/// to know whether they are moving.
class _TrendLine extends StatelessWidget {
  const _TrendLine({required this.progress});

  final ExerciseProgress progress;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final trend = progress.trend;
    final rate = progress.monthlyRate;
    if (trend == null || rate == null) {
      return Text(
        t.stats.exercise.trendUnknown,
        style: TextStyle(
          fontSize: 12,
          color: onSurface.withValues(alpha: 0.45),
        ),
      );
    }

    final (icon, color, label) = switch (trend) {
      StrengthTrend.progressing => (
        LucideIcons.trendingUp,
        AppColors.accentEmerald,
        t.stats.exercise.trendProgressing,
      ),
      StrengthTrend.plateau => (
        LucideIcons.minus,
        AppColors.accentAmber,
        t.stats.exercise.trendPlateau(n: progress.sessionsSinceBest),
      ),
      StrengthTrend.regressing => (
        LucideIcons.trendingDown,
        AppColors.accentRose,
        t.stats.exercise.trendRegressing,
      ),
    };
    final signed =
        '${rate >= 0 ? '+' : '-'}${formatDecimal((rate * 100).abs())}';
    final rateLabel = t.stats.exercise.perMonth(value: signed);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                '$label · $rateLabel',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        if (trend == StrengthTrend.plateau)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 20),
            child: Text(
              t.stats.exercise.plateauHint,
              style: TextStyle(
                fontSize: 11,
                color: onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
      ],
    );
  }
}
