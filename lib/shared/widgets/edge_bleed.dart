import 'package:flutter/material.dart';

/// Stretches a horizontal scrollable to the screen edges even when it sits in a
/// page that applies a horizontal margin (page `ListView`s use
/// `EdgeInsets.fromLTRB(16, …)`).
///
/// Combine with a horizontal padding **inside** the scrollable (equal to the
/// page margin, e.g. `EdgeInsets.symmetric(horizontal: 16)`): the first / last
/// item then keeps the margin, while overflowing items scroll to the edge
/// instead of being clipped at the margin.
///
/// Must be placed **under** a parent that bounds the height (typically a
/// `SizedBox(height: …)`), since it only constrains the width.
class EdgeBleed extends StatelessWidget {
  const EdgeBleed({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Let the child span the full screen width; being centered, it overflows
    // symmetrically by the margin on each side of the parent slot.
    return OverflowBox(
      maxWidth: MediaQuery.sizeOf(context).width,
      child: child,
    );
  }
}
