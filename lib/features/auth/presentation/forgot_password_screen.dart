import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/core/router/routes.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/presentation/auth_validators.dart';
import 'package:repster/features/auth/presentation/widgets/auth_brand.dart';
import 'package:repster/features/auth/presentation/widgets/auth_error_box.dart';
import 'package:repster/features/auth/presentation/widgets/auth_input.dart';
import 'package:repster/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:repster/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:repster/features/auth/presentation/widgets/auth_text_link.dart';
import 'package:repster/features/auth/presentation/widgets/auth_title.dart';
import 'package:repster/i18n/translations.g.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailCtl = TextEditingController();
  bool _submitting = false;
  bool _sent = false;
  String? _emailError;
  String? _globalError;

  @override
  void dispose() {
    _emailCtl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailCtl.text.trim();
    final err = validateEmail(email);
    if (err != null) {
      setState(() => _emailError = err);
      return;
    }
    setState(() {
      _submitting = true;
      _globalError = null;
    });
    try {
      await ref.read(authControllerProvider.notifier).sendPasswordReset(email);
      if (!mounted) return;
      setState(() => _sent = true);
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
            title: t.auth.forgotPassword.title,
            subtitle: t.auth.forgotPassword.subtitle,
          ),
          const SizedBox(height: 28),
          if (_sent)
            _SuccessState(onBack: () => context.go(Routes.login))
          else ...[
            AuthInput(
              controller: _emailCtl,
              hint: t.auth.fields.email,
              prefixIcon: LucideIcons.mail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              autofillHints: const [AutofillHints.email],
              errorText: _emailError,
              onChanged: (_) {
                if (_emailError != null) setState(() => _emailError = null);
              },
              onSubmitted: (_) => _submit(),
            ),
            if (_globalError != null) ...[
              const SizedBox(height: 12),
              AuthErrorBox(message: _globalError!),
            ],
            const SizedBox(height: 18),
            AuthPrimaryButton(
              label: _submitting
                  ? t.auth.forgotPassword.submitLoading
                  : t.auth.forgotPassword.submit,
              loading: _submitting,
              onPressed: _submitting ? null : _submit,
            ),
          ],
          const SizedBox(height: 24),
          Center(
            child: AuthTextLink(
              label: t.auth.backToLogin,
              icon: LucideIcons.chevronLeft,
              onPressed: () => context.go(Routes.login),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF22C55E).withValues(alpha: 0.20),
              ),
            ),
            child: const Icon(
              LucideIcons.check,
              size: 28,
              color: Color(0xFF4ADE80),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          t.auth.forgotPassword.successMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Colors.white.withValues(alpha: 0.60),
          ),
        ),
        const SizedBox(height: 22),
        AuthPrimaryButton(label: t.auth.backToLogin, onPressed: onBack),
      ],
    );
  }
}
