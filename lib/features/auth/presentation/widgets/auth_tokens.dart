import 'package:flutter/material.dart';

/// Design tokens shared by the auth/onboarding screens.
///
/// Centralizes the surface/foreground values to avoid duplicating
/// `Colors.white.withValues(alpha: …)` across widgets.
class AuthTokens {
  const AuthTokens._();

  // Surfaces.
  static final Color cardBg = Colors.white.withValues(alpha: 0.07);
  static final Color cardBgStrong = Colors.white.withValues(alpha: 0.10);
  static final Color cardBorder = Colors.white.withValues(alpha: 0.08);
  static final Color cardBorderStrong = Colors.white.withValues(alpha: 0.10);

  // Foregrounds.
  static const Color textPrimary = Colors.white;
  static final Color textMuted = Colors.white.withValues(alpha: 0.60);
  static final Color textSubtle = Colors.white.withValues(alpha: 0.40);
  static final Color textHint = Colors.white.withValues(alpha: 0.25);
  static final Color textPlaceholder = Colors.white.withValues(alpha: 0.30);
  static final Color iconMuted = Colors.white.withValues(alpha: 0.35);

  // Semantic states.
  static const Color danger = Color(0xFFF87171);
  static const Color dangerBg = Color(0x1AEF4444); // red-500/10
  static const Color dangerBorder = Color(0x2EEF4444); // red-500/18
  static const Color success = Color(0xFF4ADE80);
  static const Color successBg = Color(0x1F22C55E); // green-500/12
  static const Color successBorder = Color(0x3322C55E); // green-500/20

  // Radii.
  /// Radius used everywhere: inputs, cards, auth buttons.
  static const double radiusXl = 18;
  static const double radiusLg = 14;
  static const double radiusMd = 10;
}
