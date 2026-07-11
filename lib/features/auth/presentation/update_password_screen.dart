import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/core/router/routes.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/application/password_recovery_provider.dart';
import 'package:repster/features/auth/presentation/auth_validators.dart';
import 'package:repster/features/auth/presentation/widgets/auth_brand.dart';
import 'package:repster/features/auth/presentation/widgets/auth_error_box.dart';
import 'package:repster/features/auth/presentation/widgets/auth_input.dart';
import 'package:repster/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:repster/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:repster/features/auth/presentation/widgets/auth_title.dart';
import 'package:repster/i18n/translations.g.dart';

class UpdatePasswordScreen extends ConsumerStatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  ConsumerState<UpdatePasswordScreen> createState() =>
      _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends ConsumerState<UpdatePasswordScreen> {
  final _passwordCtl = TextEditingController();
  final _confirmCtl = TextEditingController();
  bool _showPassword = false;
  bool _showConfirm = false;
  bool _submitting = false;
  String? _passwordError;
  String? _confirmError;
  String? _globalError;

  @override
  void dispose() {
    _passwordCtl.dispose();
    _confirmCtl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final pwd = _passwordCtl.text;
    final pwdErr = validatePassword(pwd);
    final confirmErr = validatePasswordConfirm(_confirmCtl.text, pwd);
    setState(() {
      _passwordError = pwdErr;
      _confirmError = confirmErr;
    });
    if (pwdErr != null || confirmErr != null) return;
    setState(() {
      _submitting = true;
      _globalError = null;
    });
    try {
      await ref.read(authControllerProvider.notifier).updatePassword(pwd);
      // Recovery done — lift the guard so navigation is no longer pinned here.
      ref.read(passwordRecoveryProvider.notifier).state = false;
      if (!mounted) return;
      context.go(Routes.dashboard);
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _globalError = humanizeAppError(e));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(child: AuthBrand()),
          const SizedBox(height: 16),
          AuthTitle(
            title: t.auth.updatePassword.title,
            subtitle: t.auth.updatePassword.subtitle,
          ),
          const SizedBox(height: 28),
          AuthInput(
            controller: _passwordCtl,
            hint: t.auth.updatePassword.newHint,
            prefixIcon: LucideIcons.lock,
            suffixIcon: _showPassword ? LucideIcons.eyeOff : LucideIcons.eye,
            onSuffixTap: () => setState(() => _showPassword = !_showPassword),
            obscureText: !_showPassword,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            autofillHints: const [AutofillHints.newPassword],
            errorText: _passwordError,
            onChanged: (_) {
              if (_passwordError != null) setState(() => _passwordError = null);
            },
          ),
          const SizedBox(height: 12),
          AuthInput(
            controller: _confirmCtl,
            hint: t.auth.updatePassword.confirmHint,
            prefixIcon: LucideIcons.lock,
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
            const SizedBox(height: 12),
            AuthErrorBox(message: _globalError!),
          ],
          const SizedBox(height: 22),
          AuthPrimaryButton(
            label: _submitting
                ? t.auth.updatePassword.submitLoading
                : t.auth.updatePassword.submit,
            loading: _submitting,
            onPressed: _submitting ? null : _submit,
          ),
        ],
      ),
    );
  }
}
