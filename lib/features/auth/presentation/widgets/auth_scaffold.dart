import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/shared/widgets/soft_glow.dart';

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
                child: SoftGlow(
                  size: 400,
                  blur: 90,
                  color: scheme.glow.withValues(alpha: 0.11),
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
                  child: SoftGlow(
                    size: 220,
                    blur: 70,
                    color: scheme.glow.withValues(alpha: 0.05),
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
