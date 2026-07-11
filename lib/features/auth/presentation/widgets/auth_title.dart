import 'package:flutter/material.dart';

import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';

/// Title + subtitle for the auth screens — tight 26 px white heading, 14 px
/// white/40% subtitle. Centered by default (login/forgot/update-password),
/// left-aligned on the onboarding screens.
class AuthTitle extends StatelessWidget {
  const AuthTitle({
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
    this.fontSize = 26,
    this.titleLineHeight,
    super.key,
  });

  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;
  final double fontSize;
  final double? titleLineHeight;

  @override
  Widget build(BuildContext context) {
    final textAlign = switch (alignment) {
      CrossAxisAlignment.start => TextAlign.left,
      CrossAxisAlignment.end => TextAlign.right,
      _ => TextAlign.center,
    };
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          title,
          textAlign: textAlign,
          style: TextStyle(
            color: AuthTokens.textPrimary,
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            height: titleLineHeight,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            textAlign: textAlign,
            style: TextStyle(
              color: AuthTokens.textSubtle,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
