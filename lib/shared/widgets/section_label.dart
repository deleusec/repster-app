import 'package:flutter/material.dart';

/// Small section label in spaced uppercase, with an optional leading icon.
/// Shared by settings, profile, etc.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {this.icon, super.key});

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final label = Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.8,
        color: onSurface.withValues(alpha: 0.5),
      ),
    );
    final icon = this.icon;
    if (icon == null) return label;
    return Row(
      children: [
        Icon(icon, size: 12, color: onSurface.withValues(alpha: 0.4)),
        const SizedBox(width: 6),
        label,
      ],
    );
  }
}
