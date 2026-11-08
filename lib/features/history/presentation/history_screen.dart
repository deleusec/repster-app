import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/history/domain/history_stats.dart';
import 'package:repster/features/history/presentation/widgets/history_session_card.dart';
import 'package:repster/features/history/presentation/widgets/history_stats_panel.dart';
import 'package:repster/features/stats/application/stats_controller.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/empty_state.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/screen_header.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
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

    final stats = HistoryStats.fromSessions(all);
    final groups = _grouped(all, DateTime.now());

    final animate = _animateOnNextBuild;
    if (animate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animateOnNextBuild = false;
      });
    }
    final stagger = StaggeredList(enabled: animate);

    final count = all.length;
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
    ];

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

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(
          label.toUpperCase(),
          style: AppText.sectionLabel.copyWith(color: scheme.textSecondary),
        ),
        const SizedBox(width: 8),
        Text(
          '$count',
          style: AppText.sectionLabel.copyWith(
            letterSpacing: 0,
            color: scheme.textTertiary,
          ),
        ),
      ],
    );
  }
}
