import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:repster/app.dart';
import 'package:repster/core/config/env.dart';
import 'package:repster/core/error/error_handler.dart';
import 'package:repster/core/i18n/locale_sync.dart';
import 'package:repster/core/supabase/secure_local_storage.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  runZonedAppGuarded(() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    // Keep the native splash on screen during async bootstrap below.
    FlutterNativeSplash.preserve(widgetsBinding: binding);

    installGlobalErrorHandlers();
    Env.assertConfigured();

    // Initial language: detect the device locale among the supported ones
    // (English fallback handled by slang). Load date symbols for all supported
    // locales.
    LocaleSettings.useDeviceLocaleSync();
    await initializeDateFormatting();

    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
      authOptions: FlutterAuthClientOptions(
        // Stores the session (access + refresh token) encrypted via Keychain
        // (iOS) / EncryptedSharedPreferences (Android). Key matches the
        // Supabase format to stay aligned with the SDK.
        localStorage: SecureLocalStorage(
          persistSessionKey: _persistSessionKey(Env.supabaseUrl),
        ),
      ),
    );

    // Prefer the saved account language (user_metadata) over device detection,
    // BEFORE the first frame — so `localeSyncProvider` becomes a no-op on cold
    // start (its equality guard) instead of mutating the locale during the
    // first build (which races the web engine view setup).
    final savedLanguage = Supabase
        .instance
        .client
        .auth
        .currentUser
        ?.userMetadata?[kLanguageMetaKey];
    if (savedLanguage is String) applyLocaleCode(savedLanguage);
    Intl.defaultLocale = LocaleSettings.currentLocale.languageCode;

    runApp(
      ProviderScope(child: TranslationProvider(child: const RepsterApp())),
    );
    FlutterNativeSplash.remove();
  });
}

/// Reproduces the default key format used by `supabase_flutter`,
/// e.g. `sb-vbdyzcedymuafiozklze-auth-token`.
String _persistSessionKey(String supabaseUrl) {
  final host = Uri.parse(supabaseUrl).host.split('.').first;
  return 'sb-$host-auth-token';
}
