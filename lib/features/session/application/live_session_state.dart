import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/workout_session.dart';

part 'live_session_state.freezed.dart';

/// Global status of the in-progress session, UI-side.
enum LiveSessionStatus { idle, loading, running, saving, finished }

/// State of the `LiveSessionController`. Kept in memory (plus a debounced
/// Supabase snapshot) until the session ends.
///
/// Rest is represented as a start instant plus a total duration: the UI
/// computes the remaining time on each tick, which stays accurate even if the
/// app is backgrounded.
@freezed
class LiveSessionState with _$LiveSessionState {
  const factory LiveSessionState({
    required LiveSessionStatus status,
    required int currentExerciseIndex,

    /// Latest perfs keyed by `name:target`, one entry per set.
    required Map<String, List<LastPerf>> lastPerfs,
    required Map<String, LastPerfMeta> lastPerfsMeta,
    @Default(false) bool isResting,
    DateTime? restStartedAt,
    @Default(0) int restTotalSeconds,

    /// Exercise index to return to when rest ends (back to the first exercise
    /// of a superset block at the start of the next round).
    int? restReturnTo,
    WorkoutSession? session,
    String? error,
  }) = _LiveSessionState;

  const LiveSessionState._();

  static const empty = LiveSessionState(
    status: LiveSessionStatus.idle,
    currentExerciseIndex: 0,
    lastPerfs: {},
    lastPerfsMeta: {},
  );
}
