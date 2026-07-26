import 'dart:io';

import 'package:repster/core/error/app_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Converts raw Supabase / network errors into typed [AppException]s.
/// Call from `data/` repositories at the boundary, never elsewhere.
///
/// ```dart
/// try {
///   final res = await supabase.from('templates').select();
///   return res.map(TemplateDto.fromJson).toList();
/// } on Object catch (e, st) {
///   throw mapSupabaseError(e, st);
/// }
/// ```
AppException mapSupabaseError(Object error, [StackTrace? stackTrace]) {
  if (error is AppException) return error;

  if (error is AuthException) {
    return _mapAuth(error, stackTrace);
  }

  if (error is PostgrestException) {
    // PGRST116: returned 0 rows when 1 expected
    if (error.code == 'PGRST116') {
      return NotFoundException(
        error.message,
        cause: error,
        stackTrace: stackTrace,
      );
    }
    return UnexpectedException(
      'Database error: ${error.message}',
      cause: error,
      stackTrace: stackTrace,
    );
  }

  if (error is SocketException) {
    return NetworkException(
      'Network unreachable',
      cause: error,
      stackTrace: stackTrace,
    );
  }

  return UnexpectedException(
    error.toString(),
    cause: error,
    stackTrace: stackTrace,
  );
}

AppAuthException _mapAuth(AuthException e, StackTrace? st) {
  final msg = e.message.toLowerCase();
  AuthFailureReason? reason;
  if (msg.contains('invalid login') || msg.contains('credentials')) {
    reason = AuthFailureReason.invalidCredentials;
  } else if (msg.contains('email not confirmed')) {
    reason = AuthFailureReason.emailNotConfirmed;
  } else if (msg.contains('already registered') || msg.contains('exists')) {
    reason = AuthFailureReason.userAlreadyExists;
  } else if (msg.contains('expired')) {
    reason = AuthFailureReason.sessionExpired;
  }
  return AppAuthException(e.message, reason: reason, cause: e, stackTrace: st);
}
