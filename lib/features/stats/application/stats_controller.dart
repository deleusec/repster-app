import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:repster/features/session/data/sessions_repository.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/stats/domain/stats_data.dart';
import 'package:repster/features/stats/domain/stats_range.dart';

/// Currently displayed range — drives stats recomputation.
final statsRangeProvider = StateProvider<StatsRange>(
  (ref) => StatsRange.last4Weeks,
);

/// Single source: full sessions, fetched once. Changing the range recomputes
/// locally without a new request.
final statsSessionsProvider = FutureProvider<List<WorkoutSession>>((ref) {
  return ref.read(sessionsRepositoryProvider).fetchHistorySessions();
});

/// Derived aggregate: recomputed on every range or data change.
final statsControllerProvider = Provider<AsyncValue<StatsData>>((ref) {
  final range = ref.watch(statsRangeProvider);
  final sessions = ref.watch(statsSessionsProvider);
  return sessions.whenData(
    (all) => StatsData.compute(all: all, range: range, now: DateTime.now()),
  );
});
