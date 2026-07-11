import 'package:flutter/material.dart';

import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';

/// Global error banner for the auth forms.
class AuthErrorBox extends StatelessWidget {
  const AuthErrorBox({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AuthTokens.dangerBg,
        borderRadius: BorderRadius.circular(AuthTokens.radiusLg),
        border: Border.all(color: AuthTokens.dangerBorder),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: AuthTokens.danger,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
