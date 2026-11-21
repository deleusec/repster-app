import 'package:flutter/gestures.dart';
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
import 'package:repster/features/auth/presentation/widgets/auth_switcher.dart';
import 'package:repster/features/auth/presentation/widgets/auth_text_link.dart';
import 'package:repster/features/auth/presentation/widgets/auth_title.dart';
import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';
import 'package:repster/features/auth/presentation/widgets/back_chip_button.dart';
import 'package:repster/i18n/translations.g.dart';

enum _AuthMode { login, register }

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtl = TextEditingController();
  final _passwordCtl = TextEditingController();

  _AuthMode _mode = _AuthMode.login;
  bool _showPassword = false;
  bool _submitting = false;
  String? _emailError;
  String? _passwordError;
  String? _globalError;

  @override
  void dispose() {
    _emailCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  void _switchMode(_AuthMode next) {
    if (next == _mode) return;
    setState(() {
      _mode = next;
      _showPassword = false;
      _emailError = null;
      _passwordError = null;
      _globalError = null;
    });
  }

  bool _validate() {
    final emailErr = validateEmail(_emailCtl.text.trim());
    final pwdErr = validatePassword(_passwordCtl.text);
    setState(() {
      _emailError = emailErr;
      _passwordError = pwdErr;
    });
    return emailErr == null && pwdErr == null;
  }

  Future<void> _submit() async {
    if (!_validate()) return;
    setState(() {
      _submitting = true;
      _globalError = null;
    });
    final email = _emailCtl.text.trim();
    final password = _passwordCtl.text;
    try {
      final ctl = ref.read(authControllerProvider.notifier);
      if (_mode == _AuthMode.login) {
        await ctl.signIn(email: email, password: password);
      } else {
        await ctl.signUp(
          email: email,
          password: password,
          language: LocaleSettings.currentLocale.languageCode,
        );
        if (!mounted) return;
        context.go('${Routes.verifyEmail}?email=${Uri.encodeComponent(email)}');
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
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(child: AuthBrand()),
          const SizedBox(height: 36),
          AuthSwitcher(
            child: KeyedSubtree(
              key: ValueKey(_mode),
              child: _mode == _AuthMode.login
                  ? _buildLogin()
                  : _buildRegister(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTitle(
          title: t.auth.login.welcomeTitle,
          subtitle: t.auth.login.welcomeSubtitle,
        ),
        const SizedBox(height: 28),
        _emailField(autofill: const [AutofillHints.email]),
        const SizedBox(height: 14),
        _passwordField(autofill: const [AutofillHints.password]),
        if (_globalError != null) ...[
          const SizedBox(height: 12),
          AuthErrorBox(message: _globalError!),
        ],
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: AuthTextLink(
            label: t.auth.login.forgotPassword,
            onPressed: () => context.push(Routes.forgotPassword),
          ),
        ),
        const SizedBox(height: 12),
        AuthPrimaryButton(
          label: _submitting ? t.auth.login.submitLoading : t.auth.login.submit,
          loading: _submitting,
          onPressed: _submitting ? null : _submit,
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              t.auth.login.noAccount,
              style: TextStyle(fontSize: 14, color: AuthTokens.textPlaceholder),
            ),
            const SizedBox(width: 2),
            AuthTextLink(
              label: t.auth.login.createAccount,
              tone: AuthLinkTone.accent,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              onPressed: () => _switchMode(_AuthMode.register),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegister() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: BackChipButton(
                  onPressed: () => _switchMode(_AuthMode.login),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: AuthTitle(
                title: t.auth.signup.title,
                subtitle: t.auth.signup.subtitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _emailField(autofill: const [AutofillHints.email]),
        const SizedBox(height: 14),
        _passwordField(
          hint: t.auth.signup.passwordHint,
          autofill: const [AutofillHints.newPassword],
        ),
        if (_globalError != null) ...[
          const SizedBox(height: 12),
          AuthErrorBox(message: _globalError!),
        ],
        const SizedBox(height: 20),
        AuthPrimaryButton(
          label: _submitting
              ? t.auth.signup.submitLoading
              : t.auth.signup.submit,
          loading: _submitting,
          onPressed: _submitting ? null : _submit,
        ),
        const SizedBox(height: 16),
        const Center(child: _TermsNotice()),
      ],
    );
  }

  Widget _emailField({required Iterable<String> autofill}) => AuthInput(
    controller: _emailCtl,
    hint: t.auth.fields.email,
    prefixIcon: LucideIcons.mail,
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    autocorrect: false,
    autofillHints: autofill,
    errorText: _emailError,
    onChanged: (_) {
      if (_emailError != null) setState(() => _emailError = null);
    },
  );

  Widget _passwordField({required Iterable<String> autofill, String? hint}) =>
      AuthInput(
        controller: _passwordCtl,
        hint: hint ?? t.auth.fields.password,
        prefixIcon: LucideIcons.lock,
        suffixIcon: _showPassword ? LucideIcons.eyeOff : LucideIcons.eye,
        onSuffixTap: () => setState(() => _showPassword = !_showPassword),
        obscureText: !_showPassword,
        textInputAction: TextInputAction.done,
        autocorrect: false,
        autofillHints: autofill,
        errorText: _passwordError,
        onSubmitted: (_) => _submit(),
        onChanged: (_) {
          if (_passwordError != null) setState(() => _passwordError = null);
        },
      );
}

/// Sign-up disclaimer: the terms of use must be readable *before* the account
/// exists, so the trailing words link to the (public) terms route.
class _TermsNotice extends StatefulWidget {
  const _TermsNotice();

  @override
  State<_TermsNotice> createState() => _TermsNoticeState();
}

class _TermsNoticeState extends State<_TermsNotice> {
  late final TapGestureRecognizer _recognizer = TapGestureRecognizer()
    ..onTap = () => context.push(Routes.terms);

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: t.auth.signup.termsPrefix),
          TextSpan(
            text: t.auth.signup.termsLink,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              decoration: TextDecoration.underline,
              decorationColor: Colors.white.withValues(alpha: 0.30),
            ),
            recognizer: _recognizer,
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11,
        color: Colors.white.withValues(alpha: 0.20),
      ),
    );
  }
}
