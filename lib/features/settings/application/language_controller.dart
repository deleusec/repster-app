import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:repster/core/logging/app_logger.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/stats/application/stats_controller.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/i18n/translations.g.dart';

/// Drives language changes from the UI (Settings picker).
///
/// Updates the UI immediately (slang + intl), then persists the choice to
/// `user_metadata.language` (best-effort: if the user is signed out or offline,
/// the network failure doesn't block the local change).
class LanguageController {
  const LanguageController(this._ref);

  final Ref _ref;

  /// Applies a specific language chosen by the user.
  Future<void> setLanguage(AppLocale locale) async {
    LocaleSettings.setLocaleSync(locale);
    _invalidateLocalizedData();
    await _persist(locale.languageCode);
  }

  /// Reverts to the device language ("System default"): clears the stored
  /// preference and applies detection.
  Future<void> useSystemLanguage() async {
    LocaleSettings.useDeviceLocaleSync();
    _invalidateLocalizedData();
    await _persist(null);
  }

  /// Drops the caches whose rows carry a certified exercise's display name.
  ///
  /// Those names are resolved at fetch time from the locale, not by slang, so a
  /// rebuild alone leaves them in the previous language until something else
  /// happens to refetch — a template still reading `Panca piana` after a switch
  /// to French.
  void _invalidateLocalizedData() {
    _ref
      ..invalidate(templatesControllerProvider)
      ..invalidate(statsSessionsProvider)
      ..invalidate(sessionByIdProvider);
  }

  /// Aligns intl, then persists (best-effort) the language code — `null` clears
  /// the account-side preference.
  Future<void> _persist(String? languageCode) async {
    Intl.defaultLocale = LocaleSettings.currentLocale.languageCode;
    if (_ref.read(currentUserProvider) == null) return;
    try {
      await _ref
          .read(authControllerProvider.notifier)
          .updateLanguage(languageCode);
    } on Object catch (e, st) {
      log.w('Persist language failed', error: e, stackTrace: st);
    }
  }
}

final languageControllerProvider = Provider<LanguageController>(
  LanguageController.new,
);
