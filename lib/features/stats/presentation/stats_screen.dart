import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/stats/application/stats_controller.dart';
import 'package:repster/features/stats/domain/stats_data.dart';
import 'package:repster/features/stats/domain/stats_range.dart';
import 'package:repster/features/stats/presentation/stats_range_l10n.dart';
import 'package:repster/features/stats/presentation/widgets/exercise_progress_panel.dart';
import 'package:repster/features/stats/presentation/widgets/records_panel.dart';
import 'package:repster/features/stats/presentation/widgets/stats_kpi_grid.dart';
import 'package:repster/features/stats/presentation/widgets/weekly_volume_chart.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/empty_state.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/pressable.dart';
import 'package:repster/shared/widgets/screen_header.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statsControllerProvider);
    final range = ref.watch(statsRangeProvider);
    void onRange(StatsRange r) =>
        ref.read(statsRangeProvider.notifier).state = r;

    return GlowScaffold(
      child: AsyncValueWidget<StatsData>(
        value: stats,
        onRetry: () => ref.invalidate(statsSessionsProvider),
        data: (data) => RefreshIndicator(
          onRefresh: () => ref.refresh(statsSessionsProvider.future),
          child: data.isEmpty
              ? _EmptyBody(range: range, onRange: onRange)
              : _StatsBody(data: data, range: range, onRange: onRange),
        ),
      ),
    );
  }
}

String _subtitle(int sessions, StatsRange range) => sessions == 0
    ? t.stats.subtitle.empty
    : '${t.stats.sessionsCount(n: sessions)} · ${range.localizedLabel}';

class _StatsBody extends StatelessWidget {
  const _StatsBody({
    required this.data,
    required this.range,
    required this.onRange,
  });

  final StatsData data;
  final StatsRange range;
  final ValueChanged<StatsRange> onRange;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        ScreenHeader(
          title: t.stats.title,
          subtitle: _subtitle(data.kpis.sessions, range),
        ),
        const SizedBox(height: 16),
        _RangePills(selected: range, onSelect: onRange),
        const SizedBox(height: 18),
        StatsKpiGrid(kpis: data.kpis),
        const SizedBox(height: 16),
        WeeklyVolumeChart(weeks: data.weeklyVolume),
        // Everything below ignores the range pills on purpose — the label says
        // so, so a four-week filter never reads as "these are my records".
        const SizedBox(height: 24),
        const _StrengthDivider(),
        const SizedBox(height: 14),
        ExerciseProgressPanel(exercises: data.exercises),
        if (!data.records.isEmpty) ...[
          const SizedBox(height: 16),
          RecordsPanel(records: data.records),
        ],
      ],
    );
  }
}

class _EmptyBody extends StatelessWidget {
  const _EmptyBody({required this.range, required this.onRange});

  final StatsRange range;
  final ValueChanged<StatsRange> onRange;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        ScreenHeader(title: t.stats.title, subtitle: _subtitle(0, range)),
        const SizedBox(height: 16),
        _RangePills(selected: range, onSelect: onRange),
        const SizedBox(height: 60),
        EmptyState(
          icon: LucideIcons.chartColumn,
          title: t.stats.empty.title,
          message: t.stats.empty.message,
        ),
      ],
    );
  }
}

/// Separates the range-scoped activity blocks above from the strength blocks
/// below, which read the whole history. Names the scope rather than leaving the
/// reader to assume the pills apply.
class _StrengthDivider extends StatelessWidget {
  const _StrengthDivider();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(
          t.stats.strength.title,
          style: AppText.sectionLabel.copyWith(color: scheme.textSecondary),
        ),
        const SizedBox(width: 10),
        Text(
          t.stats.strength.scope,
          style: AppText.caption.copyWith(color: scheme.textTertiary),
        ),
        const SizedBox(width: 12),
        Expanded(child: Container(height: 1, color: scheme.hairline)),
      ],
    );
  }
}

class _RangePills extends StatelessWidget {
  const _RangePills({required this.selected, required this.onSelect});

  final StatsRange selected;
  final ValueChanged<StatsRange> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: scheme.onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          for (final r in StatsRange.values)
            Expanded(
              child: _RangeTab(
                label: r.localizedShort,
                selected: r == selected,
                onTap: () => onSelect(r),
              ),
            ),
        ],
      ),
    );
  }
}

class _RangeTab extends StatelessWidget {
  const _RangeTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Pressable(
      onTap: onTap,
      scale: 0.96,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? scheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? scheme.onPrimary : scheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
