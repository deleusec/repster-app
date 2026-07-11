import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// **Continuous** countdown ring: progress is recomputed each frame from
/// [startedAt] + [totalSeconds] (real time) instead of interpolating in
/// one-second steps. This gives a perfectly smooth sweep, an instant reset when
/// a new rest starts, and correct behavior after extending (+/- seconds). Used
/// by the rest timer.
class CountdownRing extends StatefulWidget {
  const CountdownRing({
    required this.startedAt,
    required this.totalSeconds,
    required this.color,
    required this.trackColor,
    this.size = 220,
    this.stroke = 10,
    this.glow = false,
    this.child,
    super.key,
  });

  final DateTime startedAt;
  final int totalSeconds;
  final Color color;
  final Color trackColor;
  final double size;
  final double stroke;
  final bool glow;
  final Widget? child;

  @override
  State<CountdownRing> createState() => _CountdownRingState();
}

class _CountdownRingState extends State<CountdownRing>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  double _progress = 1;

  @override
  void initState() {
    super.initState();
    _progress = _compute();
    _ticker = createTicker((_) {
      final p = _compute();
      if (p != _progress) setState(() => _progress = p);
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  double _compute() {
    if (widget.totalSeconds <= 0) return 0;
    final elapsed =
        DateTime.now().difference(widget.startedAt).inMilliseconds / 1000.0;
    final remaining = widget.totalSeconds - elapsed;
    return (remaining / widget.totalSeconds).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _RingPainter(
              progress: _progress,
              color: widget.color,
              trackColor: widget.trackColor,
              stroke: widget.stroke,
              glow: widget.glow,
            ),
          ),
          if (widget.child != null) widget.child!,
        ],
      ),
    );
  }
}

/// Circular progress ring (track + arc) for session timers. [progress] goes
/// from 0 to 1, drawn from the top, clockwise.
class TimerRing extends StatelessWidget {
  const TimerRing({
    required this.progress,
    required this.color,
    required this.trackColor,
    this.size = 220,
    this.stroke = 10,
    this.glow = false,
    this.child,
    super.key,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double size;
  final double stroke;

  /// Adds a diffuse halo around the arc (rest mini pill).
  final bool glow;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: progress, end: progress),
            duration: const Duration(seconds: 1),
            builder: (context, value, _) => CustomPaint(
              size: Size(size, size),
              painter: _RingPainter(
                progress: value.clamp(0, 1),
                color: color,
                trackColor: trackColor,
                stroke: stroke,
                glow: glow,
              ),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.stroke,
    this.glow = false,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double stroke;
  final bool glow;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width - stroke) / 2;
    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawCircle(center, radius, track);

    if (progress <= 0) return;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const start = -math.pi / 2;
    final sweep = 2 * math.pi * progress;

    if (glow) {
      final halo = Paint()
        ..color = color.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawArc(rect, start, sweep, false, halo);
    }

    final arc = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, start, sweep, false, arc);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.trackColor != trackColor ||
      old.glow != glow;
}
