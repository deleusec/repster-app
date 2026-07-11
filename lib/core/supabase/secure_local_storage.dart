import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [LocalStorage] adapter backed by [FlutterSecureStorage] so that the
/// Supabase session blob (which contains the refresh token) is stored encrypted
/// at rest:
///
///   - iOS / macOS : Keychain (`first_unlock`, accessible after the first
///     unlock post-boot — the app can refresh its token in the background
///     without asking the user to unlock the device every time).
///   - Android     : EncryptedSharedPreferences (AES key in the Keystore).
///   - Linux / Web : fallback handled by the package (libsecret / encrypted
///     IndexedDB). The repo targets mobile first; the fallback is enough for
///     desktop dev.
///
/// `persistSessionKey` follows the Supabase format (`sb-<host>-auth-token`) to
/// stay compatible with the rest of the SDK and ease debug introspection.
class SecureLocalStorage extends LocalStorage {
  SecureLocalStorage({required this.persistSessionKey});

  final String persistSessionKey;

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> hasAccessToken() async {
    return _storage.containsKey(key: persistSessionKey);
  }

  @override
  Future<String?> accessToken() {
    return _storage.read(key: persistSessionKey);
  }

  @override
  Future<void> removePersistedSession() {
    return _storage.delete(key: persistSessionKey);
  }

  @override
  Future<void> persistSession(String persistSessionString) {
    return _storage.write(key: persistSessionKey, value: persistSessionString);
  }
}
