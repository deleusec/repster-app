import 'package:repster/i18n/translations.g.dart';

/// Validators reused across the auth screens (login, signup, forgot, etc.).
/// Return `null` when the value is valid, otherwise the error message.
///
/// Humanization of submit errors lives in
/// `core/error/humanize_error.dart` (`humanizeAppError`).
String? validateEmail(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return t.auth.validators.emailRequired;
  final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
  if (!ok) return t.auth.validators.emailInvalid;
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return t.auth.validators.passwordRequired;
  if (value.length < 8) return t.auth.validators.passwordMin;
  return null;
}

/// Confirmation: must match [other] and pass [validatePassword].
String? validatePasswordConfirm(String? value, String other) {
  final base = validatePassword(value);
  if (base != null) return base;
  if (value != other) return t.auth.validators.passwordMismatch;
  return null;
}
