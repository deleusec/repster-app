import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';
import 'package:repster/shared/widgets/pressable.dart';

/// Shared height for the template carousel cards. Sized to fit a 2-line name
/// (36 thumbnail + name 2×~16 + subtitle + paddings/border) without overflow.
const double kTemplateCarouselHeight = 134;

/// Compact template thumbnail for the dashboard's horizontal carousel.
class TemplatePreviewCard extends StatelessWidget {
  const TemplatePreviewCard({
    required this.template,
    required this.onTap,
    super.key,
  });

  final Template template;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final group = template.tags.isNotEmpty
        ? template.tags.first
        : MuscleGroup.custom;
    final count = template.primaryExercises.length;

    return SizedBox(
      width: 144,
      child: EdgeLitSurface(
        onTap: onTap,
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MuscleGroupBadge(group: group, size: 36, fontSize: 18),
            const SizedBox(height: 10),
            Text(
              template.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppText.subtitle.copyWith(
                fontSize: 13,
                height: 1.2,
                color: scheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              t.dashboard.exerciseCount(n: count),
              style: AppText.caption.copyWith(
                fontSize: 11,
                color: scheme.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dashed-border "New" card at the end of the carousel.
class NewTemplateCard extends StatelessWidget {
  const NewTemplateCard({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return SizedBox(
      width: 128,
      child: Pressable(
        onTap: onTap,
        child: CustomPaint(
          painter: _DashedRRectPainter(
            color: onSurface.withValues(alpha: 0.12),
            radius: AppRadius.card,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    LucideIcons.plus,
                    size: 16,
                    color: scheme.textTertiary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.dashboard.templates.newLabel,
                  style: AppText.caption.copyWith(color: scheme.textTertiary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Dashed rounded-rectangle border.
class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    const dash = 5.0;
    const gap = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + dash), paint);
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedRRectPainter old) =>
      old.color != color || old.radius != radius;
}
