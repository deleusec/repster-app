import 'package:flutter/material.dart';

import 'package:repster/features/auth/presentation/widgets/auth_motion.dart';

/// Goal card for onboarding step 2. Two orientations: vertical (icon on top,
/// in the two-column grid) and `horizontal` (icon on the left, full width —
/// for the last "maintenance" item).
class GoalCardButton extends StatelessWidget {
  const GoalCardButton({
    required this.label,
    required this.description,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.horizontal = false,
    super.key,
  });

  final String label;
  final String description;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = selected
        ? scheme.primary.withValues(alpha: 0.12)
        : Colors.white.withValues(alpha: 0.05);
    final border = selected
        ? scheme.primary.withValues(alpha: 0.35)
        : Colors.white.withValues(alpha: 0.07);
    final iconBg = selected
        ? scheme.primary.withValues(alpha: 0.20)
        : Colors.white.withValues(alpha: 0.08);
    final iconColor = selected
        ? scheme.primary
        : Colors.white.withValues(alpha: 0.40);
    final labelColor = selected
        ? Colors.white
        : Colors.white.withValues(alpha: 0.65);

    final iconWidget = Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: iconBg,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 18, color: iconColor),
    );

    final textWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.30),
          ),
        ),
      ],
    );

    final content = horizontal
        ? Row(
            children: [
              iconWidget,
              const SizedBox(width: 14),
              Expanded(child: textWidget),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [iconWidget, const SizedBox(height: 12), textWidget],
          );

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: AuthMotion.feedback,
          curve: AuthMotion.curve,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: border),
          ),
          child: content,
        ),
      ),
    );
  }
}
