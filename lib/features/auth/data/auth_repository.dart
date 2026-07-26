import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/logging/app_logger.dart';
import 'package:repster/core/supabase/auth_redirect.dart';
import 'package:repster/core/supabase/postgrest_error_x.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/auth/domain/auth_user_goal.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// Auth repository — adapter between Supabase Auth and the [AuthUser] domain.
/// Converts every return value to a domain type and maps errors via
/// [mapSupabaseError]. No Flutter widgets or Riverpod here.
class AuthRepository {
  AuthRepository(this._client);

  final sb.SupabaseClient _client;

  /// Current user projected as [AuthUser], or `null` if signed out.
  AuthUser? currentUser() {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return _mapUser(user);
  }

  /// Emits the domain user on every *significant* auth change:
  /// sign-in / update / token refresh → the current [AuthUser];
  /// sign-out / deletion → `null`. Irrelevant events (initial session,
  /// password recovery, MFA) are filtered out.
  ///
  /// Supabase `AuthChangeEvent` classification stays confined here: the
  /// application layer only consumes the domain type [AuthUser].
  Stream<AuthUser?> onAuthUserChanged() {
    return _client.auth.onAuthStateChange.expand<AuthUser?>((state) {
      switch (state.event) {
        case sb.AuthChangeEvent.signedIn:
        case sb.AuthChangeEvent.userUpdated:
        case sb.AuthChangeEvent.tokenRefreshed:
          return [currentUser()];
        case sb.AuthChangeEvent.signedOut:
        // `userDeleted` is deprecated by supabase_flutter but still in the
        // enum — covered here for exhaustiveness.
        // ignore: deprecated_member_use
        case sb.AuthChangeEvent.userDeleted:
          return [null];
        case sb.AuthChangeEvent.passwordRecovery:
        case sb.AuthChangeEvent.initialSession:
        case sb.AuthChangeEvent.mfaChallengeVerified:
          return const [];
      }
    });
  }

  Future<AuthUser> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = res.user;
      if (user == null) {
        throw const AppAuthException(
          'Supabase response without a user',
          reason: AuthFailureReason.invalidCredentials,
        );
      }
      return _mapUser(user);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _client.auth.signUp(email: email, password: password);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<AuthUser> verifyEmailOtp({
    required String email,
    required String token,
  }) async {
    try {
      final res = await _client.auth.verifyOTP(
        email: email,
        token: token,
        type: sb.OtpType.signup,
      );
      final user = res.user;
      if (user == null) {
        throw const AppAuthException(
          'Code OTP invalide',
          reason: AuthFailureReason.invalidCredentials,
        );
      }
      return _mapUser(user);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<void> resendSignupOtp(String email) async {
    try {
      await _client.auth.resend(email: email, type: sb.OtpType.signup);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email,
        // Sends the user back to the local app (web origin / mobile scheme)
        // instead of the project Site URL. Must match a dashboard allow-list
        // entry. See [authRedirectUrl].
        redirectTo: authRedirectUrl(),
      );
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Sets a new password for the current user (recovery flow: the session
  /// already comes from the reset link).
  Future<void> updatePassword(String newPassword) async {
    try {
      await _client.auth.updateUser(sb.UserAttributes(password: newPassword));
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Changes the password of a signed-in user from the settings.
  ///
  /// Supabase exposes no direct way to verify the current password, so we
  /// re-authenticate via [signInWithPassword] (which validates
  /// [currentPassword] and refreshes the session) before calling `updateUser`.
  /// A credentials error here means "current password incorrect" (reason
  /// [AuthFailureReason.invalidCredentials]).
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _client.auth.currentUser;
    final email = user?.email;
    if (user == null || email == null || email.isEmpty) {
      throw const AppAuthException(
        'Not signed in',
        reason: AuthFailureReason.notSignedIn,
      );
    }

    // 1. Re-authenticate — verifies the current password.
    try {
      await _client.auth.signInWithPassword(
        email: email,
        password: currentPassword,
      );
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }

    // 2. Apply the new password.
    try {
      await _client.auth.updateUser(sb.UserAttributes(password: newPassword));
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Uploads the avatar to the `avatars` bucket (path `<uid>/avatar.jpg`,
  /// upsert) and returns the public URL with a cache-buster.
  Future<String> uploadAvatar(Uint8List bytes) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw const AppAuthException(
        'Not signed in',
        reason: AuthFailureReason.notSignedIn,
      );
    }
    try {
      final path = '$userId/avatar.jpg';
      await _client.storage
          .from('avatars')
          .uploadBinary(
            path,
            bytes,
            fileOptions: const sb.FileOptions(
              upsert: true,
              contentType: 'image/jpeg',
            ),
          );
      final url = _client.storage.from('avatars').getPublicUrl(path);
      final stamp = DateTime.now().millisecondsSinceEpoch;
      return '$url?t=$stamp';
    } catch (e, st) {
      log.w('uploadAvatar failed', error: e, stackTrace: st);
      throw mapSupabaseError(e, st);
    }
  }

  /// Deletes the avatar object itself, not just the reference to it. The
  /// bucket is public, so leaving the JPEG behind would keep it reachable by
  /// URL after the user asked for it to be removed — see the privacy policy.
  ///
  /// Returns whether an object was actually removed. Storage answers a denied
  /// or unmatched delete with an empty list rather than an error, so the
  /// caller cannot rely on "no exception" meaning "the file is gone".
  Future<bool> deleteAvatar() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw const AppAuthException(
        'Not signed in',
        reason: AuthFailureReason.notSignedIn,
      );
    }
    try {
      final removed = await _client.storage.from('avatars').remove([
        '$userId/avatar.jpg',
      ]);
      return removed.isNotEmpty;
    } catch (e, st) {
      log.w('deleteAvatar failed', error: e, stackTrace: st);
      throw mapSupabaseError(e, st);
    }
  }

  /// Updates `auth.users.user_metadata` (partial PATCH — merged server-side).
  /// Returns the rebuilt user.
  Future<AuthUser> updateUserMetadata(Map<String, Object?> patch) async {
    try {
      // Local merge to preserve keys the caller does not mention.
      final current = _client.auth.currentUser?.userMetadata ?? const {};
      final merged = <String, Object?>{...current, ...patch};
      final res = await _client.auth.updateUser(
        sb.UserAttributes(data: merged),
      );
      final user = res.user;
      if (user == null) {
        throw const AppAuthException('Profile update failed');
      }
      return _mapUser(user);
    } catch (e, st) {
      log.w('updateUserMetadata failed', error: e, stackTrace: st);
      throw mapSupabaseError(e, st);
    }
  }

  // Private Supabase → domain mapping.

  AuthUser _mapUser(sb.User user) {
    final meta = user.userMetadata ?? const <String, dynamic>{};
    return AuthUser(
      id: user.id,
      email: user.email ?? '',
      joinedAt: DateTime.parse(user.createdAt),
      fullName: meta['full_name'] as String?,
      avatarUrl: meta['avatar'] as String? ?? meta['avatar_url'] as String?,
      bio: meta['bio'] as String?,
      heightCm: _toDouble(meta['height']),
      weightKg: _toDouble(meta['weight']),
      birthdate: _toDate(meta['birthdate']),
      goal: AuthUserGoal.fromMetadataValue(meta['goal']),
    );
  }

  double? _toDouble(Object? v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v);
    return null;
  }

  DateTime? _toDate(Object? v) {
    if (v == null) return null;
    if (v is String) return DateTime.tryParse(v);
    return null;
  }
}

/// Instantiation provider — injected into the application notifiers.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(supabaseClientProvider));
});

/// Stream of the current user (domain type) on every auth change. Replaces
/// listening to the raw Supabase stream directly in the application layer.
final authUserChangesProvider = StreamProvider<AuthUser?>((ref) {
  return ref.watch(authRepositoryProvider).onAuthUserChanged();
});
