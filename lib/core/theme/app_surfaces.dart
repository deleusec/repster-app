import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';

/// The app's standard translucent surfaces, replicating the PWA's
/// `bg-white/[0.0x]`. Centralizes alphas and radii so each widget doesn't
/// redeclare (and drift on) its own decoration.
extension AppSurfaces on ColorScheme {
  /// Top-level content card: `bg-white/[0.03]`, `0.07` border, `card` radius
  /// (16px).
  BoxDecoration get translucentCard => BoxDecoration(
    color: onSurface.withValues(alpha: 0.03),
    borderRadius: BorderRadius.circular(AppRadius.card),
    border: Border.all(color: onSurface.withValues(alpha: 0.07)),
  );

  /// "Nested tile" variant inside a card: same tint, `control` radius (14px)
  /// to keep the visual hierarchy (smaller than the card).
  BoxDecoration get translucentTile => BoxDecoration(
    color: onSurface.withValues(alpha: 0.03),
    borderRadius: BorderRadius.circular(AppRadius.control),
    border: Border.all(color: onSurface.withValues(alpha: 0.07)),
  );

  /// Tappable field or control: slightly denser (`0.05` / `0.08`), `control`
  /// radius (14px).
  BoxDecoration get controlSurface => BoxDecoration(
    color: onSurface.withValues(alpha: 0.05),
    borderRadius: BorderRadius.circular(AppRadius.control),
    border: Border.all(color: onSurface.withValues(alpha: 0.08)),
  );

  /// Standard separator hairline (`onSurface @ 7%`).
  Color get hairline => onSurface.withValues(alpha: 0.07);
}
