import 'package:flutter/material.dart';

/// Rounded square badge holding a tinted icon — a recurring motif on stat cards
/// (KPIs, records, history recap).
class IconChip extends StatelessWidget {
  const IconChip({
    required this.icon,
    required this.color,
    this.size = 28,
    this.iconSize = 15,
    super.key,
  });

  final IconData icon;
  final Color color;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Icon(icon, size: iconSize, color: color),
    );
  }
}
