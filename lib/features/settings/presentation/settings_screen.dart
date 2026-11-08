import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/core/web/safe_area.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/auth/presentation/goal_l10n.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/settings/presentation/widgets/language_picker_sheet.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/icon_chip.dart';
import 'package:repster/shared/widgets/pressable.dart';
import 'package:repster/shared/widgets/screen_header.dart';
import 'package:repster/shared/widgets/section_label.dart';

/// Settings screen: profile card, grouped shortcuts (data, preferences,
/// account), and sign-out with inline confirmation.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authControllerProvider);
    // Keep showing a stale user while a refresh is in flight — the card is
    // identity, not live data, and blinking it out is worse than a second of
    // staleness.
    final user = userState.valueOrNull;
    // Only surface the failure when it left nothing to show.
    final userError = user == null ? userState.error : null;

    // Best-effort on purpose: these two only decorate a row with a count. A
    // row that navigates without its badge is a smaller loss than a settings
    // screen that refuses to open because a count could not be fetched.
    final templateCount = ref
        .watch(templatesControllerProvider)
        .valueOrNull
        ?.length;
    final sessionCount = ref
        .watch(historyControllerProvider)
        .valueOrNull
        ?.length;

    final stagger = StaggeredList();

    return GlowScaffold(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          stagger.wrap(ScreenHeader(title: t.settings.title)),
          const SizedBox(height: 24),
          if (user != null) ...[
            stagger.wrap(SectionLabel(t.settings.sections.profile)),
            const SizedBox(height: 12),
            stagger.wrap(
              _ProfileCard(
                user: user,
                onTap: () => context.push(Routes.profile),
              ),
            ),
            const SizedBox(height: 24),
          ] else if (userError != null) ...[
            stagger.wrap(SectionLabel(t.settings.sections.profile)),
            const SizedBox(height: 12),
            stagger.wrap(
              _ProfileCardError(
                error: userError,
                onRetry: () => ref.invalidate(authControllerProvider),
              ),
            ),
            const SizedBox(height: 24),
          ],
          stagger.wrap(SectionLabel(t.settings.sections.data)),
          const SizedBox(height: 12),
          stagger.wrap(
            _SettingsGroup(
              rows: [
                _SettingsRow(
                  icon: LucideIcons.dumbbell,
                  tint: Theme.of(context).colorScheme.primary,
                  label: t.settings.rows.templates,
                  badge: templateCount,
                  onTap: () => context.go(Routes.templates),
                ),
                _SettingsRow(
                  icon: LucideIcons.calendar,
                  tint: AppColors.accentEmerald,
                  label: t.settings.rows.history,
                  badge: sessionCount,
                  onTap: () => context.go(Routes.history),
                ),
                _SettingsRow(
                  icon: LucideIcons.trendingUp,
                  tint: AppColors.accentBlue,
                  label: t.settings.rows.stats,
                  onTap: () => context.go(Routes.stats),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          stagger.wrap(SectionLabel(t.settings.sections.preferences)),
          const SizedBox(height: 12),
          stagger.wrap(
            _SettingsGroup(
              rows: [
                _SettingsRow(
                  icon: LucideIcons.bell,
                  tint: AppColors.accentAmber,
                  label: t.settings.rows.notifications,
                  hint: t.settings.soon,
                  onTap: () => AppToast.showInfo(context, t.settings.soonToast),
                ),
                _SettingsRow(
                  icon: LucideIcons.languages,
                  tint: AppColors.accentBlue,
                  label: t.settings.rows.language,
                  onTap: () => showLanguagePicker(context),
                ),
                _SettingsRow(
                  icon: LucideIcons.shield,
                  tint: AppColors.accentRose,
                  label: t.settings.rows.privacy,
                  onTap: () => context.push(Routes.privacy),
                ),
                _SettingsRow(
                  icon: LucideIcons.scrollText,
                  tint: AppColors.accentViolet,
                  label: t.settings.rows.terms,
                  onTap: () => context.push(Routes.terms),
                ),
                _SettingsRow(
                  icon: LucideIcons.mail,
                  tint: AppColors.accentOrange,
                  label: t.settings.rows.contact,
                  onTap: () => context.push(Routes.contact),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          stagger.wrap(SectionLabel(t.settings.sections.account)),
          const SizedBox(height: 12),
          stagger.wrap(
            _SettingsGroup(
              rows: [
                _SettingsRow(
                  icon: LucideIcons.lock,
                  tint: Theme.of(context).colorScheme.primary,
                  label: t.settings.rows.changePassword,
                  onTap: () => context.push(Routes.changePassword),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          stagger.wrap(const _LogoutButton()),
          const SizedBox(height: 24),
          const _VersionFooter(),
        ],
      ),
    );
  }
}

/// Stands in for [_ProfileCard] when the user could not be loaded.
///
/// The screen deliberately does not gate on the user: sign-out, the language
/// picker and the legal pages have to stay reachable precisely when auth is
/// unhappy — an error page here could strand someone with a broken session.
/// But a card that simply vanishes reads as "you are signed out", so the
/// failure gets a row of its own instead of no row at all.
class _ProfileCardError extends StatelessWidget {
  const _ProfileCardError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return EdgeLitSurface(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconChip(
            icon: LucideIcons.circleAlert,
            color: scheme.error,
            size: 38,
            iconSize: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.settings.profileUnavailable,
                  style: AppText.bodyStrong.copyWith(color: scheme.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  humanizeAppError(error),
                  style: AppText.caption.copyWith(
                    height: 1.4,
                    color: scheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          AppButton(
            label: t.common.actions.retry,
            variant: AppButtonVariant.ghost,
            size: AppButtonSize.sm,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}

/// Profile preview card: gradient avatar, name, email, and goal.
class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.user, required this.onTap});

  final AuthUser user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final goal = user.goal;
    final name = user.fullName?.trim().isNotEmpty ?? false
        ? user.fullName!.trim()
        : t.settings.defaultName;

    return EdgeLitSurface(
      radius: AppRadius.sheet,
      padding: const EdgeInsets.all(16),
      accent: scheme.glow,
      onTap: onTap,
      child: Row(
        children: [
          _ProfileAvatar(user: user),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.cardTitle.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.2,
                    color: scheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption.copyWith(color: scheme.textSecondary),
                ),
                if (goal != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    '${goal.emoji} ${goal.localizedLabel}',
                    style: AppText.caption.copyWith(
                      fontSize: 11,
                      color: scheme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.settings.editProfile,
                style: AppText.microLabel.copyWith(
                  fontSize: 9,
                  color: scheme.textTertiary,
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                LucideIcons.chevronRight,
                size: 16,
                color: scheme.textTertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Square gradient avatar (image or initial).
class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.user});

  final AuthUser user;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final avatarUrl = user.avatarUrl;
    return Container(
      width: 56,
      height: 56,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [scheme.primary, const Color(0xFF7F1D1D)],
        ),
      ),
      alignment: Alignment.center,
      child: avatarUrl != null
          ? Image.network(
              avatarUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _initial(),
            )
          : _initial(),
    );
  }

  Widget _initial() {
    final name = user.firstName.trim();
    final char = name.isNotEmpty
        ? name.substring(0, 1)
        : (user.email.isEmpty ? '?' : user.email.substring(0, 1));
    return Text(
      char.toUpperCase(),
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    );
  }
}

/// Translucent container grouping [_SettingsRow]s separated by a hairline.
class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.rows});

  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final children = <Widget>[];
    for (var i = 0; i < rows.length; i++) {
      if (i > 0) children.add(_RowDivider(color: scheme.hairline));
      children.add(rows[i]);
    }
    return EdgeLitSurface(
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 60),
    child: Divider(height: 1, color: color),
  );
}

/// A settings-group row: icon chip, label, optional badge/hint, and chevron.
class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.tint,
    required this.label,
    required this.onTap,
    this.badge,
    this.hint,
  });

  final IconData icon;
  final Color tint;
  final String label;
  final VoidCallback onTap;
  final int? badge;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final badge = this.badge;
    final hint = this.hint;
    return Pressable(
      onTap: onTap,
      scale: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            IconChip(icon: icon, color: tint, size: 32, iconSize: 16),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.body.copyWith(color: scheme.textPrimary),
              ),
            ),
            if (hint != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  hint.toUpperCase(),
                  style: AppText.microLabel.copyWith(
                    letterSpacing: 0.8,
                    color: scheme.textTertiary,
                  ),
                ),
              ),
            if (badge != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  '$badge',
                  style: AppText.bodyStrong.copyWith(
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: scheme.textSecondary,
                  ),
                ),
              ),
            Icon(
              LucideIcons.chevronRight,
              size: 16,
              color: scheme.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Sign-out button with inline confirmation.
class _LogoutButton extends ConsumerStatefulWidget {
  const _LogoutButton();

  @override
  ConsumerState<_LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends ConsumerState<_LogoutButton> {
  bool _confirming = false;

  Future<void> _signOut() async {
    try {
      await ref.read(authControllerProvider.notifier).signOut();
    } on Object {
      if (!mounted) return;
      AppToast.showError(context, t.settings.logout.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;

    if (!_confirming) {
      return _LogoutAction(
        icon: LucideIcons.logOut,
        label: t.settings.logout.action,
        color: scheme.textSecondary,
        background: onSurface.withValues(alpha: 0.04),
        border: onSurface.withValues(alpha: 0.08),
        onTap: () => setState(() => _confirming = true),
      );
    }

    return Row(
      children: [
        Expanded(
          child: _LogoutAction(
            label: t.common.actions.cancel,
            color: scheme.textSecondary,
            background: onSurface.withValues(alpha: 0.05),
            border: onSurface.withValues(alpha: 0.08),
            onTap: () => setState(() => _confirming = false),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _LogoutAction(
            icon: LucideIcons.logOut,
            label: t.common.actions.confirm,
            color: scheme.error,
            background: scheme.error.withValues(alpha: 0.15),
            border: scheme.error.withValues(alpha: 0.3),
            onTap: _signOut,
          ),
        ),
      ],
    );
  }
}

class _LogoutAction extends StatelessWidget {
  const _LogoutAction({
    required this.label,
    required this.color,
    required this.background,
    required this.border,
    required this.onTap,
    this.icon,
  });

  final String label;
  final Color color;
  final Color background;
  final Color border;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 8),
            ],
            Text(label, style: AppText.bodyStrong.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

class _VersionFooter extends StatelessWidget {
  const _VersionFooter();

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    // On the web the safe-area insets come from a measurement the page
    // makes (see `measuredSafeArea`); showing the result here is how we
    // check it on a real phone without a debugger attached.
    final padding = MediaQuery.paddingOf(context);
    final insets = kIsWeb
        ? '\ninsets ${padding.top.round()}/${padding.bottom.round()} · '
              '${webDiagnostics()}'
        : '';
    return Center(
      child: Text(
        '${t.settings.version}$insets',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          height: 1.5,
          color: onSurface.withValues(alpha: kIsWeb ? 0.4 : 0.15),
        ),
      ),
    );
  }
}
