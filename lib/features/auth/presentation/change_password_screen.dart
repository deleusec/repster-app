import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/presentation/auth_validators.dart';
import 'package:repster/features/auth/presentation/widgets/auth_error_box.dart';
import 'package:repster/features/auth/presentation/widgets/auth_input.dart';
import 'package:repster/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';

/// Password change for a signed-in user, opened from the settings. Reuses the
/// auth components ([AuthInput], validators, [AuthErrorBox],
/// [AuthPrimaryButton]) inside the sub-page chrome (glow + nav bar). The
/// current password is verified by Supabase re-authentication (see
/// `AuthRepository.changePassword`).
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _currentCtl = TextEditingController();
  final _newCtl = TextEditingController();
  final _confirmCtl = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;
  bool _submitting = false;

  String? _currentError;
  String? _newError;
  String? _confirmError;
  String? _globalError;

  @override
  void dispose() {
    _currentCtl.dispose();
    _newCtl.dispose();
    _confirmCtl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final current = _currentCtl.text;
    final newPwd = _newCtl.text;

    final currentErr = current.isEmpty
        ? t.auth.changePassword.currentRequired
        : null;
    var newErr = validatePassword(newPwd);
    if (newErr == null && newPwd == current) {
      newErr = t.auth.changePassword.mustDiffer;
    }
    final confirmErr = validatePasswordConfirm(_confirmCtl.text, newPwd);

    setState(() {
      _currentError = currentErr;
      _newError = newErr;
      _confirmError = confirmErr;
      _globalError = null;
    });
    if (currentErr != null || newErr != null || confirmErr != null) return;

    setState(() => _submitting = true);
    try {
      await ref
          .read(authControllerProvider.notifier)
          .changePassword(currentPassword: current, newPassword: newPwd);
      if (!mounted) return;
      AppToast.showSuccess(context, t.auth.changePassword.successToast);
      context.pop();
    } on AppAuthException catch (e) {
      if (!mounted) return;
      // Re-authentication failure → current password is wrong.
      if (e.reason == AuthFailureReason.invalidCredentials) {
        setState(() => _currentError = t.auth.changePassword.currentIncorrect);
      } else {
        setState(() => _globalError = humanizeAppError(e));
      }
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _globalError = humanizeAppError(e));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GlowScaffold(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 40),
        children: [
          _NavBar(onBack: () => context.pop()),
          const SizedBox(height: 28),
          Text(
            t.auth.changePassword.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.auth.changePassword.subtitle,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: scheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: 28),

          AuthInput(
            controller: _currentCtl,
            hint: t.auth.changePassword.currentHint,
            prefixIcon: LucideIcons.lock,
            suffixIcon: _showCurrent ? LucideIcons.eyeOff : LucideIcons.eye,
            onSuffixTap: () => setState(() => _showCurrent = !_showCurrent),
            obscureText: !_showCurrent,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            autofillHints: const [AutofillHints.password],
            errorText: _currentError,
            onChanged: (_) {
              if (_currentError != null) setState(() => _currentError = null);
            },
          ),
          const SizedBox(height: 12),
          AuthInput(
            controller: _newCtl,
            hint: t.auth.changePassword.newHint,
            prefixIcon: LucideIcons.lockKeyhole,
            suffixIcon: _showNew ? LucideIcons.eyeOff : LucideIcons.eye,
            onSuffixTap: () => setState(() => _showNew = !_showNew),
            obscureText: !_showNew,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            autofillHints: const [AutofillHints.newPassword],
            errorText: _newError,
            onChanged: (_) {
              if (_newError != null) setState(() => _newError = null);
            },
          ),
          const SizedBox(height: 12),
          AuthInput(
            controller: _confirmCtl,
            hint: t.auth.changePassword.confirmHint,
            prefixIcon: LucideIcons.lockKeyhole,
            suffixIcon: _showConfirm ? LucideIcons.eyeOff : LucideIcons.eye,
            onSuffixTap: () => setState(() => _showConfirm = !_showConfirm),
            obscureText: !_showConfirm,
            textInputAction: TextInputAction.done,
            autocorrect: false,
            autofillHints: const [AutofillHints.newPassword],
            errorText: _confirmError,
            onChanged: (_) {
              if (_confirmError != null) setState(() => _confirmError = null);
            },
            onSubmitted: (_) => _submit(),
          ),

          if (_globalError != null) ...[
            const SizedBox(height: 16),
            AuthErrorBox(message: _globalError!),
          ],

          const SizedBox(height: 24),
          AuthPrimaryButton(
            label: _submitting
                ? t.auth.changePassword.submitLoading
                : t.auth.changePassword.submit,
            loading: _submitting,
            onPressed: _submitting ? null : _submit,
          ),
        ],
      ),
    );
  }
}

// Nav bar (same pattern as profile / contact).

class _NavBar extends StatelessWidget {
  const _NavBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: _NavButton(icon: LucideIcons.chevronLeft, onTap: onBack),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
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
