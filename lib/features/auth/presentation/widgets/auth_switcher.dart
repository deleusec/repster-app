import 'package:flutter/material.dart';

import 'package:repster/features/auth/presentation/widgets/auth_motion.dart';

/// Sequential transition between two auth modes (login ↔ register).
///
/// The current content **fully fades out before** the new one appears — no
/// visual overlap, unlike an `AnimatedSwitcher` which renders both children
/// at once.
///
/// Total animation ≈ 280 ms: exit (`opacity 1→0`, `scale 1→0.96`) then enter
/// (`opacity 0→1`, `scale 0.96→1`). Duration and curve driven by [AuthMotion].
class AuthSwitcher extends StatefulWidget {
  const AuthSwitcher({
    required this.child,
    this.duration = AuthMotion.swap,
    this.scaleFrom = 0.96,
    super.key,
  });

  /// The child to display. Must be a widget with a `Key` that changes when
  /// the mode changes (otherwise no transition plays).
  final Widget child;

  /// Duration of half a transition (enter OR exit). Total animation = 2× this.
  final Duration duration;

  /// Initial scale on enter (and final on exit). `0.96` is subtle but
  /// perceptible.
  final double scaleFrom;

  @override
  State<AuthSwitcher> createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<AuthSwitcher>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Widget _displayed;

  @override
  void initState() {
    super.initState();
    _displayed = widget.child;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: 1,
    );
  }

  @override
  void didUpdateWidget(AuthSwitcher old) {
    super.didUpdateWidget(old);
    if (widget.child.key != old.child.key) {
      _swap();
    } else if (!identical(widget.child, old.child)) {
      // Same mode but the parent rebuilt (e.g. setState on a global error, an
      // input change). No animation to play, but the displayed content must be
      // refreshed — otherwise state changes stay invisible.
      _displayed = widget.child;
    }
  }

  Future<void> _swap() async {
    await _controller.reverse();
    if (!mounted) return;
    setState(() => _displayed = widget.child);
    await _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: _controller,
      curve: AuthMotion.curve,
    );
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(begin: widget.scaleFrom, end: 1).animate(curved),
        child: _displayed,
      ),
    );
  }
}
