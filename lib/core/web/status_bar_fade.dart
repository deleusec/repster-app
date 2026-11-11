import 'package:flutter/widgets.dart';

import 'package:repster/core/web/safe_area.dart';

/// Under a translucent iOS status bar (installed web app) the system fades
/// the page out a little below the bar itself. Content at rest starts this
/// much lower than the raw inset; it is already part of `MediaQuery`'s top
/// padding (see `RepsterApp`). Zero everywhere else.
double statusBarFade() => measuredSafeArea().top > 0 ? 24 : 0;

/// Takes [statusBarFade] back out of the top padding for a screen whose
/// header is fine right under the status bar.
class WithoutStatusBarFade extends StatelessWidget {
  const WithoutStatusBarFade({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fade = statusBarFade();
    if (fade == 0) return child;
    final mq = MediaQuery.of(context);
    return MediaQuery(
      data: mq.copyWith(
        padding: mq.padding.copyWith(top: mq.padding.top - fade),
        viewPadding: mq.viewPadding.copyWith(top: mq.viewPadding.top - fade),
      ),
      child: child,
    );
  }
}
