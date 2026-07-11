import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/error/app_exception.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/dashboard/data/dashboard_repository.dart';
import 'package:repster/features/dashboard/domain/dashboard_data.dart';
import 'package:repster/features/dashboard/domain/in_progress_session_info.dart';
import 'package:repster/features/session/data/sessions_repository.dart';
import 'package:repster/features/templates/data/templates_repository.dart';

const _maxActiveTemplatesPreview = 5;

/// Composes the dashboard from the authenticated user, active templates,
/// recent sessions and the in-progress session.
class DashboardController extends AsyncNotifier<DashboardData> {
  @override
  Future<DashboardData> build() async {
    final user = ref.watch(authControllerProvider).valueOrNull;
    if (user == null) {
      throw const AppAuthException(
        'Not authenticated',
        reason: AuthFailureReason.notSignedIn,
      );
    }
    return _fetch(user);
  }

  Future<DashboardData> _fetch(AuthUser user) async {
    final tplRepo = ref.read(templatesRepositoryProvider);
    final dashRepo = ref.read(dashboardRepositoryProvider);

    final tplsFut = tplRepo.fetchAll(onlyActive: true);
    final sessionsFut = dashRepo.fetchRecentSessions();
    final inProgressFut = dashRepo.fetchInProgress();

    final templates = await tplsFut;
    final sessions = await sessionsFut;
    final inProgress = await inProgressFut;

    return DashboardData(
      user: user,
      activeTemplates: List.unmodifiable(
        templates.take(_maxActiveTemplatesPreview),
      ),
      recentSessions: List.unmodifiable(sessions),
      inProgress: inProgress,
    );
  }

  Future<void> refresh() async {
    final user = ref.read(authControllerProvider).valueOrNull;
    if (user == null) return;
    state = const AsyncLoading<DashboardData>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _fetch(user));
  }

  /// Fresh read of the in-progress session (pre-flight check before starting a
  /// new one, from the session launch screen).
  Future<InProgressSessionInfo?> checkInProgress() =>
      ref.read(dashboardRepositoryProvider).fetchInProgress();

  /// Discards the persisted in-progress session, then refreshes the dashboard
  /// (the "in-progress" card disappears).
  Future<void> discardInProgress(String sessionId) async {
    await ref.read(sessionsRepositoryProvider).discardInProgress(sessionId);
    await refresh();
  }
}

final dashboardControllerProvider =
    AsyncNotifierProvider<DashboardController, DashboardData>(
      DashboardController.new,
    );
