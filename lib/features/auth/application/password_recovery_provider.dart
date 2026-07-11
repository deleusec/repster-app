import 'package:flutter_riverpod/flutter_riverpod.dart';

/// True while the user arrived through a password-recovery link and must set a
/// new password before doing anything else.
///
/// Set to `true` by the router auth listener on
/// `AuthChangeEvent.passwordRecovery`; the router then pins the user on
/// `/update-password` (a recovery session otherwise looks like a normal login
/// and would be redirected to the dashboard). Cleared once the password is
/// updated.
final passwordRecoveryProvider = StateProvider<bool>((ref) => false);
