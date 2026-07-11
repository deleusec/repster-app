import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Application-wide logger. Wraps `package:logger` so we can later
/// plug a remote sink (Sentry, Glitchtip…) in one place.
///
/// Use [AppLogger.instance] directly, or import the top-level [log] alias.
class AppLogger {
  AppLogger._()
    : _logger = Logger(
        filter: kReleaseMode ? ProductionFilter() : DevelopmentFilter(),
        printer: PrettyPrinter(
          methodCount: 0,
          printEmojis: false,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
      );

  static final AppLogger instance = AppLogger._();

  final Logger _logger;

  void d(Object? message) => _logger.d(message);
  void i(Object? message) => _logger.i(message);
  void w(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.w(message, error: error, stackTrace: stackTrace);
  void e(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}

/// Top-level shortcut: `log.i('hello')`.
final AppLogger log = AppLogger.instance;
