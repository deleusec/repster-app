import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/history/domain/history_stats.dart';
import 'package:repster/features/history/presentation/widgets/history_session_card.dart';
import 'package:repster/features/history/presentation/widgets/history_stats_panel.dart';
import 'package:repster/features/stats/application/stats_controller.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/l10n/muscle_group_l10n.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/edge_bleed.dart';
import 'package:repster/shared/widgets/empty_state.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';
import 'package:repster/shared/widgets/screen_header.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  MuscleGroup? _tagFilter;
  bool _animateOnNextBuild = true;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(historyControllerProvider);

    return GlowScaffold(
      child: AsyncValueWidget<List<WorkoutSessionSummary>>(
        value: history,
        onRetry: () => ref.invalidate(historyControllerProvider),
        data: _buildData,
      ),
    );
  }

  Widget _buildData(List<WorkoutSessionSummary> all) {
    if (all.isEmpty) {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
          children: [
            ScreenHeader(
              title: t.history.title,
              subtitle: t.history.emptySubtitle,
            ),
            const SizedBox(height: 80),
            EmptyState(
              icon: LucideIcons.history,
              title: t.history.emptyTitle,
              message: t.history.emptyMessage,
            ),
          ],
        ),
      );
    }

    final filter = _tagFilter;
    final filtered = filter == null
        ? all
        : all.where((s) => s.tags.contains(filter)).toList(growable: false);
    final stats = HistoryStats.fromSessions(filtered);
    final groups = _grouped(filtered, DateTime.now());

    final counts = <MuscleGroup, int>{};
    for (final s in all) {
      for (final g in s.tags) {
        counts[g] = (counts[g] ?? 0) + 1;
      }
    }
    final groupOrder = MuscleGroup.values
        .where(counts.containsKey)
        .toList(growable: false);

    final animate = _animateOnNextBuild;
    if (animate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animateOnNextBuild = false;
      });
    }
    final stagger = StaggeredList(enabled: animate);

    final count = filtered.length;
    final children = <Widget>[
      stagger.wrap(
        ScreenHeader(
          title: t.history.title,
          subtitle: t.history.sessionCount(n: count),
        ),
      ),
      const SizedBox(height: 18),
      stagger.wrap(HistoryStatsPanel(stats: stats)),
      const SizedBox(height: 16),
      if (groupOrder.isNotEmpty) ...[
        stagger.wrap(
          _FilterPills(
            groups: groupOrder,
            counts: counts,
            selected: _tagFilter,
            onSelect: (g) => setState(() {
              _tagFilter = g;
              _animateOnNextBuild = true;
            }),
          ),
        ),
        const SizedBox(height: 4),
      ],
    ];

    if (groups.isEmpty) {
      children
        ..add(const SizedBox(height: 40))
        ..add(const _NoResult());
    } else {
      for (final group in groups) {
        children
          ..add(const SizedBox(height: 14))
          ..add(
            stagger.wrap(
              _GroupHeader(label: group.label, count: group.items.length),
            ),
          )
          ..add(const SizedBox(height: 10));
        for (final s in group.items) {
          children.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: stagger.wrap(
                HistorySessionCard(
                  summary: s,
                  onTap: () => context.push(Routes.sessionDetail(s.id)),
                  onDelete: () => _delete(s.id),
                ),
              ),
            ),
          );
        }
      }
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: children,
      ),
    );
  }

  Future<void> _refresh() =>
      ref.read(historyControllerProvider.notifier).refresh();

  Future<void> _delete(String id) async {
    try {
      await ref.read(historyControllerProvider.notifier).delete(id);
      ref
        ..invalidate(dashboardControllerProvider)
        ..invalidate(statsSessionsProvider);
    } on Object catch (_) {
      if (!mounted) return;
      AppToast.showError(context, 'Échec de la suppression.');
    }
  }

  List<_Group> _grouped(List<WorkoutSessionSummary> sessions, DateTime now) {
    final map = <String, List<WorkoutSessionSummary>>{};
    final order = <String>[];
    for (final s in sessions) {
      final label = _groupLabel(s.startedAt, now);
      final existing = map[label];
      if (existing == null) {
        map[label] = [s];
        order.add(label);
      } else {
        existing.add(s);
      }
    }
    return [for (final l in order) _Group(l, map[l]!)];
  }

  String _groupLabel(DateTime when, DateTime now) {
    final days = now.difference(when).inDays;
    if (days < 7) return t.history.groups.thisWeek;
    if (days < 14) return t.history.groups.lastWeek;
    final weeks = days ~/ 7;
    if (weeks < 5) return t.history.groups.weeksAgo(n: weeks);
    return monthLabel(when);
  }
}

class _Group {
  const _Group(this.label, this.items);

  final String label;
  final List<WorkoutSessionSummary> items;
}

class _FilterPills extends StatelessWidget {
  const _FilterPills({
    required this.groups,
    required this.counts,
    required this.selected,
    required this.onSelect,
  });

  final List<MuscleGroup> groups;
  final Map<MuscleGroup, int> counts;
  final MuscleGroup? selected;
  final ValueChanged<MuscleGroup?> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: EdgeBleed(
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            _Pill(
              label: t.common.all,
              selected: selected == null,
              onTap: () => onSelect(null),
            ),
            for (final g in groups) ...[
              const SizedBox(width: 8),
              _Pill(
                label: g.localizedLabel,
                count: counts[g],
                accent: g.accent,
                selected: selected == g,
                onTap: () => onSelect(selected == g ? null : g),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.selected,
    required this.onTap,
    this.count,
    this.accent,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final int? count;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final c = accent ?? scheme.primary;
    final bg = selected
        ? c.withValues(alpha: 0.18)
        : onSurface.withValues(alpha: 0.04);
    final border = selected
        ? c.withValues(alpha: 0.45)
        : onSurface.withValues(alpha: 0.08);
    final fg = selected ? c : onSurface.withValues(alpha: 0.6);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        onTap: onTap,
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: border),
          ),
          child: Text(
            count == null ? label : '$label · $count',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ),
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: onSurface.withValues(alpha: 0.45),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: onSurface.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }
}

class _NoResult extends StatelessWidget {
  const _NoResult();

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          t.history.noResult,
          style: TextStyle(
            fontSize: 14,
            color: onSurface.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}
