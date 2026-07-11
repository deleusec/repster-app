/// Typed application exceptions. Raised by repositories at the Supabase
/// boundary so the rest of the app never sees raw `PostgrestException` or
/// `SocketException`.
sealed class AppException implements Exception {
  const AppException(this.message, {this.cause, this.stackTrace});

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  String get _name => switch (this) {
    NetworkException() => 'NetworkException',
    AppAuthException() => 'AppAuthException',
    ValidationException() => 'ValidationException',
    NotFoundException() => 'NotFoundException',
    UnexpectedException() => 'UnexpectedException',
  };

  @override
  String toString() => '$_name: $message';
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.cause, super.stackTrace});
}

class AppAuthException extends AppException {
  const AppAuthException(
    super.message, {
    this.reason,
    super.cause,
    super.stackTrace,
  });
  final AuthFailureReason? reason;
}

enum AuthFailureReason {
  notSignedIn,
  invalidCredentials,
  sessionExpired,
  emailNotConfirmed,
  userAlreadyExists,
}

class ValidationException extends AppException {
  const ValidationException(
    super.message, {
    this.field,
    super.cause,
    super.stackTrace,
  });
  final String? field;
}

class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.cause, super.stackTrace});
}

class UnexpectedException extends AppException {
  const UnexpectedException(super.message, {super.cause, super.stackTrace});
}
