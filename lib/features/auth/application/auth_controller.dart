import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/logging/app_logger.dart';
import 'package:repster/features/auth/data/auth_repository.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/auth/domain/auth_user_goal.dart';

/// Source of truth for the current user on the UI side. Bootstraps from the
/// repository, then updates on every auth event (login / logout / `userUpdated`).
class AuthController extends AsyncNotifier<AuthUser?> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  Future<AuthUser?> build() async {
    // Recompute the user on every significant auth change. Supabase event
    // classification lives in `data/`; this notifier only handles the domain
    // type [AuthUser].
    ref.listen<AsyncValue<AuthUser?>>(authUserChangesProvider, (_, next) {
      next.whenData((user) => state = AsyncData<AuthUser?>(user));
    });
    return _repo.currentUser();
  }

  // Actions exposed to the screens.

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading<AuthUser?>().copyWithPrevious(state);
    try {
      final user = await _repo.signInWithPassword(
        email: email,
        password: password,
      );
      state = AsyncData<AuthUser?>(user);
    } on Object catch (e, st) {
      state = AsyncError<AuthUser?>(e, st).copyWithPrevious(state);
      rethrow;
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String language,
  }) async {
    state = const AsyncLoading<AuthUser?>().copyWithPrevious(state);
    try {
      await _repo.signUp(email: email, password: password, language: language);
      // Stay signed out until the OTP is verified.
      state = AsyncData<AuthUser?>(_repo.currentUser());
    } on Object catch (e, st) {
      state = AsyncError<AuthUser?>(e, st).copyWithPrevious(state);
      rethrow;
    }
  }

  Future<void> verifyEmailOtp({
    required String email,
    required String token,
  }) async {
    state = const AsyncLoading<AuthUser?>().copyWithPrevious(state);
    try {
      final user = await _repo.verifyEmailOtp(email: email, token: token);
      state = AsyncData<AuthUser?>(user);
    } on Object catch (e, st) {
      state = AsyncError<AuthUser?>(e, st).copyWithPrevious(state);
      rethrow;
    }
  }

  Future<void> resendSignupOtp(String email) => _repo.resendSignupOtp(email);

  Future<void> sendPasswordReset(String email) =>
      _repo.sendPasswordReset(email);

  Future<void> updatePassword(String newPassword) =>
      _repo.updatePassword(newPassword);

  /// Changes the password of a signed-in user (re-authentication + update).
  /// See [AuthRepository.changePassword].
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) => _repo.changePassword(
    currentPassword: currentPassword,
    newPassword: newPassword,
  );

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AsyncData<AuthUser?>(null);
  }

  /// Completes onboarding or edits the profile. All values are optional; only
  /// non-null keys are patched.
  Future<void> updateProfile({
    String? fullName,
    String? bio,
    String? avatarUrl,
    double? heightCm,
    double? weightKg,
    DateTime? birthdate,
    AuthUserGoal? goal,
    bool clearAvatar = false,
  }) async {
    final patch = <String, Object?>{
      if (fullName != null) 'full_name': fullName,
      if (bio != null) 'bio': bio,
      if (avatarUrl != null) 'avatar': avatarUrl,
      if (clearAvatar) 'avatar': null,
      if (heightCm != null) 'height': heightCm,
      if (weightKg != null) 'weight': weightKg,
      if (birthdate != null)
        'birthdate': birthdate.toIso8601String().substring(0, 10),
      if (goal != null) 'goal': goal.toMetadataValue(),
    };
    if (patch.isEmpty) return;
    final user = await _repo.updateUserMetadata(patch);
    state = AsyncData<AuthUser?>(user);
  }

  /// Persists the chosen language in `user_metadata.language` (best-effort,
  /// orchestrated by `LanguageController` which updates the UI first). A `null`
  /// [languageCode] clears the preference (falls back to the device language).
  Future<void> updateLanguage(String? languageCode) async {
    final user = await _repo.updateUserMetadata({'language': languageCode});
    state = AsyncData<AuthUser?>(user);
  }

  /// Uploads [bytes] as the new avatar, then persists the URL in the profile.
  Future<void> setAvatar(Uint8List bytes) async {
    final url = await _repo.uploadAvatar(bytes);
    await updateProfile(avatarUrl: url);
  }

  /// Removes the avatar: the storage object first, then the reference to it.
  ///
  /// That order is deliberate. If the delete throws, nothing has changed and
  /// the caller surfaces an error — better than clearing the reference and
  /// leaving an orphan JPEG readable by URL in a public bucket, which is
  /// exactly what the privacy policy says we do not do.
  ///
  /// A delete that removes nothing is not an error (the file may already be
  /// gone), but it is worth a line in the log: the other explanation is a
  /// missing storage DELETE policy, and that one is a silent privacy bug.
  Future<void> removeAvatar() async {
    final removed = await _repo.deleteAvatar();
    if (!removed) {
      log.w(
        'removeAvatar: no avatar object deleted — already gone, or the '
        'storage DELETE policy is missing on the avatars bucket',
      );
    }
    await updateProfile(clearAvatar: true);
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, AuthUser?>(
  AuthController.new,
);
