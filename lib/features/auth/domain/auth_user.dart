import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/features/auth/domain/auth_user_goal.dart';

part 'auth_user.freezed.dart';

/// User profile model — projection of the Supabase metadata
/// (`auth.users.user_metadata`) stored directly on the user.
///
/// Pure Dart, freezed. Built by `AuthRepository.currentUser()`.
@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String email,
    required DateTime joinedAt,
    String? fullName,
    String? avatarUrl,
    String? bio,
    double? heightCm,
    double? weightKg,
    DateTime? birthdate,
    AuthUserGoal? goal,
  }) = _AuthUser;

  const AuthUser._();

  /// True once onboarding is complete (full_name present).
  bool get hasCompletedOnboarding =>
      fullName != null && fullName!.trim().isNotEmpty;

  /// First name derived from `fullName` (first token). Empty if absent.
  String get firstName {
    final name = fullName?.trim() ?? '';
    if (name.isEmpty) return '';
    final space = name.indexOf(' ');
    return space < 0 ? name : name.substring(0, space);
  }
}
