import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user_goal.dart';
import 'package:repster/features/auth/presentation/goal_l10n.dart';
import 'package:repster/features/auth/presentation/widgets/auth_error_box.dart';
import 'package:repster/features/auth/presentation/widgets/auth_input.dart';
import 'package:repster/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:repster/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:repster/features/auth/presentation/widgets/auth_switcher.dart';
import 'package:repster/features/auth/presentation/widgets/auth_text_link.dart';
import 'package:repster/features/auth/presentation/widgets/auth_title.dart';
import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';
import 'package:repster/features/auth/presentation/widgets/goal_card_button.dart';
import 'package:repster/features/auth/presentation/widgets/step_dots.dart';
import 'package:repster/i18n/translations.g.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const _totalSteps = 3;

  final _nameCtl = TextEditingController();
  final _weightCtl = TextEditingController();
  final _heightCtl = TextEditingController();
  DateTime? _birthdate;
  AuthUserGoal? _goal;

  int _step = 1;
  String? _nameError;
  String? _goalError;
  String? _weightError;
  String? _heightError;
  String? _globalError;
  bool _loading = false;

  @override
  void dispose() {
    _nameCtl.dispose();
    _weightCtl.dispose();
    _heightCtl.dispose();
    super.dispose();
  }

  void _go(int next) {
    setState(() {
      _step = next;
      _nameError = null;
      _goalError = null;
      _weightError = null;
      _heightError = null;
      _globalError = null;
    });
  }

  void _onStep1() {
    final name = _nameCtl.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = t.auth.onboarding.nameRequired);
      return;
    }
    if (name.length > 60) {
      setState(() => _nameError = t.auth.onboarding.nameTooLong);
      return;
    }
    _go(2);
  }

  void _onStep2() {
    if (_goal == null) {
      setState(() => _goalError = t.auth.onboarding.goalRequired);
      return;
    }
    _go(3);
  }

  Future<void> _onStep3({bool skipExtra = false}) async {
    if (_goal == null) return;
    double? weight;
    double? height;
    if (!skipExtra) {
      final w = _weightCtl.text.trim();
      final h = _heightCtl.text.trim();
      if (w.isNotEmpty) {
        weight = double.tryParse(w.replaceAll(',', '.'));
        if (weight == null || weight <= 0 || weight > 500) {
          setState(() => _weightError = t.auth.onboarding.weightInvalid);
          return;
        }
      }
      if (h.isNotEmpty) {
        height = double.tryParse(h.replaceAll(',', '.'));
        if (height == null || height <= 0 || height > 300) {
          setState(() => _heightError = t.auth.onboarding.heightInvalid);
          return;
        }
      }
    }
    setState(() {
      _loading = true;
      _globalError = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .updateProfile(
            fullName: _nameCtl.text.trim(),
            heightCm: height,
            weightKg: weight,
            birthdate: skipExtra ? null : _birthdate,
            goal: _goal,
          );
      // The router redirects to /dashboard automatically.
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _globalError = humanizeAppError(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _pickBirthdate() async {
    final now = DateTime.now();
    final initial = _birthdate ?? DateTime(now.year - 25, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: t.auth.onboarding.birthdate,
    );
    if (picked != null) setState(() => _birthdate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBottomGlow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          StepDots(totalSteps: _totalSteps, currentStep: _step),
          const SizedBox(height: 36),
          AuthSwitcher(
            child: KeyedSubtree(
              key: ValueKey(_step),
              child: switch (_step) {
                1 => _buildStep1(),
                2 => _buildStep2(),
                _ => _buildStep3(),
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTitle(
          title: t.auth.onboarding.step1Title,
          subtitle: t.auth.onboarding.step1Subtitle,
          alignment: CrossAxisAlignment.start,
          fontSize: 30,
          titleLineHeight: 1.15,
        ),
        const SizedBox(height: 28),
        AuthInput(
          controller: _nameCtl,
          hint: t.auth.onboarding.nameHint,
          prefixIcon: LucideIcons.user,
          autofocus: true,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.givenName],
          errorText: _nameError,
          onChanged: (_) {
            if (_nameError != null) setState(() => _nameError = null);
          },
          onSubmitted: (_) => _onStep1(),
        ),
        const SizedBox(height: 28),
        AuthPrimaryButton(
          label: t.auth.onboarding.continueLabel,
          onPressed: _onStep1,
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTitle(
          title: t.auth.onboarding.step2Title,
          subtitle: t.auth.onboarding.step2Subtitle,
          alignment: CrossAxisAlignment.start,
          fontSize: 30,
          titleLineHeight: 1.15,
        ),
        const SizedBox(height: 24),
        _GoalGrid(
          selected: _goal,
          onSelect: (g) {
            setState(() {
              _goal = g;
              _goalError = null;
            });
          },
        ),
        if (_goalError != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              _goalError!,
              style: const TextStyle(fontSize: 12, color: Color(0xFFF87171)),
            ),
          ),
        ],
        const SizedBox(height: 22),
        AuthPrimaryButton(
          label: t.auth.onboarding.continueLabel,
          onPressed: _onStep2,
        ),
        const SizedBox(height: 6),
        Center(
          child: AuthTextLink(
            label: t.common.actions.back,
            icon: LucideIcons.chevronLeft,
            onPressed: () => _go(1),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    final dateLabel = _birthdate == null
        ? t.auth.onboarding.birthdate
        : DateFormat('d MMMM yyyy', 'fr_FR').format(_birthdate!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Flexible(
              child: AuthTitle(
                title: t.auth.onboarding.step3Title,
                alignment: CrossAxisAlignment.start,
                fontSize: 30,
                titleLineHeight: 1.15,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AuthTokens.cardBg,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AuthTokens.cardBg),
              ),
              child: Text(
                t.auth.onboarding.optional,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AuthTokens.textPlaceholder,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          t.auth.onboarding.step3Subtitle,
          style: TextStyle(
            fontSize: 14,
            color: AuthTokens.textSubtle,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        AuthInput(
          controller: _weightCtl,
          hint: t.auth.onboarding.weightHint,
          prefixIcon: LucideIcons.weight,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          errorText: _weightError,
          onChanged: (_) {
            if (_weightError != null) setState(() => _weightError = null);
          },
        ),
        const SizedBox(height: 12),
        AuthInput(
          controller: _heightCtl,
          hint: t.auth.onboarding.heightHint,
          prefixIcon: LucideIcons.ruler,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          errorText: _heightError,
          onChanged: (_) {
            if (_heightError != null) setState(() => _heightError = null);
          },
        ),
        const SizedBox(height: 12),
        _BirthdatePickerField(
          value: _birthdate,
          label: dateLabel,
          onTap: _pickBirthdate,
        ),
        if (_globalError != null) ...[
          const SizedBox(height: 12),
          AuthErrorBox(message: _globalError!),
        ],
        const SizedBox(height: 22),
        AuthPrimaryButton(
          label: _loading
              ? t.auth.onboarding.submitLoading
              : t.auth.onboarding.submit,
          loading: _loading,
          onPressed: _loading ? null : _onStep3,
        ),
        const SizedBox(height: 6),
        Center(
          child: AuthTextLink(
            label: t.auth.onboarding.skip,
            onPressed: _loading ? null : () => _onStep3(skipExtra: true),
          ),
        ),
      ],
    );
  }
}

class _GoalGrid extends StatelessWidget {
  const _GoalGrid({required this.selected, required this.onSelect});

  final AuthUserGoal? selected;
  final ValueChanged<AuthUserGoal> onSelect;

  @override
  Widget build(BuildContext context) {
    final entries = <_GoalEntry>[
      _GoalEntry(
        AuthUserGoal.hypertrophy,
        t.auth.onboarding.goalDescriptions.hypertrophy,
        LucideIcons.dumbbell,
      ),
      _GoalEntry(
        AuthUserGoal.strength,
        t.auth.onboarding.goalDescriptions.strength,
        LucideIcons.zap,
      ),
      _GoalEntry(
        AuthUserGoal.endurance,
        t.auth.onboarding.goalDescriptions.endurance,
        LucideIcons.footprints,
      ),
      _GoalEntry(
        AuthUserGoal.weightLoss,
        t.auth.onboarding.goalDescriptions.weightLoss,
        LucideIcons.flame,
      ),
    ];
    return Column(
      children: [
        // First four goals in a two-column grid.
        for (var i = 0; i < entries.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: GoalCardButton(
                    label: entries[i].value.localizedLabel,
                    description: entries[i].description,
                    icon: entries[i].icon,
                    selected: selected == entries[i].value,
                    onTap: () => onSelect(entries[i].value),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GoalCardButton(
                    label: entries[i + 1].value.localizedLabel,
                    description: entries[i + 1].description,
                    icon: entries[i + 1].icon,
                    selected: selected == entries[i + 1].value,
                    onTap: () => onSelect(entries[i + 1].value),
                  ),
                ),
              ],
            ),
          ),
        // Maintenance — full width, horizontal layout.
        GoalCardButton(
          label: AuthUserGoal.maintenance.localizedLabel,
          description: t.auth.onboarding.goalDescriptions.maintenance,
          icon: LucideIcons.heart,
          horizontal: true,
          selected: selected == AuthUserGoal.maintenance,
          onTap: () => onSelect(AuthUserGoal.maintenance),
        ),
      ],
    );
  }
}

class _GoalEntry {
  const _GoalEntry(this.value, this.description, this.icon);
  final AuthUserGoal value;
  final String description;
  final IconData icon;
}

class _BirthdatePickerField extends StatelessWidget {
  const _BirthdatePickerField({
    required this.value,
    required this.label,
    required this.onTap,
  });

  final DateTime? value;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AuthTokens.cardBg,
      borderRadius: BorderRadius.circular(AuthTokens.radiusXl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AuthTokens.radiusXl),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AuthTokens.radiusXl),
            border: Border.all(color: AuthTokens.cardBorder),
          ),
          child: Row(
            children: [
              Icon(LucideIcons.cake, size: 18, color: AuthTokens.iconMuted),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: value == null
                      ? AuthTokens.textHint
                      : AuthTokens.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
