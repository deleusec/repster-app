import 'package:flutter/material.dart';

/// Root messenger (attached to the `MaterialApp`) — toasts go through it
/// rather than the current page's `Scaffold`. Decouples SnackBars from page
/// Scaffolds, which can deactivate (tab switch, route pop, reordering) while a
/// SnackBar is still animating — the cause of "Looking up a deactivated
/// widget's ancestor is unsafe".
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
