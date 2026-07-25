import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/session/data/sessions_repository.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/stats/application/stats_controller.dart';

class HistoryController extends AsyncNotifier<List<WorkoutSessionSummary>> {
  @override
  Future<List<WorkoutSessionSummary>> build() {
    return ref.read(sessionsRepositoryProvider).fetchHistory();
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<WorkoutSessionSummary>>().copyWithPrevious(
      state,
    );
    state = await AsyncValue.guard(
      () => ref.read(sessionsRepositoryProvider).fetchHistory(),
    );
  }

  /// Edits a completed session's metadata. Changing the date reorders the
  /// history and moves the session between week groups, so the list is
  /// refetched rather than patched in place.
  Future<void> updateDetails({
    required String id,
    required String templateName,
    required DateTime startedAt,
    required int durationSeconds,
    required String notes,
  }) async {
    await ref
        .read(sessionsRepositoryProvider)
        .updateSessionDetails(
          sessionId: id,
          templateName: templateName,
          startedAt: startedAt,
          durationSeconds: durationSeconds,
          notes: notes,
        );
    // The duration and date feed the weekly stats and the dashboard as much as
    // the history list.
    ref
      ..invalidate(sessionByIdProvider(id))
      ..invalidate(dashboardControllerProvider)
      ..invalidate(statsSessionsProvider);
    await refresh();
  }

  /// Optimistic delete: remove the row immediately, then confirm on the
  /// server (and refetch on failure).
  Future<void> delete(String id) async {
    final current = state.valueOrNull ?? const [];
    state = AsyncData(current.where((s) => s.id != id).toList(growable: false));
    try {
      await ref.read(sessionsRepositoryProvider).deleteSession(id);
    } catch (_) {
      await refresh();
      rethrow;
    }
  }
}

final historyControllerProvider =
    AsyncNotifierProvider<HistoryController, List<WorkoutSessionSummary>>(
      HistoryController.new,
    );

final sessionByIdProvider = FutureProvider.family<WorkoutSession, String>(
  (ref, id) => ref.read(sessionsRepositoryProvider).fetchSessionById(id),
);
