import 'package:flutter/material.dart';

import 'package:repster/shared/widgets/soft_glow.dart';

/// Standard scaffold for the main pages (dashboard, history, stats): dark
/// background + fixed light glows at the top + safe area. The [child] sits
/// above the glows, with no `AppBar`.
class GlowScaffold extends StatelessWidget {
  const GlowScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: Stack(
        children: [
          _GlowBackdrop(primary: primary),
          // Only reserves the real system insets (status bar). No artificial
          // top margin: it would sit *outside* the scroll box and hide content
          // while scrolling. Top spacing is handled by each scrollable's own
          // padding (so it scrolls).
          SafeArea(bottom: false, child: child),
        ],
      ),
    );
  }
}

class _GlowBackdrop extends StatelessWidget {
  const _GlowBackdrop({required this.primary});

  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              top: -220,
              left: 0,
              right: 0,
              child: Center(
                child: SoftGlow(
                  color: primary.withValues(alpha: 0.09),
                  size: 520,
                  blur: 70,
                ),
              ),
            ),
            Positioned(
              top: 130,
              right: -110,
              child: SoftGlow(
                color: primary.withValues(alpha: 0.05),
                size: 288,
                blur: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
