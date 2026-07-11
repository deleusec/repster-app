import 'package:flutter/material.dart';

/// Animation tokens shared by the auth and onboarding screens.
///
/// Harmonizes durations and curves — every transition uses the same "voice":
/// Material easing `(0.4, 0, 0.2, 1)` and two duration tiers, one for
/// micro-interaction feedback (`feedback`) and one for state changes
/// (`swap` × 2 for exit/enter).
class AuthMotion {
  const AuthMotion._();

  /// Standard Material curve — gentle acceleration, long deceleration.
  /// Suits both micro-interactions and screen swaps.
  static const Curve curve = Cubic(0.4, 0, 0.2, 1);

  /// For immediate visual feedback: goal selection, filling an OTP slot, step
  /// indicator. Snappy but visible.
  static const Duration feedback = Duration(milliseconds: 180);

  /// For sequential state changes (exit OR enter of an `AuthSwitcher`).
  /// Perceived total ≈ 280 ms for a full swap.
  static const Duration swap = Duration(milliseconds: 140);
}
