import 'package:flutter/material.dart';

import 'package:repster/features/auth/presentation/widgets/auth_motion.dart';
import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';

/// Onboarding progress indicator — small dots with the active step shown as
/// an elongated pill.
class StepDots extends StatelessWidget {
  const StepDots({
    required this.totalSteps,
    required this.currentStep,
    super.key,
  });

  /// 1-indexed.
  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 1; i <= totalSteps; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: AuthMotion.feedback,
              curve: AuthMotion.curve,
              width: currentStep == i ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentStep == i
                    ? scheme.primary
                    : currentStep > i
                    ? scheme.primary.withValues(alpha: 0.40)
                    : AuthTokens.cardBgStrong,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
      ],
    );
  }
}
