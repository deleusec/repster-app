import 'package:flutter/material.dart';

import 'package:repster/core/emoji/fluent_emoji.dart';

/// [FluentEmoji.tint] as a Flutter colour.
extension FluentEmojiColor on FluentEmoji {
  Color get color => Color(tint);
}

/// A Fluent emoji drawn with no box of its own: [SessionMark] and the picker
/// cells each draw their own tile around it.
class FluentEmojiImage extends StatelessWidget {
  const FluentEmojiImage(this.emoji, {required this.size, super.key});

  final FluentEmoji emoji;
  final double size;

  @override
  Widget build(BuildContext context) {
    // Drawn shrunk from the 128 px source with cubic sampling. Never decode
    // at a target size (`cacheWidth`) here: WebKit resizes that bitmap with
    // nearest-neighbour sampling, and the PWA on iOS showed jagged edges.
    return Image.asset(
      emoji.assetPath,
      width: size,
      height: size,
      filterQuality: FilterQuality.high,
      excludeFromSemantics: true,
    );
  }
}

/// The recurring thumbnail of a template or session on cards (programme list,
/// history, dashboard hero): its emoji on a square tinted with the emoji's
/// own colour. The image takes a little over half the tile, as an emoji in
/// a chip would.
class SessionMark extends StatelessWidget {
  const SessionMark({
    required this.emoji,
    this.size = 40,
    this.radius = 12,
    super.key,
  });

  final FluentEmoji emoji;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: emoji.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: FluentEmojiImage(emoji, size: size * 0.58),
    );
  }
}
