import 'package:flutter/material.dart';

import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';

/// Variants of [AuthTextLink].
enum AuthLinkTone {
  /// Muted white/35 link (e.g. "Forgot password?", "Back").
  muted,

  /// Accented `primary` link (e.g. "Create account", "Resend code").
  accent,
}

/// Tappable text link used under the auth forms.
///
/// Wraps an `InkWell` with a real touch target (12 × 10) and soft visual
/// feedback (ripple/splash on the bordered area). Avoids cramped links with
/// too little padding — mobile needs a more generous surface than web hover.
class AuthTextLink extends StatelessWidget {
  const AuthTextLink({
    required this.label,
    required this.onPressed,
    this.icon,
    this.tone = AuthLinkTone.muted,
    this.fontSize = 13,
    this.fontWeight = FontWeight.w600,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;

  /// Optional — shown to the left of the label, 13 px.
  final IconData? icon;
  final AuthLinkTone tone;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (tone) {
      AuthLinkTone.muted => AuthTokens.textPlaceholder,
      AuthLinkTone.accent => scheme.primary,
    };
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AuthTokens.radiusMd),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AuthTokens.radiusMd),
        splashColor: color.withValues(alpha: 0.08),
        highlightColor: color.withValues(alpha: 0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: fontSize, color: color),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  color: color,
                  fontWeight: fontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
