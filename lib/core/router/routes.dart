/// Path constants for go_router. Use these instead of inlining strings —
/// renames stay typesafe.
class Routes {
  const Routes._();

  // ── Public auth ───────────────────────────────────────────────────────────
  static const String login = '/login';
  static const String verifyEmail = '/verify-email';
  static const String forgotPassword = '/forgot-password';
  static const String updatePassword = '/update-password';

  /// Password change from settings (logged-in user).
  static const String changePassword = '/change-password';

  // ── Onboarding (required once per user) ───────────────────────────────────
  static const String onboarding = '/onboarding';

  // ── Tab shell branches ────────────────────────────────────────────────────
  static const String dashboard = '/dashboard';
  static const String templates = '/templates';
  static const String history = '/history';
  static const String stats = '/stats';
  static const String settings = '/settings';

  // ── Sub-routes (within their tab branch) ──────────────────────────────────
  static const String templateNew = '/templates/new';
  static const String _templatesBase = '/templates';
  static String templateDetail(String id) => '$_templatesBase/$id';
  static String templateEdit(String id) => '$_templatesBase/$id/edit';
  static const String templateDetailPattern = ':id';
  static const String templateEditPattern = ':id/edit';

  static const String _historyBase = '/history';
  static String sessionDetail(String sessionId) => '$_historyBase/$sessionId';
  static const String sessionDetailPattern = ':sessionId';

  // ── Root-level routes (no tab bar) ────────────────────────────────────────
  static const String profile = '/profile';
  static const String contact = '/contact';
  static const String privacy = '/privacy';
  static const String deleteAccount = '/delete-account';

  static const String _session = '/session';
  static String session(String templateId, {bool resume = false}) =>
      resume ? '$_session/$templateId?resume=1' : '$_session/$templateId';
  static const String sessionPattern = '$_session/:templateId';
}
