import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/core/router/routes.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/presentation/widgets/auth_brand.dart';
import 'package:repster/features/auth/presentation/widgets/auth_error_box.dart';
import 'package:repster/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:repster/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:repster/features/auth/presentation/widgets/auth_text_link.dart';
import 'package:repster/features/auth/presentation/widgets/auth_title.dart';
import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';
import 'package:repster/features/auth/presentation/widgets/otp_field.dart';
import 'package:repster/i18n/translations.g.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({this.email, super.key});

  final String? email;

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  String _otp = '';
  bool _submitting = false;
  bool _resending = false;
  int _resendCooldown = 0;
  String? _resendSuccess;
  String? _tokenError;
  Timer? _cooldownTimer;
  Timer? _autoSubmitTimer;

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    _autoSubmitTimer?.cancel();
    super.dispose();
  }

  String _maskedEmail() {
    final email = widget.email?.trim() ?? '';
    if (email.isEmpty) return '';
    final atIdx = email.indexOf('@');
    if (atIdx < 0) return email;
    final start = email.substring(0, atIdx > 2 ? 2 : atIdx);
    final middle = '•' * (atIdx - 2).clamp(0, 4);
    return '$start$middle${email.substring(atIdx)}';
  }

  void _onOtpChanged(String value) {
    _autoSubmitTimer?.cancel();
    setState(() {
      _otp = value;
      _tokenError = null;
    });
    if (value.length == 6) {
      _autoSubmitTimer = Timer(const Duration(milliseconds: 300), _submit);
    }
  }

  Future<void> _submit() async {
    final email = widget.email?.trim();
    if (email == null || email.isEmpty) {
      setState(() => _tokenError = t.auth.verifyEmail.emailMissing);
      return;
    }
    if (_otp.length != 6) return;
    setState(() {
      _submitting = true;
      _tokenError = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .verifyEmailOtp(email: email, token: _otp);
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _tokenError = humanizeAppError(e));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _resend() async {
    final email = widget.email?.trim();
    if (email == null || email.isEmpty) return;
    setState(() {
      _resending = true;
      _resendSuccess = null;
      _tokenError = null;
    });
    try {
      await ref.read(authControllerProvider.notifier).resendSignupOtp(email);
      if (!mounted) return;
      setState(() {
        _resendSuccess = t.auth.verifyEmail.resent;
        _resendCooldown = 60;
      });
      _startCooldown();
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _tokenError = humanizeAppError(e));
    } finally {
      if (mounted) setState(() => _resending = false);
    }
  }

  void _startCooldown() {
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _resendCooldown -= 1);
      if (_resendCooldown <= 0) _cooldownTimer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final masked = _maskedEmail();
    final isComplete = _otp.length == 6;
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(child: AuthBrand()),
          const SizedBox(height: 18),
          AuthTitle(
            title: t.auth.verifyEmail.title,
            subtitle: t.auth.verifyEmail.subtitle,
          ),
          if (masked.isNotEmpty) ...[
            const SizedBox(height: 14),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AuthTokens.cardBg,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AuthTokens.cardBg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.mail, size: 14, color: scheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      masked,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AuthTokens.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 28),
          OtpField(
            value: _otp,
            error: _tokenError != null,
            enabled: !_submitting,
            onChanged: _onOtpChanged,
          ),
          if (_tokenError != null) ...[
            const SizedBox(height: 12),
            AuthErrorBox(message: _tokenError!),
          ],
          const SizedBox(height: 18),
          AuthPrimaryButton(
            label: _submitting
                ? t.auth.verifyEmail.submitLoading
                : isComplete
                ? t.auth.verifyEmail.submitComplete
                : t.auth.verifyEmail.submitIncomplete,
            loading: _submitting,
            onPressed: _submitting || !isComplete ? null : _submit,
          ),
          const SizedBox(height: 22),
          Center(
            child: Text(
              t.auth.verifyEmail.noCode,
              style: TextStyle(fontSize: 12, color: AuthTokens.textPlaceholder),
            ),
          ),
          if (_resendSuccess != null && _resendCooldown > 0)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Center(
                child: Text(
                  _resendSuccess!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AuthTokens.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 4),
          Center(
            child: AuthTextLink(
              label: _resendCooldown > 0
                  ? t.auth.verifyEmail.resendCooldown(n: _resendCooldown)
                  : _resending
                  ? t.auth.verifyEmail.resending
                  : t.auth.verifyEmail.resend,
              tone: _resendCooldown > 0
                  ? AuthLinkTone.muted
                  : AuthLinkTone.accent,
              fontSize: 14,
              onPressed: _resending || _resendCooldown > 0 ? null : _resend,
            ),
          ),
          const SizedBox(height: 12),
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
