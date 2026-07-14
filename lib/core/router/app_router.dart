import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:repster/core/router/routes.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/features/auth/application/password_recovery_provider.dart';
import 'package:repster/features/auth/presentation/change_password_screen.dart';
import 'package:repster/features/auth/presentation/forgot_password_screen.dart';
import 'package:repster/features/auth/presentation/login_screen.dart';
import 'package:repster/features/auth/presentation/onboarding_screen.dart';
import 'package:repster/features/auth/presentation/update_password_screen.dart';
import 'package:repster/features/auth/presentation/verify_email_screen.dart';
import 'package:repster/features/contact/presentation/contact_screen.dart';
import 'package:repster/features/dashboard/presentation/dashboard_screen.dart';
import 'package:repster/features/history/presentation/history_screen.dart';
import 'package:repster/features/history/presentation/session_detail_screen.dart';
import 'package:repster/features/legal/presentation/delete_account_screen.dart';
import 'package:repster/features/legal/presentation/privacy_screen.dart';
import 'package:repster/features/profile/presentation/profile_screen.dart';
import 'package:repster/features/session/presentation/session_screen.dart';
import 'package:repster/features/settings/presentation/settings_screen.dart';
import 'package:repster/features/stats/presentation/stats_screen.dart';
import 'package:repster/features/templates/presentation/template_detail_screen.dart';
import 'package:repster/features/templates/presentation/template_edit_screen.dart';
import 'package:repster/features/templates/presentation/templates_screen.dart';
import 'package:repster/shared/widgets/tab_bar_scaffold.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthChangeEvent;

final _rootNavigatorKey = GlobalKey<NavigatorState>();

const _publicAuthPaths = <String>{
  Routes.login,
  Routes.verifyEmail,
  Routes.forgotPassword,
  Routes.updatePassword,
};

/// Informational pages reachable regardless of auth state (logged in or not).
/// The privacy policy must be publicly accessible without signing in — Google
/// Play requires a public privacy policy URL.
const _publicPaths = <String>{
  Routes.privacy,
  Routes.deleteAccount,
};

final goRouterProvider = Provider<GoRouter>((ref) {
  final refresh = _AuthRefreshNotifier(ref);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.dashboard,
    debugLogDiagnostics: true,
    refreshListenable: refresh,
    redirect: (context, state) {
      final user = ref.read(supabaseClientProvider).auth.currentUser;
      final loggedIn = user != null;
      final path = state.matchedLocation;
      final isAuth = _publicAuthPaths.contains(path);
      final isPublic = _publicPaths.contains(path);
      final isOnboarding = path == Routes.onboarding;

      // Not logged in → block everything except auth + public info routes.
      if (!loggedIn) {
        return (isAuth || isPublic) ? null : Routes.login;
      }

      // Password recovery: the reset link produced a valid session, so the
      // user looks "logged in", but they must set a new password first. Pin
      // them on the update-password screen until it is done.
      if (ref.read(passwordRecoveryProvider)) {
        return path == Routes.updatePassword ? null : Routes.updatePassword;
      }

      // Logged in → keep auth screens out of reach.
      if (isAuth) return Routes.dashboard;

      // Onboarding required when the `full_name` metadata is missing.
      final fullName = user.userMetadata?['full_name'] as String?;
      final hasFullName = fullName != null && fullName.trim().isNotEmpty;
      if (!hasFullName && !isOnboarding && !isPublic) return Routes.onboarding;
      if (hasFullName && isOnboarding) return Routes.dashboard;

      return null;
    },
    routes: [
      // ── Public auth ──────────────────────────────────────────────────────
      GoRoute(path: Routes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: Routes.verifyEmail,
        builder: (_, state) =>
            VerifyEmailScreen(email: state.uri.queryParameters['email']),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (_, _) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: Routes.updatePassword,
        builder: (_, _) => const UpdatePasswordScreen(),
      ),

      // ── Onboarding (outside the shell, but authenticated) ────────────────
      GoRoute(
        path: Routes.onboarding,
        builder: (_, _) => const OnboardingScreen(),
      ),

      // ── Root-level routes (outside the tab bar) ──────────────────────────
      GoRoute(
        path: Routes.profile,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const ProfileScreen(),
      ),
      GoRoute(
        path: Routes.contact,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const ContactScreen(),
      ),
      GoRoute(
        path: Routes.privacy,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const PrivacyScreen(),
      ),
      GoRoute(
        path: Routes.deleteAccount,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const DeleteAccountScreen(),
      ),
      GoRoute(
        path: Routes.changePassword,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const ChangePasswordScreen(),
      ),

      // ── Live session fullscreen, on the root navigator ───────────────────
      GoRoute(
        path: Routes.sessionPattern,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => SessionScreen(
          templateId: state.pathParameters['templateId']!,
          resume: state.uri.queryParameters['resume'] == '1',
        ),
      ),

      // ── Main shell — 5 tabs, per-branch state ────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            TabBarScaffold(navigationShell: navigationShell),
        branches: [
          // 1. Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.dashboard,
                builder: (_, _) => const DashboardScreen(),
              ),
            ],
          ),
          // 2. Templates (with new / detail / edit sub-routes)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.templates,
                builder: (_, _) => const TemplatesScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    builder: (_, _) => const TemplateEditScreen(),
                  ),
                  GoRoute(
                    path: Routes.templateDetailPattern,
                    builder: (_, state) =>
                        TemplateDetailScreen(id: state.pathParameters['id']!),
                    routes: [
                      GoRoute(
                        path: 'edit',
                        builder: (_, state) => TemplateEditScreen(
                          templateId: state.pathParameters['id'],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // 3. History (with detail sub-route)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.history,
                builder: (_, _) => const HistoryScreen(),
                routes: [
                  GoRoute(
                    path: Routes.sessionDetailPattern,
                    builder: (_, state) => SessionDetailScreen(
                      sessionId: state.pathParameters['sessionId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // 4. Stats
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.stats,
                builder: (_, _) => const StatsScreen(),
              ),
            ],
          ),
          // 5. Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings,
                builder: (_, _) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    ref.listen(authStateChangesProvider, (_, next) {
      // A recovery link (email → app) surfaces as this event. Flag it so the
      // redirect guard pins the user on /update-password.
      if (next.value?.event == AuthChangeEvent.passwordRecovery) {
        ref.read(passwordRecoveryProvider.notifier).state = true;
      }
      notifyListeners();
    });
  }
}
