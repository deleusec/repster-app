import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/templates/domain/program.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/session_mark.dart';

/// How far the folder's front panel drops to the right of its tab, leaving a
/// strip of the back panel showing.
const double _tabDrop = 26;

/// A program in the grid, drawn as a folder: a tab on the left, the back
/// panel showing behind it on the right, and the pictures of the sessions
/// filed inside.
///
/// The active program is the one lit surface of the page — the brand's light
/// pools in its front panel.
class ProgramFolderCard extends StatelessWidget {
  const ProgramFolderCard({
    required this.program,
    required this.sessions,
    this.receiving = false,
    super.key,
  });

  final Program program;

  /// The sessions filed under this program, in order.
  final List<Template> sessions;

  /// A dragged session is hovering: the folder opens up to take it.
  final bool receiving;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final glow = scheme.glow;
    final lit = program.isActive || receiving;

    return AnimatedScale(
      scale: receiving ? 1.05 : 1,
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOut,
      child: CustomPaint(
        painter: _FolderPainter(
          onSurface: scheme.onSurface,
          accent: lit ? glow : null,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, _tabDrop + 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Marks(sessions: sessions),
                  const Spacer(),
                  Text(
                    program.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.cardTitle.copyWith(
                      color: scheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          sessions.isEmpty
                              ? t.templates.programs.empty
                              : t.templates.programs.sessionCount(
                                  n: sessions.length,
                                ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.caption.copyWith(
                            color: scheme.textTertiary,
                          ),
                        ),
                      ),
                      if (program.isActive) ...[
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: glow,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          t.templates.programs.active,
                          style: AppText.caption.copyWith(
                            fontWeight: FontWeight.w600,
                            color: scheme.textPrimary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Up to three session pictures; past that, the third slot counts the rest.
class _Marks extends StatelessWidget {
  const _Marks({required this.sessions});

  final List<Template> sessions;

  static const double _size = 36;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (sessions.isEmpty) return const SizedBox(height: _size);

    final overflow = sessions.length > 3;
    final shown = sessions.take(overflow ? 2 : 3);
    return Row(
      children: [
        for (final s in shown) ...[
          SessionMark(emoji: s.emoji, size: _size, radius: AppRadius.controlSm),
          const SizedBox(width: 6),
        ],
        if (overflow)
          Container(
            width: _size,
            height: _size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.onSurface.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadius.controlSm),
            ),
            child: Text(
              '+${sessions.length - 2}',
              style: AppText.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: scheme.textSecondary,
              ),
            ),
          ),
      ],
    );
  }
}

/// Paints the folder with the same light as `EdgeLitSurface` — fill fading
/// 5.5 → 3 %, edge 12 → 4 % — on a folder silhouette instead of a rectangle.
class _FolderPainter extends CustomPainter {
  const _FolderPainter({required this.onSurface, required this.accent});

  final Color onSurface;
  final Color? accent;

  static const double _radius = AppRadius.cardLg;

  /// The front panel: full height under the tab, [_tabDrop] lower beyond it.
  static Path _front(Size size) {
    final w = size.width;
    final h = size.height;
    const r = _radius;
    final tabEnd = math.min<double>(w * 0.44, 96);
    // Half the width of the slope from the tab down to the lower edge.
    const slope = 15.0;
    return Path()
      ..moveTo(0, r)
      ..arcToPoint(const Offset(r, 0), radius: const Radius.circular(r))
      ..lineTo(tabEnd - slope, 0)
      ..cubicTo(tabEnd, 0, tabEnd, _tabDrop, tabEnd + slope, _tabDrop)
      ..lineTo(w - r, _tabDrop)
      ..arcToPoint(Offset(w, _tabDrop + r), radius: const Radius.circular(r))
      ..lineTo(w, h - r)
      ..arcToPoint(Offset(w - r, h), radius: const Radius.circular(r))
      ..lineTo(r, h)
      ..arcToPoint(Offset(0, h - r), radius: const Radius.circular(r))
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final back = RRect.fromRectAndRadius(rect, const Radius.circular(_radius));
    final front = _front(size);
    final top = Alignment.topCenter.alongSize(size);
    final bottom = Alignment.bottomCenter.alongSize(size);

    // Back panel: only the strip the front panel leaves uncovered.
    canvas
      ..save()
      ..clipPath(
        Path.combine(PathOperation.difference, Path()..addRRect(back), front),
      )
      ..drawRRect(back, Paint()..color = onSurface.withValues(alpha: 0.03))
      ..drawRRect(
        back.deflate(0.5),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = onSurface.withValues(alpha: 0.08),
      )
      ..restore()
      ..drawPath(
        front,
        Paint()
          ..shader = ui.Gradient.linear(top, bottom, [
            onSurface.withValues(alpha: 0.06),
            onSurface.withValues(alpha: 0.03),
          ]),
      );

    if (accent case final color?) {
      final center = Offset(size.width - 20, _tabDrop - 10);
      final reach = size.width * 0.9;
      canvas
        ..save()
        ..clipPath(front)
        ..drawCircle(
          center,
          reach,
          Paint()
            ..shader = ui.Gradient.radial(
              center,
              reach,
              [
                color.withValues(alpha: 0.30),
                color.withValues(alpha: 0.13),
                color.withValues(alpha: 0.03),
                color.withValues(alpha: 0),
              ],
              const [0, 0.35, 0.7, 1],
            ),
        )
        ..restore();
    }

    final edgeTop = accent == null
        ? onSurface.withValues(alpha: 0.14)
        : Color.lerp(onSurface, accent, 0.55)!.withValues(alpha: 0.4);
    canvas.drawPath(
      front,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..shader = ui.Gradient.linear(top, bottom, [
          edgeTop,
          onSurface.withValues(alpha: 0.04),
        ]),
    );
  }

  @override
  bool shouldRepaint(_FolderPainter old) =>
      old.onSurface != onSurface || old.accent != accent;
}
