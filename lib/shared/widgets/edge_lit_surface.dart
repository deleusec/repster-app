import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/shared/widgets/pressable.dart';

/// The design system's card: a dark slab lit from above.
///
/// The fill fades from 5.5 % to 3 % white and the 1 px edge from 12 % at the
/// top to 4 % at the bottom, so the card catches light along its upper rim
/// the way brushed metal does, instead of sitting flat under a uniform
/// hairline. An optional [accent] pools a tint of light in the top-right
/// corner — the hero card takes the muscle group's colour there, the only
/// place on a page where the surface itself has a colour.
///
/// Everything is one `CustomPaint`; no blur, no extra layers, so a list of
/// these scrolls as cheaply as plain boxes.
class EdgeLitSurface extends StatelessWidget {
  const EdgeLitSurface({
    required this.child,
    this.radius = AppRadius.card,
    this.padding = EdgeInsets.zero,
    this.accent,
    this.accentSecondary,
    this.onTap,
    this.onLongPress,
    this.pressScale = 0.97,
    this.haptic = false,
    super.key,
  });

  final Widget child;
  final double radius;
  final EdgeInsetsGeometry padding;

  /// Light pooled in the top-right corner.
  final Color? accent;

  /// A fainter second light in the bottom-left corner, for the hero.
  final Color? accentSecondary;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double pressScale;
  final bool haptic;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final surface = CustomPaint(
      painter: _EdgeLitPainter(
        onSurface: scheme.onSurface,
        radius: radius,
        accent: accent,
        accentSecondary: accentSecondary,
      ),
      child: Padding(padding: padding, child: child),
    );
    if (onTap == null && onLongPress == null) return surface;
    return Pressable(
      onTap: onTap,
      onLongPress: onLongPress,
      scale: pressScale,
      haptic: haptic,
      child: surface,
    );
  }
}

class _EdgeLitPainter extends CustomPainter {
  const _EdgeLitPainter({
    required this.onSurface,
    required this.radius,
    required this.accent,
    required this.accentSecondary,
  });

  final Color onSurface;
  final double radius;
  final Color? accent;
  final Color? accentSecondary;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final top = Alignment.topCenter.alongSize(size);
    final bottom = Alignment.bottomCenter.alongSize(size);

    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = ui.Gradient.linear(top, bottom, [
          onSurface.withValues(alpha: 0.055),
          onSurface.withValues(alpha: 0.03),
        ]),
    );

    if (accent != null || accentSecondary != null) {
      canvas
        ..save()
        ..clipRRect(rrect);
      if (accent case final color?) {
        _pool(
          canvas,
          Offset(size.width - 24, -16),
          size.width * 0.62,
          color,
          0.26,
        );
      }
      if (accentSecondary case final color?) {
        _pool(
          canvas,
          Offset(-8, size.height + 16),
          size.width * 0.5,
          color,
          0.14,
        );
      }
      canvas.restore();
    }

    // The edge: a 1 px stroke centred half a pixel inside the bounds so it
    // never bleeds past the rounded corners.
    canvas.drawRRect(
      rrect.deflate(0.5),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..shader = ui.Gradient.linear(top, bottom, [
          onSurface.withValues(alpha: 0.12),
          onSurface.withValues(alpha: 0.04),
        ]),
    );
  }

  static void _pool(
    Canvas canvas,
    Offset center,
    double reach,
    Color color,
    double alpha,
  ) {
    canvas.drawCircle(
      center,
      reach,
      Paint()
        ..shader = ui.Gradient.radial(
          center,
          reach,
          [
            color.withValues(alpha: alpha),
            color.withValues(alpha: alpha * 0.45),
            color.withValues(alpha: alpha * 0.12),
            color.withValues(alpha: 0),
          ],
          const [0, 0.35, 0.7, 1],
        ),
    );
  }

  @override
  bool shouldRepaint(_EdgeLitPainter old) =>
      old.onSurface != onSurface ||
      old.radius != radius ||
      old.accent != accent ||
      old.accentSecondary != accentSecondary;
}
