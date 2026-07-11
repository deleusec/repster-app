import 'package:flutter/material.dart';

import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/shared/l10n/muscle_group_l10n.dart';
import 'package:repster/shared/widgets/muscle_group_chip.dart';

/// Multi-tag selector grouped by section.
class MuscleGroupPicker extends StatelessWidget {
  const MuscleGroupPicker({
    required this.selected,
    required this.onToggle,
    super.key,
  });

  final Set<MuscleGroup> selected;
  final ValueChanged<MuscleGroup> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final section in MuscleGroupSection.all) ...[
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 6),
            child: Text(
              section.localizedTitle,
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w700,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final g in section.groups)
                MuscleGroupChip(
                  group: g,
                  selected: selected.contains(g),
                  onTap: () => onToggle(g),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
