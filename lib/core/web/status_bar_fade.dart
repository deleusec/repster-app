import 'package:repster/core/web/safe_area.dart';

/// Under a translucent iOS status bar (installed web app) the system fades
/// the page out a little below the bar itself. Content at rest starts this
/// much lower than the raw inset; it is already part of `MediaQuery`'s top
/// padding (see `RepsterApp`). Zero everywhere else.
double statusBarFade() => measuredSafeArea().top > 0 ? 24 : 0;
