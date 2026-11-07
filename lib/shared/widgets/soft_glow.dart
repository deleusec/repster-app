import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Soft light glow, stacked behind backgrounds and inside "hero" cards.
///
/// Place inside a [Stack] (usually via [Positioned]). Ignores pointers. The
/// widget's box is [size] × [size]; the light itself extends past it by about
/// two [blur] radii, the way a Gaussian-blurred disc would.
///
/// Painted as a radial gradient, not as a blurred circle: a real blur of a
/// 500 px disc is the single most expensive thing a page can draw (on web and
/// Android alike), and every main screen has two of them behind its list. A
/// gradient with a bell-shaped falloff is indistinguishable at these alphas
/// and costs nothing.
class SoftGlow extends StatelessWidget {
  const SoftGlow({
    required this.color,
    required this.size,
    this.blur = 60,
    super.key,
  });

  final Color color;
  final double size;

  /// How far the light spreads past the disc, in logical pixels — the sigma
  /// the old blur used, so callers keep their numbers.
  final double blur;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _GlowPainter(color: color, radius: size / 2, blur: blur),
        ),
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  const _GlowPainter({
    required this.color,
    required this.radius,
    required this.blur,
  });

  final Color color;
  final double radius;
  final double blur;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // A blurred disc keeps its full value up to ~2σ inside its edge and dies
    // out ~2σ past it; between the two the profile is a smooth S.
    final reach = radius + 2 * blur;
    final plateau = ((radius - 2 * blur) / reach).clamp(0.0, 0.95);
    final stops = <double>[0, plateau];
    final colors = <Color>[color, color];
    const ramp = [0.25, 0.5, 0.75, 1.0];
    for (final t in ramp) {
      stops.add(plateau + (1 - plateau) * t);
      colors.add(color.withValues(alpha: color.a * (1 - t) * (1 - t)));
    }
    final paint = Paint()
      ..shader = ui.Gradient.radial(center, reach, colors, stops);
    canvas.drawCircle(center, reach, paint);
  }

  @override
  bool shouldRepaint(_GlowPainter old) =>
      old.color != color || old.radius != radius || old.blur != blur;
}
