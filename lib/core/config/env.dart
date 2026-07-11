/// Compile-time environment variables.
///
/// Injected via `--dart-define-from-file=.env`
/// (or per-key `--dart-define=KEY=value`).
/// Missing or empty values fail loudly at startup via [assertConfigured].
class Env {
  const Env._();

  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
  );

  /// Call once at startup to validate required keys are present.
  static void assertConfigured() {
    _required('SUPABASE_URL', supabaseUrl);
    _required('SUPABASE_ANON_KEY', supabaseAnonKey);
  }

  static void _required(String key, String value) {
    if (value.isEmpty) {
      throw StateError(
        'Missing required env var: $key. '
        'Pass it via --dart-define-from-file=.env '
        'or --dart-define=$key=...',
      );
    }
  }
}
