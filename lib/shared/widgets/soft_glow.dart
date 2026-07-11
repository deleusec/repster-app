import 'dart:ui';

import 'package:flutter/material.dart';

/// Blurred light glow, stacked behind backgrounds and inside "hero" cards.
///
/// Place inside a [Stack] (usually via [Positioned]). Ignores pointers.
class SoftGlow extends StatelessWidget {
  const SoftGlow({
    required this.color,
    required this.size,
    this.blur = 60,
    super.key,
  });

  final Color color;
  final double size;

  /// Blur radius in logical pixels.
  final double blur;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
          tileMode: TileMode.decal,
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
      ),
    );
  }
}
