import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';

/// The app's loading indicator: a thin ring in the brand's light with one
/// bright quarter turning — the PWA's `border-t-primary animate-spin`
/// spinner, not Material's or Cupertino's.
class AppLoading extends StatelessWidget {
  const AppLoading({this.size = 32, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(child: AppSpinner(size: size));
  }
}

/// The spinning ring on its own, for inline use (buttons, rows).
class AppSpinner extends StatefulWidget {
  const AppSpinner({this.size = 32, this.color, this.stroke = 2, super.key});

  final double size;

  /// Defaults to the brand's light.
  final Color? color;
  final double stroke;

  @override
  State<AppSpinner> createState() => _AppSpinnerState();
}

class _AppSpinnerState extends State<AppSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.glow;
    return Semantics(
      label: MaterialLocalizations.of(context).refreshIndicatorSemanticLabel,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, _) => CustomPaint(
            size: Size.square(widget.size),
            painter: _RingPainter(
              turn: _controller.value,
              color: color,
              stroke: widget.stroke,
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.turn,
    required this.color,
    required this.stroke,
  });

  final double turn;
  final Color color;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(stroke / 2);
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = color.withValues(alpha: 0.3);
    canvas.drawOval(rect, track);
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;
    // The lit quarter starts at the top and goes round once per cycle.
    final start = -math.pi / 2 + turn * 2 * math.pi;
    canvas.drawArc(rect, start, math.pi / 2, false, arc);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.turn != turn || old.color != color || old.stroke != stroke;
}
