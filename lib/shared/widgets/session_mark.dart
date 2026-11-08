import 'package:flutter/material.dart';

import 'package:repster/core/emoji/fluent_emoji.dart';

/// A Fluent emoji drawn with no box of its own: [SessionMark] and the picker
/// cells each draw their own tile around it.
class FluentEmojiImage extends StatelessWidget {
  const FluentEmojiImage(this.emoji, {required this.size, super.key});

  final FluentEmoji emoji;
  final double size;

  @override
  Widget build(BuildContext context) {
    // Decoded at the displayed size (in device pixels) rather than drawn
    // shrunk from the 128 px source: a large downscale at draw time has no
    // mipmaps on the web renderer and comes out aliased.
    final pixels = (size * MediaQuery.devicePixelRatioOf(context)).ceil();
    return Image.asset(
      emoji.assetPath,
      width: size,
      height: size,
      cacheWidth: pixels,
      cacheHeight: pixels,
      excludeFromSemantics: true,
    );
  }
}

/// The recurring thumbnail of a template or session on cards (programme list,
/// history, dashboard hero): its emoji on a square tinted with the muscle
/// group's colour. The image takes a little over half the tile, as an emoji
/// in a chip would.
class SessionMark extends StatelessWidget {
  const SessionMark({
    required this.emoji,
    required this.accent,
    this.size = 40,
    this.radius = 12,
    super.key,
  });

  final FluentEmoji emoji;
  final Color accent;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: FluentEmojiImage(emoji, size: size * 0.58),
    );
  }
}
