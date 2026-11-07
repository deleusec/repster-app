import 'package:flutter/material.dart';

/// Scrolling without Material's blue-grey overscroll glow. The PWA sets
/// `overscroll-behavior: none`; the glow is the loudest tell that a dark
/// page is a Flutter page.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;
}
