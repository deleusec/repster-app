import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/shared/widgets/soft_glow.dart';

/// Standard scaffold for the main pages (dashboard, history, stats): dark
/// background + fixed light glows at the top + safe area. The [child] sits
/// above the glows, with no `AppBar`.
class GlowScaffold extends StatelessWidget {
  const GlowScaffold({required this.child, super.key});

  final Widget child;

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
          SafeArea(bottom: false, child: child),
        ],
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
