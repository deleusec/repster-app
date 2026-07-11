import 'package:flutter/material.dart';

/// Shared layout for all auth screens — dark background with two decorative
/// glows.
///
/// The content is vertically centered, constrained to ≈ 384 px wide, and can
/// scroll when too tall.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.child,
    this.showBottomGlow = true,
    super.key,
  });

  final Widget child;

  /// Secondary glow at the bottom, shown on login. Hidden on onboarding.
  final bool showBottomGlow;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          // Main glow — top, wider and more saturated.
          Positioned(
            top: -96,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Center(
                child: _Glow(
                  width: 480,
                  height: 380,
                  blur: 90,
                  color: scheme.primary.withValues(alpha: 0.12),
                ),
              ),
            ),
          ),
          if (showBottomGlow)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Center(
                  child: _Glow(
                    width: 280,
                    height: 180,
                    blur: 70,
                    color: scheme.primary.withValues(alpha: 0.06),
                  ),
                ),
              ),
            ),

          // Content — scrollable and vertically centered when the viewport is
          // taller than the content.
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 80,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 384),
                        child: child,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Blurred circle used as a decorative glow.
class _Glow extends StatelessWidget {
  const _Glow({
    required this.width,
    required this.height,
    required this.blur,
    required this.color,
  });

  final double width;
  final double height;
  final double blur;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(width / 2)),
        boxShadow: [
          BoxShadow(color: color, blurRadius: blur, spreadRadius: blur / 2),
        ],
      ),
    );
  }
}
