import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/profile/domain/profile_stats.dart';
import 'package:repster/features/profile/presentation/widgets/profile_badges_section.dart';
import 'package:repster/features/profile/presentation/widgets/profile_edit_form.dart';
import 'package:repster/features/profile/presentation/widgets/profile_favorite_card.dart';
import 'package:repster/features/profile/presentation/widgets/profile_identity_hero.dart';
import 'package:repster/features/profile/presentation/widgets/profile_stats_row.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/back_nav_bar.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/section_label.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    return GlowScaffold(
      child: AsyncValueWidget<AuthUser?>(
        value: user,
        data: (u) => u == null
            ? Center(child: Text(t.profile.notConnected))
            : _ProfileView(user: u),
      ),
    );
  }
}

class _ProfileView extends ConsumerWidget {
  const _ProfileView({required this.user});

  final AuthUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions =
        ref.watch(historyControllerProvider).valueOrNull ??
        const <WorkoutSessionSummary>[];
    final templateCount =
        ref.watch(templatesControllerProvider).valueOrNull?.length ?? 0;
    final stats = ProfileStats.from(
      sessions: sessions,
      templateCount: templateCount,
    );

    final stagger = StaggeredList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        stagger.wrap(
          BackNavBar(
            onBack: () => context.pop(),
            title: t.profile.navTitle,
            actionIcon: LucideIcons.pencil,
            onAction: () => _openEditSheet(context, ref),
          ),
        ),
        const SizedBox(height: 20),
        stagger.wrap(ProfileIdentityHero(user: user)),
        const SizedBox(height: 28),
        stagger.wrap(ProfileStatsRow(stats: stats)),
        const SizedBox(height: 24),
        if (stats.favorite != null) ...[
          stagger.wrap(SectionLabel(t.profile.sections.favoriteMuscleGroup)),
          const SizedBox(height: 12),
          stagger.wrap(ProfileFavoriteCard(favorite: stats.favorite!)),
          const SizedBox(height: 24),
        ],
        stagger.wrap(
          SectionLabel(t.profile.sections.badges, icon: LucideIcons.award),
        ),
        const SizedBox(height: 12),
        stagger.wrap(ProfileBadgesSection(badges: stats.badges)),
      ],
    );
  }

  Future<void> _openEditSheet(BuildContext context, WidgetRef ref) {
    return AppDrawerSheet.show<void>(
      context,
      title: t.profile.editSheet.title,
      child: ProfileEditForm(user: user),
    );
  }
}
