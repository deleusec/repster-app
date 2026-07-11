import 'package:flutter/material.dart';

import 'package:repster/features/templates/domain/muscle_group.dart';

/// Accent color per muscle group. Single source of truth: used by
/// `MuscleGroupChip` and the dashboard emoji badges.
extension MuscleGroupVisuals on MuscleGroup {
  Color get accent => switch (this) {
    MuscleGroup.chest => const Color(0xFFFB923C),
    MuscleGroup.back => const Color(0xFF60A5FA),
    MuscleGroup.shoulders => const Color(0xFFF472B6),
    MuscleGroup.biceps => const Color(0xFFC084FC),
    MuscleGroup.triceps => const Color(0xFFA78BFA),
    MuscleGroup.forearms => const Color(0xFFFBBF24),
    MuscleGroup.quads => const Color(0xFF4ADE80),
    MuscleGroup.hamstrings => const Color(0xFF2DD4BF),
    MuscleGroup.glutes => const Color(0xFF34D399),
    MuscleGroup.calves => const Color(0xFFA3E635),
    MuscleGroup.abs => const Color(0xFFFACC15),
    MuscleGroup.custom => const Color(0xFFA1A1AA),
  };
}

/// Square "emoji on tinted background" badge for a muscle group — the recurring
/// element on cards (templates, sessions, hero).
class MuscleGroupBadge extends StatelessWidget {
  const MuscleGroupBadge({
    required this.group,
    this.size = 40,
    this.radius = 12,
    this.fontSize = 20,
    super.key,
  });

  final MuscleGroup group;
  final double size;
  final double radius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: group.accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(group.emoji, style: TextStyle(fontSize: fontSize, height: 1)),
    );
  }
}
