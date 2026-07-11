import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/session/data/sessions_repository.dart';
import 'package:repster/features/session/domain/workout_session.dart';

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
