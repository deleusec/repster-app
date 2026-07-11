import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_text.dart';

/// Page header: large title + optional subtle subtitle. Shared by the main
/// screens (history, stats, settings) for identical typography.
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({required this.title, this.subtitle, super.key});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final subtitle = this.subtitle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppText.pageTitle),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: onSurface.withValues(alpha: 0.55),
            ),
          ),
        ],
      ],
    );
  }
}
