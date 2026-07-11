import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/auth/domain/auth_user_goal.dart';
import 'package:repster/features/auth/presentation/goal_l10n.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/profile/domain/profile_stats.dart';
import 'package:repster/features/profile/presentation/profile_badge_l10n.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/l10n/muscle_group_l10n.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_action_sheet.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';
import 'package:repster/shared/widgets/app_text_field.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/form_error_box.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';
import 'package:repster/shared/widgets/section_label.dart';

/// Accent color associated with a goal.
Color _goalAccent(AuthUserGoal goal, ColorScheme scheme) => switch (goal) {
  AuthUserGoal.strength => AppColors.accentAmber,
  AuthUserGoal.hypertrophy => scheme.primary,
  AuthUserGoal.endurance => AppColors.accentBlue,
  AuthUserGoal.weightLoss => AppColors.accentOrange,
  AuthUserGoal.maintenance => AppColors.accentEmerald,
};

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
        stagger.wrap(_NavBar(onEdit: () => _openEditSheet(context, ref))),
        const SizedBox(height: 20),
        stagger.wrap(_IdentityHero(user: user)),
        const SizedBox(height: 28),
        stagger.wrap(_StatsRow(stats: stats)),
        const SizedBox(height: 24),
        if (stats.favorite != null) ...[
          stagger.wrap(SectionLabel(t.profile.sections.favoriteMuscleGroup)),
          const SizedBox(height: 12),
          stagger.wrap(_FavoriteCard(favorite: stats.favorite!)),
          const SizedBox(height: 24),
        ],
        stagger.wrap(
          SectionLabel(t.profile.sections.badges, icon: LucideIcons.award),
        ),
        const SizedBox(height: 12),
        stagger.wrap(_BadgesSection(badges: stats.badges)),
      ],
    );
  }

  Future<void> _openEditSheet(BuildContext context, WidgetRef ref) {
    return AppDrawerSheet.show<void>(
      context,
      title: t.profile.editSheet.title,
      child: _EditForm(user: user),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({required this.onEdit});

  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      children: [
        _NavButton(icon: LucideIcons.chevronLeft, onTap: () => context.pop()),
        Expanded(
          child: Text(
            t.profile.navTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: onSurface.withValues(alpha: 0.3),
            ),
          ),
        ),
        _NavButton(icon: LucideIcons.pencil, onTap: onEdit),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.controlSm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.controlSm),
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppRadius.controlSm),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: Icon(icon, size: 17, color: onSurface.withValues(alpha: 0.6)),
        ),
      ),
    );
  }
}

class _IdentityHero extends StatelessWidget {
  const _IdentityHero({required this.user});

  final AuthUser user;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final goal = user.goal;
    final name = user.fullName?.trim().isNotEmpty ?? false
        ? user.fullName!.trim()
        : t.profile.defaultName;
    final bio = user.bio?.trim();

    return Column(
      children: [
        _AvatarBlock(user: user),
        const SizedBox(height: 16),
        Text(
          name,
          textAlign: TextAlign.center,
          // Display name — matches the PWA's text-[1.75rem] font-black (28px).
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            height: 1,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          user.email,
          style: TextStyle(
            fontSize: 13,
            color: onSurface.withValues(alpha: 0.35),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            if (goal != null) _GoalPill(goal: goal),
            Text(
              t.profile.since(month: monthLabel(user.joinedAt)),
              style: TextStyle(
                fontSize: 12,
                color: onSurface.withValues(alpha: 0.25),
              ),
            ),
          ],
        ),
        if (bio != null && bio.isNotEmpty) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              bio,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
                color: onSurface.withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _GoalPill extends StatelessWidget {
  const _GoalPill({required this.goal});

  final AuthUserGoal goal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = _goalAccent(goal, scheme);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Text(
        '${goal.emoji} ${goal.localizedLabel}',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: accent,
        ),
      ),
    );
  }
}

class _AvatarBlock extends ConsumerStatefulWidget {
  const _AvatarBlock({required this.user});

  final AuthUser user;

  @override
  ConsumerState<_AvatarBlock> createState() => _AvatarBlockState();
}

class _AvatarBlockState extends ConsumerState<_AvatarBlock> {
  bool _busy = false;

  Future<void> _pick(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? file;
    try {
      file = await picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
    } on Object {
      if (!mounted) return;
      AppToast.showError(context, t.profile.avatar.openError);
      return;
    }
    if (file == null) return;
    final bytes = await file.readAsBytes();
    await _upload(bytes);
  }

  Future<void> _upload(Uint8List bytes) async {
    setState(() => _busy = true);
    try {
      await ref.read(authControllerProvider.notifier).setAvatar(bytes);
      if (!mounted) return;
      AppToast.showSuccess(context, t.profile.avatar.updated);
    } on Object {
      if (!mounted) return;
      AppToast.showError(context, t.profile.avatar.saveError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _remove() async {
    setState(() => _busy = true);
    try {
      await ref.read(authControllerProvider.notifier).removeAvatar();
      if (!mounted) return;
      AppToast.showSuccess(context, t.profile.avatar.removed);
    } on Object {
      if (!mounted) return;
      AppToast.showError(context, t.profile.avatar.removeError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _openMenu() async {
    if (_busy) return;
    final hasAvatar = widget.user.avatarUrl != null;
    final choice = await AppActionSheet.show<_AvatarAction>(
      context,
      title: t.profile.avatar.sheetTitle,
      actions: [
        AppSheetAction(
          value: _AvatarAction.camera,
          label: t.profile.avatar.takePhoto,
          icon: LucideIcons.camera,
        ),
        AppSheetAction(
          value: _AvatarAction.gallery,
          label: t.profile.avatar.gallery,
          icon: LucideIcons.image,
        ),
        if (hasAvatar)
          AppSheetAction(
            value: _AvatarAction.delete,
            label: t.profile.avatar.remove,
            icon: LucideIcons.trash2,
            isDestructive: true,
          ),
      ],
    );
    switch (choice) {
      case _AvatarAction.camera:
        await _pick(ImageSource.camera);
      case _AvatarAction.gallery:
        await _pick(ImageSource.gallery);
      case _AvatarAction.delete:
        await _remove();
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final avatarUrl = widget.user.avatarUrl;
    return GestureDetector(
      onTap: _openMenu,
      child: SizedBox(
        width: 96,
        height: 96,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 96,
              height: 96,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xxl),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [scheme.primary, const Color(0xFF7F1D1D)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: scheme.primary.withValues(alpha: 0.35),
                    blurRadius: 28,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: avatarUrl != null
                  ? Image.network(
                      avatarUrl,
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _initial(),
                    )
                  : _initial(),
            ),
            if (_busy)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(AppRadius.xxl),
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            else
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: scheme.surface, width: 2),
                  ),
                  child: const Icon(
                    LucideIcons.camera,
                    size: 13,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _initial() {
    final name = widget.user.firstName.trim();
    final char = name.isNotEmpty
        ? name.substring(0, 1)
        : (widget.user.email.isEmpty ? '?' : widget.user.email.substring(0, 1));
    return Text(
      char.toUpperCase(),
      style: const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    );
  }
}

enum _AvatarAction { camera, gallery, delete }

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.stats});

  final ProfileStats stats;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final divider = scheme.hairline;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: scheme.translucentCard,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _StatCell(
                icon: LucideIcons.dumbbell,
                tint: scheme.primary,
                label: t.profile.stats.sessions,
                value: '${stats.sessionCount}',
              ),
            ),
            Container(width: 1, color: divider),
            Expanded(
              child: _StatCell(
                icon: LucideIcons.trendingUp,
                tint: AppColors.accentEmerald,
                label: t.profile.stats.tonnage,
                value: formatTonnage(stats.totalTonnageKg),
              ),
            ),
            Container(width: 1, color: divider),
            Expanded(
              child: _StatCell(
                icon: LucideIcons.flame,
                tint: AppColors.accentAmber,
                label: t.profile.stats.sets,
                value: '${stats.totalSets}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.tint,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color tint;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 13, color: tint),
            const SizedBox(width: 5),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: onSurface.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            height: 1,
            color: onSurface,
          ),
        ),
      ],
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  const _FavoriteCard({required this.favorite});

  final FavoriteMuscleGroup favorite;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final accent = favorite.group.accent;
    final count = favorite.sessionCount;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: accent.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${favorite.group.emoji} ${favorite.group.localizedLabel}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: accent,
              ),
            ),
          ),
          Text(
            t.profile.sessionCount(n: count),
            style: TextStyle(
              fontSize: 12,
              color: onSurface.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgesSection extends StatelessWidget {
  const _BadgesSection({required this.badges});

  final List<ProfileBadgeKind> badges;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (badges.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: scheme.primary.withValues(alpha: 0.15)),
        ),
        child: Text(
          t.profile.badges.empty,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: scheme.onSurface.withValues(alpha: 0.35),
          ),
        ),
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [for (final b in badges) _BadgeChip(badge: b)],
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.badge});

  final ProfileBadgeKind badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: scheme.translucentTile,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(badge.emoji, style: const TextStyle(fontSize: 16, height: 1)),
          const SizedBox(width: 8),
          Text(
            badge.localizedLabel,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditForm extends ConsumerStatefulWidget {
  const _EditForm({required this.user});
  final AuthUser user;

  @override
  ConsumerState<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends ConsumerState<_EditForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtl;
  late final TextEditingController _bioCtl;
  late final TextEditingController _heightCtl;
  late final TextEditingController _weightCtl;
  DateTime? _birthdate;
  AuthUserGoal? _goal;
  bool _saving = false;
  String? _globalError;

  @override
  void initState() {
    super.initState();
    final u = widget.user;
    _nameCtl = TextEditingController(text: u.fullName ?? '');
    _bioCtl = TextEditingController(text: u.bio ?? '');
    _heightCtl = TextEditingController(
      text: u.heightCm == null ? '' : u.heightCm.toString(),
    );
    _weightCtl = TextEditingController(
      text: u.weightKg == null ? '' : u.weightKg.toString(),
    );
    _birthdate = u.birthdate;
    _goal = u.goal;
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _bioCtl.dispose();
    _heightCtl.dispose();
    _weightCtl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthdate ?? DateTime(now.year - 25),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) setState(() => _birthdate = picked);
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _saving = true;
      _globalError = null;
    });
    try {
      final trimmed = _nameCtl.text.trim();
      await ref
          .read(authControllerProvider.notifier)
          .updateProfile(
            fullName: trimmed.isEmpty ? null : trimmed,
            bio: _bioCtl.text.trim(),
            heightCm: double.tryParse(_heightCtl.text.replaceAll(',', '.')),
            weightKg: double.tryParse(_weightCtl.text.replaceAll(',', '.')),
            birthdate: _birthdate,
            goal: _goal,
          );
      if (!mounted) return;
      await Navigator.of(context).maybePop();
      if (!mounted) return;
      AppToast.showSuccess(context, t.profile.editForm.saved);
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _globalError = humanizeAppError(e));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String? _validateName(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return null; // Optional.
    if (s.length < 2) return t.profile.editForm.validation.nameMin;
    if (s.length > 60) return t.profile.editForm.validation.nameMax;
    return null;
  }

  String? _validateHeight(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return null;
    final n = double.tryParse(s.replaceAll(',', '.'));
    if (n == null) return t.profile.editForm.validation.invalidNumber;
    if (n < 80 || n > 260) return t.profile.editForm.validation.heightRange;
    return null;
  }

  String? _validateWeight(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return null;
    final n = double.tryParse(s.replaceAll(',', '.'));
    if (n == null) return t.profile.editForm.validation.invalidNumber;
    if (n < 30 || n > 350) return t.profile.editForm.validation.weightRange;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dateLabel = _birthdate == null
        ? t.profile.editForm.pickDate
        : DateFormat('d MMMM yyyy').format(_birthdate!);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionLabel(t.profile.editForm.sections.identity),
            const SizedBox(height: 10),
            AppTextField(
              controller: _nameCtl,
              label: t.profile.editForm.fields.name,
              validator: _validateName,
            ),
            const SizedBox(height: 10),
            AppTextField(
              controller: _bioCtl,
              label: t.profile.editForm.fields.bio,
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            Text(
              t.profile.editForm.fields.birthdate,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: scheme.controlSurface,
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.calendar,
                      size: 18,
                      color: scheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 10),
                    Text(dateLabel),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            SectionLabel(t.profile.editForm.sections.physique),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _weightCtl,
                    label: t.profile.editForm.fields.weight,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: _validateWeight,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppTextField(
                    controller: _heightCtl,
                    label: t.profile.editForm.fields.height,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: _validateHeight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            SectionLabel(t.profile.editForm.sections.goal),
            const SizedBox(height: 10),
            _GoalGrid(
              selected: _goal,
              onSelect: (g) => setState(() => _goal = _goal == g ? null : g),
            ),
            if (_globalError != null) ...[
              const SizedBox(height: 14),
              FormErrorBox(message: _globalError!),
            ],
            const SizedBox(height: 20),
            AppButton(
              label: t.common.actions.save,
              onPressed: _saving ? null : _save,
              loading: _saving,
              expand: true,
              size: AppButtonSize.lg,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _GoalGrid extends StatelessWidget {
  const _GoalGrid({required this.selected, required this.onSelect});

  final AuthUserGoal? selected;
  final ValueChanged<AuthUserGoal> onSelect;

  @override
  Widget build(BuildContext context) {
    const goals = AuthUserGoal.values;
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 8.0;
        final fullWidth = constraints.maxWidth;
        final halfWidth = (fullWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var i = 0; i < goals.length; i++)
              SizedBox(
                // Last element alone on its row -> full width.
                width: (i == goals.length - 1 && goals.length.isOdd)
                    ? fullWidth
                    : halfWidth,
                child: _GoalTile(
                  goal: goals[i],
                  selected: selected == goals[i],
                  onTap: () => onSelect(goals[i]),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _GoalTile extends StatelessWidget {
  const _GoalTile({
    required this.goal,
    required this.selected,
    required this.onTap,
  });

  final AuthUserGoal goal;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primary.withValues(alpha: 0.12)
                : onSurface.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: selected
                  ? scheme.primary.withValues(alpha: 0.40)
                  : onSurface.withValues(alpha: 0.07),
            ),
          ),
          child: Row(
            children: [
              Text(goal.emoji, style: const TextStyle(fontSize: 20, height: 1)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  goal.localizedLabel,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? onSurface
                        : onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ),
              if (selected)
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
