import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/logging/app_logger.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Drives the two Android notifications tied to a rest period.
///
/// **Countdown** ([show]/[cancel]) — an ongoing, silent lock-screen
/// notification whose countdown is a *native chronometer* (`when` = the rest
/// end instant + `chronometerCountDown`). The system ticks it down with no Dart
/// timer, so it stays accurate while the app is backgrounded or the phone is
/// locked.
///
/// **End chime** ([scheduleRestDone]/[cancelRestDone]) — a notification
/// scheduled (via `zonedSchedule` + AlarmManager) to fire *with the rest-end
/// chime* at the exact end instant. This covers the case the in-app chime
/// cannot: the app is backgrounded/locked, so its Dart ticker is suspended.
/// The caller schedules it when leaving the foreground and cancels it on
/// return, so the audible cue never plays twice.
///
/// The scheduled sound uses the default *notification* audio usage: it ducks
/// the user's music (rather than blasting over it) and honours Do-Not-Disturb.
///
/// Android only; every method no-ops elsewhere and swallows failures — a
/// missing cue must never disrupt the session.
class RestNotifier {
  static const _channelId = 'rest_timer';
  static const _notificationId = 1001;
  static const _doneChannelId = 'rest_done';
  static const _doneNotificationId = 1002;
  static const _doneSound = 'rest_chime';
  static const _icon = 'ic_stat_rest';

  final _plugin = FlutterLocalNotificationsPlugin();

  /// Set once permission is granted and the channel exists.
  bool _available = false;
  Future<void>? _init;

  bool get _isAndroid => !kIsWeb && Platform.isAndroid;

  /// Lazily initializes the plugin, creates the channel and requests the
  /// Android 13+ notification permission. Safe to call repeatedly.
  Future<void> ensureInitialized() => _init ??= _doInit();

  Future<void> _doInit() async {
    if (!_isAndroid) return;
    try {
      // Needed by zonedSchedule. `local` defaults to UTC, which is fine here:
      // TZDateTime.from() preserves the absolute instant, so the alarm still
      // fires at the right moment regardless of the resolved zone.
      tz_data.initializeTimeZones();
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings(_icon),
        ),
      );
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      await android?.createNotificationChannel(
        AndroidNotificationChannel(
          _channelId,
          t.session.notif.countdownChannel,
          // Low importance: shows on the lock screen and in the shade without
          // a sound or heads-up — the audible cue is handled separately.
          importance: Importance.low,
          playSound: false,
          enableVibration: false,
        ),
      );
      await android?.createNotificationChannel(
        AndroidNotificationChannel(
          _doneChannelId,
          t.session.notif.doneChannel,
          importance: Importance.high,
          sound: const RawResourceAndroidNotificationSound(_doneSound),
        ),
      );
      final granted = await android?.requestNotificationsPermission();
      _available = granted ?? false;
    } on Object catch (e, st) {
      log.w('RestNotifier init failed', error: e, stackTrace: st);
    }
  }

  /// Posts (or updates) the ongoing rest notification counting down to
  /// [endsAt]. Calling again with a new [endsAt] updates the same notification
  /// in place (e.g. after "+30s").
  Future<void> show({required DateTime endsAt}) async {
    if (!_isAndroid) return;
    await ensureInitialized();
    if (!_available) return;
    try {
      await _plugin.show(
        id: _notificationId,
        title: t.session.rest.title,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            t.session.rest.title,
            icon: _icon,
            ongoing: true,
            autoCancel: false,
            onlyAlertOnce: true,
            silent: true,
            playSound: false,
            enableVibration: false,
            when: endsAt.millisecondsSinceEpoch,
            usesChronometer: true,
            chronometerCountDown: true,
            visibility: NotificationVisibility.public,
            color: AppColors.roseLight,
            category: AndroidNotificationCategory.stopwatch,
          ),
        ),
      );
    } on Object catch (e, st) {
      log.w('RestNotifier show failed', error: e, stackTrace: st);
    }
  }

  /// Removes the ongoing countdown notification (rest ended, skipped or session
  /// left).
  Future<void> cancel() async {
    if (!_isAndroid) return;
    try {
      await _plugin.cancel(id: _notificationId);
    } on Object catch (e, st) {
      log.w('RestNotifier cancel failed', error: e, stackTrace: st);
    }
  }

  /// Schedules the rest-end chime to fire at [endsAt] via AlarmManager, so it
  /// sounds even if the app is backgrounded/locked (its Dart ticker suspended).
  /// Call when leaving the foreground during rest; cancel with
  /// [cancelRestDone] on return so the chime never doubles with the in-app one.
  Future<void> scheduleRestDone({required DateTime endsAt}) async {
    if (!_isAndroid) return;
    await ensureInitialized();
    if (!_available) return;
    if (!endsAt.isAfter(DateTime.now())) return;
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _doneChannelId,
        t.session.notif.doneChannel,
        icon: _icon,
        // Sound is carried by the channel on Android 8+; set here too for
        // older versions where the notification carries it.
        sound: const RawResourceAndroidNotificationSound(_doneSound),
        category: AndroidNotificationCategory.alarm,
        visibility: NotificationVisibility.public,
        color: AppColors.roseLight,
      ),
    );
    final when = tz.TZDateTime.from(endsAt, tz.local);
    try {
      await _plugin.zonedSchedule(
        id: _doneNotificationId,
        title: t.session.notif.doneTitle,
        scheduledDate: when,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } on Object catch (e, st) {
      // Exact alarms may be disallowed (permission revoked); fall back to an
      // inexact one rather than losing the cue entirely.
      log.w(
        'RestNotifier exact schedule failed, retrying inexact',
        error: e,
        stackTrace: st,
      );
      try {
        await _plugin.zonedSchedule(
          id: _doneNotificationId,
          title: t.session.notif.doneTitle,
          scheduledDate: when,
          notificationDetails: details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      } on Object catch (e, st) {
        log.w('RestNotifier schedule failed', error: e, stackTrace: st);
      }
    }
  }

  /// Cancels the scheduled rest-end chime (rest ended in foreground, was
  /// skipped, or the app returned to the foreground).
  Future<void> cancelRestDone() async {
    if (!_isAndroid) return;
    try {
      await _plugin.cancel(id: _doneNotificationId);
    } on Object catch (e, st) {
      log.w('RestNotifier cancelRestDone failed', error: e, stackTrace: st);
    }
  }
}

/// Shared [RestNotifier]; cancels any lingering notification on dispose.
final restNotifierProvider = Provider<RestNotifier>((ref) {
  final notifier = RestNotifier();
  ref.onDispose(() {
    notifier
      ..cancel()
      ..cancelRestDone();
  });
  return notifier;
});
