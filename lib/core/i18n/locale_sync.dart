import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// `user_metadata` key where the user's chosen language is persisted.
/// Shared between the writer (auth) and the reader (this provider).
const String kLanguageMetaKey = 'language';

/// Applies [code] as the current locale if it maps to a supported language
/// and differs from the active one. Also aligns `Intl.defaultLocale` for
/// date/number formatting.
void applyLocaleCode(String? code) {
  if (code == null) return;
  if (!AppLocaleUtils.supportedLocalesRaw.contains(code)) return;
  final locale = AppLocaleUtils.parse(code);
  if (locale == LocaleSettings.currentLocale) return;
  LocaleSettings.setLocaleSync(locale);
  Intl.defaultLocale = locale.languageCode;
}

/// Keeps the locale in sync with the user's `user_metadata.language` across
/// auth changes (login / logout / user update). Cold start is already handled
/// in `main()` before the first frame, so `fireImmediately` here is a no-op
/// (guarded by the equality check in [applyLocaleCode]) rather than a
/// locale mutation during the first build.
///
/// Must be kept alive (e.g. `ref.watch` in `RepsterApp`).
final localeSyncProvider = Provider<void>((ref) {
  ref.listen<User?>(currentUserProvider, (_, user) {
    final code = user?.userMetadata?[kLanguageMetaKey];
    if (code is String) applyLocaleCode(code);
  }, fireImmediately: true);
});
