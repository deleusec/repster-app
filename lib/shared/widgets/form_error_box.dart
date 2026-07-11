import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Global error banner for the app's forms (template edit, contact, profile,
/// etc.). Uses the current theme's `colorScheme.error` palette.
///
/// For auth screens, which have their own dark visual identity, see
/// `AuthErrorBox` in `features/auth/presentation/widgets/`.
class FormErrorBox extends StatelessWidget {
  const FormErrorBox({required this.message, this.icon, super.key});

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: scheme.errorContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon ?? LucideIcons.circleAlert, size: 18, color: scheme.error),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: scheme.error,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
