import 'package:flutter/material.dart';

import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';

/// Full-width primary button for the auth screens (48 px tall, rounded-2xl,
/// primary color).
class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    required this.label,
    required this.onPressed,
    this.loading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDisabled = onPressed == null || loading;
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Material(
        color: scheme.primary.withValues(alpha: isDisabled ? 0.4 : 1.0),
        borderRadius: BorderRadius.circular(AuthTokens.radiusXl),
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(AuthTokens.radiusXl),
          child: Center(
            child: loading
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: scheme.onPrimary,
                    ),
                  )
                : Text(
                    label,
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.1,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
