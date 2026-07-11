import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/stats/domain/stats_data.dart';
import 'package:repster/features/stats/presentation/widgets/stat_panel.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/icon_chip.dart';

/// Highlights: best session, heaviest lift, best 1RM, longest streak.
class RecordsPanel extends StatelessWidget {
  const RecordsPanel({required this.records, super.key});

  final Records records;

  @override
  Widget build(BuildContext context) {
    final r = records;
    final tiles = <Widget>[
      if (r.bestSession != null)
        _RecordTile(
          icon: LucideIcons.award,
          tint: AppColors.accentAmber,
          value: formatTonnage(r.bestSession!.tonnageKg),
          label: t.stats.records.bestSession,
          sub: '${r.bestSession!.name} · ${shortDate(r.bestSession!.date)}',
        ),
      if (r.heaviestLift != null)
        _RecordTile(
          icon: LucideIcons.dumbbell,
          tint: AppColors.accentEmerald,
          value: '${formatWeight(r.heaviestLift!.weight)} kg',
          label: t.stats.records.heaviestLift,
          sub:
              '${r.heaviestLift!.exercise} · '
              '${r.heaviestLift!.reps} ${t.common.units.reps}',
        ),
      if (r.bestOneRm != null)
        _RecordTile(
          icon: LucideIcons.trophy,
          tint: AppColors.accentBlue,
          value: '${r.bestOneRm!.oneRm.round()} kg',
          label: t.stats.records.bestOneRm,
          sub: r.bestOneRm!.exercise,
        ),
      if (r.bestStreakWeeks > 0)
        _RecordTile(
          icon: LucideIcons.flame,
          tint: AppColors.accentOrange,
          value: t.stats.weeksShort(n: r.bestStreakWeeks),
          label: t.stats.records.bestStreak,
          sub: t.stats.records.consecutiveWeeks,
        ),
    ];

    if (tiles.isEmpty) return const SizedBox.shrink();

    return StatPanel(
      title: t.stats.records.title,
      icon: LucideIcons.trophy,
      child: Column(
        children: [
          for (var i = 0; i < tiles.length; i += 2)
            Padding(
              padding: EdgeInsets.only(bottom: i + 2 < tiles.length ? 10 : 0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: tiles[i]),
                    const SizedBox(width: 10),
                    Expanded(
                      child: i + 1 < tiles.length
                          ? tiles[i + 1]
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecordTile extends StatelessWidget {
  const _RecordTile({
    required this.icon,
    required this.tint,
    required this.value,
    required this.label,
    required this.sub,
  });

  final IconData icon;
  final Color tint;
  final String value;
  final String label;
  final String sub;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: scheme.translucentTile,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconChip(icon: icon, color: tint),
          const SizedBox(height: 10),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            sub,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
