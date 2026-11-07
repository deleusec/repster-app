import 'package:flutter/material.dart';

import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/shared/l10n/muscle_group_l10n.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';
import 'package:repster/shared/widgets/pressable.dart';

/// Colored badge for a muscle group, using the group's accent color for both
/// the background tint and the label.
class MuscleGroupChip extends StatelessWidget {
  const MuscleGroupChip({
    required this.group,
    this.dense = false,
    this.selected,
    this.onTap,
    super.key,
  });

  final MuscleGroup group;
  final bool dense;

  /// When provided, renders a "selected" state (border + more opaque bg).
  final bool? selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final accent = group.accent;
    final isSel = selected ?? false;
    final pad = dense
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
        : const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
    final bg = accent.withValues(alpha: isSel ? 0.30 : 0.15);

    final chip = Container(
      padding: pad,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: isSel ? Border.all(color: accent.withValues(alpha: 0.6)) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            group.emoji,
            style: TextStyle(fontSize: dense ? 12 : 14, height: 1),
          ),
          const SizedBox(width: 6),
          Text(
            group.localizedLabel,
            style: TextStyle(
              color: accent,
              fontSize: dense ? 11 : 12.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return chip;
    return Pressable(onTap: onTap, scale: 0.94, child: chip);
  }
}
