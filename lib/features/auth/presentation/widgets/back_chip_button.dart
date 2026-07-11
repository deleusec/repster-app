import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';

/// Small rounded chevron button at the top-left of the "Create account"
/// form.
class BackChipButton extends StatelessWidget {
  const BackChipButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AuthTokens.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AuthTokens.cardBorder),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            LucideIcons.chevronLeft,
            size: 16,
            color: Colors.white.withValues(alpha: 0.45),
          ),
        ),
      ),
    );
  }
}
