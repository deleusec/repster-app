import 'dart:ui';

import 'package:flutter/material.dart';

/// Background blur intensity for "glass" surfaces (sheets + dialogs).
const double kGlassBlurSigma = 24;

/// Standard scrim behind a glass surface (bottom sheet / dialog).
const double kGlassScrimAlpha = 0.55;

/// Shared "glass" style tokens — a single source of truth for the translucent
/// tint and hairline, reused by sheets and dialogs.
extension GlassTokens on ColorScheme {
  /// Translucent panel tint (`card` color at 72%) — kept clearly see-through so
  /// the blurred content behind still reads, matching the toast / full-screen
  /// overlays (`surface @ 0.7–0.85`) instead of an almost-opaque slab.
  Color get glassFill => surfaceContainer.withValues(alpha: 0.72);

  /// Outline hairline of glass panels.
  Color get glassHairline => onSurface.withValues(alpha: 0.08);
}

/// "Glass" panel: background blur + translucent tint + hairline, with an
/// arbitrary [borderRadius]. Shared base for bottom sheets
/// (`GlassSheetSurface`) and centered dialogs (`AppDialog`).
class GlassSurface extends StatelessWidget {
  const GlassSurface({
    required this.child,
    required this.borderRadius,
    this.hairline = true,
    super.key,
  });

  final Widget child;
  final BorderRadius borderRadius;
  final bool hairline;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: kGlassBlurSigma,
          sigmaY: kGlassBlurSigma,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.glassFill,
            borderRadius: borderRadius,
            border: hairline ? Border.all(color: scheme.glassHairline) : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
