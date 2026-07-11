import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/i18n/translations.g.dart';

/// Standard error display. Delegates message formatting to [humanizeAppError]
/// so the copy stays translated and consistent across the app.
class AppError extends StatelessWidget {
  const AppError({required this.error, this.onRetry, super.key});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.circleAlert,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 12),
          Text(humanizeAppError(error), textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: onRetry,
              child: Text(t.common.actions.retry),
            ),
          ],
        ],
      ),
    );
  }
}
