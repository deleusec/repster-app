import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/workout_session.dart';

part 'live_session_state.freezed.dart';

/// Global status of the in-progress session, UI-side.
enum LiveSessionStatus { idle, loading, running, saving, finished }

/// Idle gap beyond which a session is no longer considered running: the open
/// segment is closed at the last action, and any later action opens a new one.
///
/// Longer than the longest rest anyone actually takes (so a slow set or a wait
/// for a busy machine never splits a session), shorter than a session itself.
const Duration kIdleGap = Duration(minutes: 30);

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

    /// Active time from segments already closed, in seconds. Only grows, when
    /// an action resumes a session that had gone idle.
    @Default(0) int bankedSeconds,

    /// Start of the open segment — the session's start, or the first action
    /// after an idle gap. `null` before the session starts.
    DateTime? segmentStartedAt,

    /// Last action performed in the session (a validated set, a changed load,
    /// an added exercise…). `null` before the session starts.
    DateTime? lastActivityAt,
  }) = _LiveSessionState;

  const LiveSessionState._();

  /// Seconds actually trained as of [now]: the closed segments plus the open
  /// one.
  ///
  /// Wall-clock time from the start would count everything that is not
  /// training — a session left open overnight came back as twelve hours. So an
  /// idle gap longer than [kIdleGap] closes the open segment at the last
  /// action: the clock stops where the training stopped, and stays there until
  /// something is actually done again.
  int activeSecondsAt(DateTime now) {
    final start = segmentStartedAt;
    if (start == null) return bankedSeconds;
    final last = lastActivityAt ?? start;
    final end = now.difference(last) > kIdleGap ? last : now;
    final span = end.difference(start).inSeconds;
    return bankedSeconds + (span > 0 ? span : 0);
  }

  static const empty = LiveSessionState(
    status: LiveSessionStatus.idle,
    currentExerciseIndex: 0,
    lastPerfs: {},
    lastPerfsMeta: {},
  );
}
