import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/edge_lit_surface.dart';
import 'package:repster/shared/widgets/pressable.dart';
import 'package:repster/shared/widgets/session_mark.dart';

/// The start affordance: a filled play in a disc of the brand's light.
class PlayDisc extends StatelessWidget {
  const PlayDisc({required this.onTap, this.size = 34, super.key});

  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final glow = Theme.of(context).colorScheme.glow;
    return Tooltip(
      message: t.templates.programs.start,
      child: Pressable(
        onTap: onTap,
        haptic: true,
        scale: 0.88,
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: glow.withValues(alpha: 0.14),
          ),
          child: Icon(Icons.play_arrow_rounded, size: size * 0.6, color: glow),
        ),
      ),
    );
  }
}

/// The "more" button of a session: opens its actions.
class SessionMoreButton extends StatelessWidget {
  const SessionMoreButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Pressable(
      onTap: onTap,
      scale: 0.85,
      child: SizedBox(
        width: 34,
        height: 34,
        child: Icon(LucideIcons.ellipsis, size: 18, color: scheme.textTertiary),
      ),
    );
  }
}

/// Meta line under a session's name: its exercise count, or that it is off.
String sessionMeta(Template template) => template.isActive
    ? t.templates.card.exerciseCount(n: template.primaryExercises.length)
    : t.templates.programs.sessionInactive;

/// A session outside any program, as a square tile in the grid next to the
/// folders. Tapping opens it; the disc starts it.
class SessionTile extends StatelessWidget {
  const SessionTile({
    required this.template,
    required this.onOpen,
    required this.onStart,
    required this.onMore,
    this.receiving = false,
    super.key,
  });

  final Template template;
  final VoidCallback onOpen;
  final VoidCallback onStart;
  final VoidCallback onMore;

  /// Another tile is being dragged over this one, about to take its place.
  final bool receiving;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dim = template.isActive ? 1.0 : 0.45;

    return AnimatedScale(
      scale: receiving ? 0.94 : 1,
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOut,
      child: EdgeLitSurface(
        radius: AppRadius.cardLg,
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 10, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: dim,
                    child: SessionMark(emoji: template.emoji, size: 44),
                  ),
                  const Spacer(),
                  // Pulled into the corner: the glyph, not its 34 px hit
                  // box, is what lines up with the tile's padding.
                  Transform.translate(
                    offset: const Offset(2, -8),
                    child: SessionMoreButton(onTap: onMore),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Opacity(
                      opacity: dim,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            template.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.cardTitle.copyWith(
                              color: scheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            sessionMeta(template),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.caption.copyWith(
                              color: scheme.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Padding(
                    padding: const EdgeInsets.only(right: 4, bottom: 2),
                    child: PlayDisc(onTap: onStart),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A session inside a program, as a full-width row. Same controls as the
/// tile: tap opens, the disc starts, "more" holds the rest.
class SessionRow extends StatelessWidget {
  const SessionRow({
    required this.template,
    required this.onOpen,
    required this.onStart,
    required this.onMore,
    super.key,
  });

  final Template template;
  final VoidCallback onOpen;
  final VoidCallback onStart;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dim = template.isActive ? 1.0 : 0.45;

    return EdgeLitSurface(
      onTap: onOpen,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
        child: Row(
          children: [
            Expanded(
              child: Opacity(
                opacity: dim,
                child: Row(
                  children: [
                    SessionMark(emoji: template.emoji, size: 44),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            template.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.cardTitle.copyWith(
                              color: scheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            sessionMeta(template),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.caption.copyWith(
                              color: scheme.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            PlayDisc(onTap: onStart),
            const SizedBox(width: 2),
            SessionMoreButton(onTap: onMore),
          ],
        ),
      ),
    );
  }
}
