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

  // Short steps and a hard cap: the page should be fully there within half a
  // second, a settle rather than a parade.
  static const int _maxSteps = 8;
  static const int _stepMs = 40;
  static const Duration _duration = Duration(milliseconds: 380);

  Widget wrap(Widget child) {
    if (!enabled) return child;
    final step = _index < _maxSteps ? _index : _maxSteps;
    _index++;
    return child
        .animate(delay: (step * _stepMs).ms)
        .fadeIn(duration: _duration)
        .slideY(
          begin: 0.05,
          end: 0,
          duration: _duration,
          curve: Curves.easeOutQuint,
        );
  }
}
