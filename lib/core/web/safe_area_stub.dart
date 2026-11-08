import 'package:flutter/widgets.dart';

/// Native platforms report their own insets; nothing to add.
EdgeInsets measuredSafeArea() => EdgeInsets.zero;

/// Nothing to report off the web.
String webDiagnostics() => '';
