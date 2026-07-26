import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/dashboard/domain/dashboard_data.dart';
import 'package:repster/features/dashboard/domain/weekly_stats.dart';
import 'package:repster/features/dashboard/presentation/widgets/consistency_panel.dart';
import 'package:repster/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:repster/features/dashboard/presentation/widgets/dashboard_section_header.dart';
import 'package:repster/features/dashboard/presentation/widgets/hero_cta_card.dart';
import 'package:repster/features/dashboard/presentation/widgets/in_progress_banner.dart';
import 'package:repster/features/dashboard/presentation/widgets/recent_session_card.dart';
import 'package:repster/features/dashboard/presentation/widgets/template_preview_card.dart';
import 'package:repster/features/dashboard/presentation/widgets/weekly_stats_panel.dart';
import 'package:repster/features/session/presentation/start_session.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/edge_bleed.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  static const int _maxRecentSessions = 6;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashAsync = ref.watch(dashboardControllerProvider);

    return GlowScaffold(
      child: AsyncValueWidget<DashboardData>(
        value: dashAsync,
        onRetry: () => ref.invalidate(dashboardControllerProvider),
        data: (d) => RefreshIndicator(
          onRefresh: () =>
              ref.read(dashboardControllerProvider.notifier).refresh(),
          child: _DashboardBody(data: d),
        ),
      ),
    );
  }
}

class _DashboardBody extends ConsumerWidget {
  const _DashboardBody({required this.data});
  final DashboardData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = WeeklyStats.fromSessions(data.recentSessions);
    final suggested = data.activeTemplates.isNotEmpty
        ? data.activeTemplates.first
        : null;
    final recents = data.recentSessions
        .take(DashboardScreen._maxRecentSessions)
        .toList(growable: false);

    final stagger = StaggeredList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        stagger.wrap(
          DashboardHeader(
            user: data.user,
            streakWeeks: stats.streakWeeks,
            onAvatarTap: () => context.push(Routes.profile),
          ),
        ),
        const SizedBox(height: 20),
        if (data.inProgress != null) ...[
          stagger.wrap(InProgressBanner(info: data.inProgress!)),
          const SizedBox(height: 20),
        ],
        stagger.wrap(WeeklyStatsPanel(stats: stats)),
        const SizedBox(height: 20),
        stagger.wrap(ConsistencyPanel(consistency: data.consistency)),
        const SizedBox(height: 20),
        stagger.wrap(
          HeroCtaCard(
            suggested: suggested,
            onStart: (t) => startTemplateSession(context, ref, t.id),
            onCreate: () => context.go(Routes.templateNew),
          ),
        ),
        const SizedBox(height: 24),
        stagger.wrap(
          DashboardSectionHeader(
            title: t.dashboard.sections.templates,
            onSeeAll: () => context.go(Routes.templates),
          ),
        ),
        const SizedBox(height: 12),
        stagger.wrap(_TemplatesCarousel(data: data)),
        const SizedBox(height: 24),
        stagger.wrap(
          DashboardSectionHeader(
            title: t.dashboard.sections.recentSessions,
            onSeeAll: recents.isEmpty ? null : () => context.go(Routes.history),
          ),
        ),
        const SizedBox(height: 12),
        if (recents.isEmpty)
          stagger.wrap(const _RecentEmptyState())
        else
          for (final s in recents)
            stagger.wrap(
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: RecentSessionCard(
                  summary: s,
                  onTap: () => context.push(Routes.sessionDetail(s.id)),
                ),
              ),
            ),
      ],
    );
  }
}

class _TemplatesCarousel extends ConsumerWidget {
  const _TemplatesCarousel({required this.data});
  final DashboardData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    if (data.activeTemplates.isEmpty) {
      return Row(
        children: [
          Icon(
            LucideIcons.dumbbell,
            size: 16,
            color: onSurface.withValues(alpha: 0.30),
          ),
          const SizedBox(width: 8),
          Text(
            t.dashboard.templates.empty,
            style: TextStyle(
              fontSize: 14,
              color: onSurface.withValues(alpha: 0.30),
            ),
          ),
        ],
      );
    }

    final templates = data.activeTemplates;
    return SizedBox(
      height: kTemplateCarouselHeight,
      child: EdgeBleed(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: templates.length + 1,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, i) {
            if (i == templates.length) {
              return NewTemplateCard(
                onTap: () => context.go(Routes.templateNew),
              );
            }
            final t = templates[i];
            return TemplatePreviewCard(
              template: t,
              onTap: () => startTemplateSession(context, ref, t.id),
            );
          },
        ),
      ),
    );
  }
}

class _RecentEmptyState extends StatelessWidget {
  const _RecentEmptyState();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Icon(
            LucideIcons.award,
            size: 28,
            color: scheme.primary.withValues(alpha: 0.50),
          ),
          const SizedBox(height: 10),
          Text(
            t.dashboard.recent.emptyTitle,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            t.dashboard.recent.emptyMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: onSurface.withValues(alpha: 0.35),
            ),
          ),
        ],
      ),
    );
  }
}
