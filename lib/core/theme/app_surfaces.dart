import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';

/// The app's standard translucent surfaces, replicating the PWA's
/// `bg-white/[0.0x]`. Centralizes alphas and radii so each widget doesn't
/// redeclare (and drift on) its own decoration.
///
/// Cards are lit from the top: the fill fades from 5.5 % to 3 % white, so a
/// card reads as a slab catching light rather than a flat grey rectangle.
/// `EdgeLitSurface` goes one step further with a gradient *edge*; this
/// decoration is the lighter variant for the places that only take a
/// [BoxDecoration].
extension AppSurfaces on ColorScheme {
  /// Top-level content card: lit fill, `0.08` border, `card` radius (16px).
  BoxDecoration get translucentCard => BoxDecoration(
    gradient: cardFill,
    borderRadius: BorderRadius.circular(AppRadius.card),
    border: Border.all(color: onSurface.withValues(alpha: 0.08)),
  );

  /// "Nested tile" variant inside a card: flat tint, `control` radius (14px)
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

  /// The lit card fill, top to bottom.
  LinearGradient get cardFill => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      onSurface.withValues(alpha: 0.055),
      onSurface.withValues(alpha: 0.03),
    ],
  );
}
