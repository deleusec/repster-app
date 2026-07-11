import 'package:flutter/foundation.dart' show kIsWeb;

/// URL / deep link Supabase redirects to after an email action
/// (currently: password recovery). Whatever this returns MUST be present in
/// the Supabase dashboard "Redirect URLs" allow-list, otherwise Supabase
/// falls back to the project Site URL (the prod domain) and the link never
/// comes back to the local app.
///
/// - **Web**: the current origin, resolved at runtime —
///   `http://localhost:<port>` in dev (run on a fixed port, e.g.
///   `--web-port=3000`) and the deployed domain in prod. No env var needed.
/// - **Mobile**: a custom URL scheme registered natively (Android manifest
///   `intent-filter` / iOS `CFBundleURLTypes`).
String authRedirectUrl() {
  if (kIsWeb) return Uri.base.origin;
  return 'com.aevon.repster://reset-callback';
}
