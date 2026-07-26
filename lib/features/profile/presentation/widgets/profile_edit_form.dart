import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/auth/domain/auth_user_goal.dart';
import 'package:repster/features/auth/presentation/goal_l10n.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/app_text_field.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/form_error_box.dart';
import 'package:repster/shared/widgets/section_label.dart';

/// Profile edit sheet: name, bio, body metrics and goal.
class ProfileEditForm extends ConsumerStatefulWidget {
  const ProfileEditForm({required this.user, super.key});
  final AuthUser user;

  @override
  ConsumerState<ProfileEditForm> createState() => _EditFormState();
}

class _EditFormState extends ConsumerState<ProfileEditForm> {
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
