import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Staggered entrance animation (fade + slight upward slide) shared by the
/// lists on the main screens. Create one instance per build and call [wrap] on
/// each child in display order.
///
/// The delay is capped ([_maxSteps]) so long lists don't drag out their
/// entrance.
class StaggeredList {
  StaggeredList({this.enabled = true});

  final bool enabled;
  int _index = 0;

  static const int _maxSteps = 12;
  static const int _stepMs = 50;
  static const Duration _duration = Duration(milliseconds: 320);

  Widget wrap(Widget child) {
    if (!enabled) return child;
    final step = _index < _maxSteps ? _index : _maxSteps;
    _index++;
    return child
        .animate(delay: (step * _stepMs).ms)
        .fadeIn(duration: _duration)
        .slideY(
          begin: 0.07,
          end: 0,
          duration: _duration,
          curve: Curves.easeOutCubic,
        );
  }
}
