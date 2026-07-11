import 'package:repster/core/error/app_exception.dart';
import 'package:repster/i18n/translations.g.dart';

/// Converts any error into a readable, translated user-facing message,
/// leveraging the typed [AppException] hierarchy when available.
///
/// For **per-field** errors (`ValidationException(field: 'email')`), use
/// [validationFieldError]: it returns the exception's `field` when present.
///
/// Any other exception type goes through a string-match fallback (useful for
/// Supabase `AuthException`s that still surface in cleartext when a repository
/// hasn't mapped them).
String humanizeAppError(Object error) {
  if (error is AppException) {
    return switch (error) {
      NetworkException() => t.errors.network,
      AppAuthException(:final reason) => _humanizeAuthReason(
        reason,
        error.message,
      ),
      ValidationException() => error.message,
      NotFoundException() => t.errors.notFound,
      UnexpectedException() => t.errors.generic,
    };
  }
  return _fallbackHumanize(error);
}

/// Returns the field name carried by a [ValidationException], or `null`.
/// Lets the error show on the right `AppTextField` rather than globally.
String? validationFieldError(Object error) {
  if (error is ValidationException) return error.field;
  return null;
}

String _humanizeAuthReason(AuthFailureReason? reason, String fallback) {
  return switch (reason) {
    AuthFailureReason.invalidCredentials => t.errors.auth.invalidCredentials,
    AuthFailureReason.emailNotConfirmed => t.errors.auth.emailNotConfirmed,
    AuthFailureReason.userAlreadyExists => t.errors.auth.userAlreadyExists,
    AuthFailureReason.sessionExpired => t.errors.auth.sessionExpired,
    AuthFailureReason.notSignedIn => t.errors.auth.notSignedIn,
    null => fallback.isEmpty ? t.errors.generic : _fallbackHumanize(fallback),
  };
}

String _fallbackHumanize(Object error) {
  final msg = error.toString().toLowerCase();
  if (msg.contains('credential') || msg.contains('invalid login')) {
    return t.errors.auth.invalidCredentials;
  }
  if (msg.contains('email not confirmed')) {
    return t.errors.auth.emailNotConfirmed;
  }
  if (msg.contains('already registered') || msg.contains('exists')) {
    return t.errors.auth.userAlreadyExists;
  }
  if (msg.contains('otp') || msg.contains('token')) {
    return t.errors.invalidCode;
  }
  if (msg.contains('different from the old') ||
      msg.contains('should be different')) {
    return t.errors.passwordSameAsOld;
  }
  if (msg.contains('network') || msg.contains('socket')) {
    return t.errors.network;
  }
  return t.errors.generic;
}
