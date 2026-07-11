import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:repster/core/logging/app_logger.dart';

/// Installs global error handlers. Call once from `main` before `runApp`.
///
/// All three callbacks route through [AppLogger]. The single sink makes it
/// trivial to plug a remote reporter (Sentry, Glitchtip…) later.
void installGlobalErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    log.e(
      'FlutterError: ${details.exceptionAsString()}',
      error: details.exception,
      stackTrace: details.stack,
    );
    // In debug, let Flutter's rich report through (widget tree,
    // informationCollector, etc.) — essential for diagnosing an overflow or
    // other rendering error: the stack alone points only at the reporter,
    // not the offending widget.
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    log.e('PlatformDispatcher error', error: error, stackTrace: stack);
    return true;
  };
}

/// Wrap `runApp` to also catch async zone errors.
/// Usage in `main`:
/// ```dart
/// runZonedAppGuarded(() => runApp(const RepsterApp()));
/// ```
void runZonedAppGuarded(void Function() body) {
  runZonedGuarded(body, (Object error, StackTrace stack) {
    log.e('Uncaught zone error', error: error, stackTrace: stack);
  });
}
