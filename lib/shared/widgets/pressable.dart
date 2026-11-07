import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Press feedback for cards and buttons: the child shrinks a little and dims
/// while the finger is down, then springs back — the PWA's `active:scale-95`.
///
/// This is the app's one pressed state. No ink ripple: a ripple is Material's
/// signature, and it spreads a grey disc over translucent cards that were
/// designed to stay dark.
class Pressable extends StatefulWidget {
  const Pressable({
    required this.child,
    this.onTap,
    this.onLongPress,
    this.scale = 0.97,
    this.haptic = false,
    this.behavior = HitTestBehavior.opaque,
    super.key,
  });

  final Widget child;

  /// `null` disables the press: no scale, no callback.
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  /// Scale while pressed. Cards use the default; small controls go to 0.94.
  final double scale;

  /// A light impact on tap, for the actions that *do* something (start a
  /// session, switch tab). Off for plain navigation.
  final bool haptic;

  final HitTestBehavior behavior;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _down = false;

  static const _duration = Duration(milliseconds: 110);

  bool get _enabled => widget.onTap != null || widget.onLongPress != null;

  void _set(bool down) {
    if (_down == down) return;
    setState(() => _down = down);
  }

  void _tap() {
    if (widget.haptic) HapticFeedback.lightImpact();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (!_enabled) return widget.child;
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: widget.behavior,
        onTapDown: (_) => _set(true),
        onTapUp: (_) => _set(false),
        onTapCancel: () => _set(false),
        onTap: widget.onTap == null ? null : _tap,
        onLongPress: widget.onLongPress,
        child: AnimatedScale(
          scale: _down ? widget.scale : 1,
          duration: _duration,
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: _down ? 0.85 : 1,
            duration: _duration,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
