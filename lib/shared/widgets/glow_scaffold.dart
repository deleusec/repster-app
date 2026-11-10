import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/web/status_bar_fade.dart';
import 'package:repster/shared/widgets/soft_glow.dart';

/// Standard scaffold for the main pages (dashboard, history, stats): dark
/// background + fixed light glows at the top + safe area. The [child] sits
/// above the glows, with no `AppBar`.
class GlowScaffold extends StatelessWidget {
  const GlowScaffold({
    required this.child,
    this.pinnedHeader = false,
    super.key,
  });

  final Widget child;

  /// Whether the top of [child] stays put while the rest scrolls (a nav bar
  /// above a list). Only matters under a translucent iOS status bar, see
  /// [_UnderStatusBar].
  final bool pinnedHeader;

  @override
  Widget build(BuildContext context) {
    final glow = Theme.of(context).colorScheme.glow;
    return Scaffold(
      body: Stack(
        children: [
          _GlowBackdrop(color: glow),
          // Only reserves the real system insets (status bar). No artificial
          // top margin: it would sit *outside* the scroll box and hide content
          // while scrolling. Top spacing is handled by each scrollable's own
          // padding (so it scrolls).
          if (statusBarFade() > 0 && !pinnedHeader)
            _UnderStatusBar(fade: statusBarFade(), child: child)
          else
            SafeArea(bottom: false, child: child),
        ],
      ),
    );
  }
}

/// Under a translucent iOS status bar, `MediaQuery`'s top padding includes
/// the system's fade so that content at rest starts below it. A page that
/// scrolls as a whole should not be clipped that low though: it is clipped
/// at the bar itself, and the extra gap closes as the page scrolls, so the
/// content slides up under the fade.
class _UnderStatusBar extends StatefulWidget {
  const _UnderStatusBar({required this.fade, required this.child});

  final double fade;
  final Widget child;

  @override
  State<_UnderStatusBar> createState() => _UnderStatusBarState();
}

class _UnderStatusBarState extends State<_UnderStatusBar> {
  late double _gap = widget.fade;

  bool _onScroll(ScrollMetrics metrics, int depth) {
    if (depth != 0 || metrics.axis != Axis.vertical) return false;
    final gap = (widget.fade - metrics.pixels).clamp(0.0, widget.fade);
    if (gap != _gap) setState(() => _gap = gap);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final barHeight = MediaQuery.paddingOf(context).top - widget.fade;
    return Padding(
      padding: EdgeInsets.only(top: barHeight),
      child: ClipRect(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: NotificationListener<ScrollMetricsNotification>(
            onNotification: (n) => _onScroll(n.metrics, n.depth),
            child: NotificationListener<ScrollNotification>(
              onNotification: (n) => _onScroll(n.metrics, n.depth),
              child: Padding(
                padding: EdgeInsets.only(top: _gap),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlowBackdrop extends StatelessWidget {
  const _GlowBackdrop({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: RepaintBoundary(
        child: ClipRect(
          child: Stack(
            children: [
              // Main top glow — mirrors the PWA dashboard's atmospheric
              // backdrop (`-top-40 w-[520] h-[520] bg-primary/9 blur-[90px]`),
              // lit with the rose *light* rather than the button rose.
              Positioned(
                top: -160,
                left: 0,
                right: 0,
                child: Center(
                  child: SoftGlow(
                    color: color.withValues(alpha: 0.085),
                    size: 520,
                    blur: 90,
                  ),
                ),
              ),
              // Secondary glow (`top-[30%] -right-28 w-72 h-72 bg-primary/5
              // blur-3xl`).
              Positioned(
                top: 150,
                right: -112,
                child: SoftGlow(
                  color: color.withValues(alpha: 0.05),
                  size: 288,
                  blur: 64,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
