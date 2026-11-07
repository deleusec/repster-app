import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';
import 'package:repster/shared/widgets/pressable.dart';

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
      child: Pressable(
        onTap: isDisabled ? null : onPressed,
        haptic: true,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: isDisabled ? 0.4 : 1.0),
            borderRadius: BorderRadius.circular(AuthTokens.radiusXl),
            boxShadow: isDisabled
                ? null
                : [
                    BoxShadow(
                      color: scheme.glow.withValues(alpha: 0.28),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
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
