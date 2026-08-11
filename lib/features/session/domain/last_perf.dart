import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repster/core/exercises/exercise_name_key.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';

part 'last_perf.freezed.dart';
part 'last_perf.g.dart';

/// One set of a performance previously recorded on an exercise. Used to
/// pre-fill weights and to show the "last time" reference in session.
@freezed
class LastPerf with _$LastPerf {
  const factory LastPerf({
    required int reps,
    required double weight,
    int? seconds,
  }) = _LastPerf;

  const LastPerf._();

  factory LastPerf.fromJson(Map<String, Object?> json) =>
      _$LastPerfFromJson(json);
}

/// Context of the session a list of `LastPerf` comes from: when it happened
/// and what its first set was targeting. The target is informative only — it
/// never filters the lookup, it lets the UI flag "was aiming for 12 reps" when
/// today's format differs.
@freezed
class LastPerfMeta with _$LastPerfMeta {
  const factory LastPerfMeta({
    DateTime? performedAt,
    int? target,

    /// True when the reference comes from a past run of *this* workout. False
    /// means it was picked up from another workout, which the UI says out loud:
    /// the same exercise placed elsewhere in the week is not the same effort.
    @Default(false) bool fromSameWorkout,
  }) = _LastPerfMeta;

  const LastPerfMeta._();

  factory LastPerfMeta.fromJson(Map<String, Object?> json) =>
      _$LastPerfMetaFromJson(json);
}

/// Result of a last-perf lookup: one entry per set of the past session, plus
/// its context.
class ExerciseLastPerfResult {
  const ExerciseLastPerfResult({required this.perfs, required this.meta});

  final List<LastPerf> perfs;
  final LastPerfMeta meta;
}

/// One past session offered as the reference for one [lastPerfKey].
class LastPerfCandidate {
  const LastPerfCandidate({
    required this.key,
    required this.perfs,
    required this.performedAt,
    required this.target,
    required this.fromSameWorkout,
    required this.matchesTarget,
  });

  final String key;
  final List<LastPerf> perfs;
  final DateTime performedAt;

  /// What that session was aiming for — `null` when it was not recorded.
  final int? target;

  /// The session was a past run of the workout being started.
  final bool fromSameWorkout;

  /// That session aimed for what today aims for. False when either side is
  /// unknown: "cannot tell" is not a match.
  final bool matchesTarget;
}

/// Best reference per key among [candidates], which must be ordered most
/// recent first.
///
/// Ranking, strongest first:
///   1. same workout, same target
///   2. same workout
///   3. same target
///   4. anything
///
/// (1) and (2) come first because the same exercise placed in two different
/// workouts is not done with the same freshness. (3) is what stops a program
/// alternating a 5-rep and a 10-rep day from handing one the other's load — and
/// it is the only rank that can fire at all for a session recorded without a
/// template, or for a freshly imported program whose templates are new rows.
///
/// Each rank degrades into the next, so a reference is never lost, only less
/// well matched. (2) outranks (3) so a template that moved from 10 to 12 reps
/// keeps pointing at its own history.
Map<String, ExerciseLastPerfResult> rankLastPerfs(
  Iterable<LastPerfCandidate> candidates,
) {
  final any = <String, ExerciseLastPerfResult>{};
  final sameTarget = <String, ExerciseLastPerfResult>{};
  final sameWorkout = <String, ExerciseLastPerfResult>{};
  final sameWorkoutSameTarget = <String, ExerciseLastPerfResult>{};

  for (final candidate in candidates) {
    final result = ExerciseLastPerfResult(
      perfs: candidate.perfs,
      meta: LastPerfMeta(
        performedAt: candidate.performedAt,
        target: candidate.target,
        fromSameWorkout: candidate.fromSameWorkout,
      ),
    );
    // Candidates arrive most recent first, so the first to claim a key is the
    // latest of its rank.
    any.putIfAbsent(candidate.key, () => result);
    if (candidate.matchesTarget) {
      sameTarget.putIfAbsent(candidate.key, () => result);
    }
    if (candidate.fromSameWorkout) {
      sameWorkout.putIfAbsent(candidate.key, () => result);
      if (candidate.matchesTarget) {
        sameWorkoutSameTarget.putIfAbsent(candidate.key, () => result);
      }
    }
  }

  // Weakest rank first: each spread overrides the one before it.
  return {...any, ...sameTarget, ...sameWorkout, ...sameWorkoutSameTarget};
}

/// What identifies an exercise when looking up its history: its catalog id
/// when known, and its display name as a fallback.
class LastPerfLookup {
  const LastPerfLookup({
    required this.name,
    this.exerciseId,
    this.isTimeBased = false,
    this.target,
  });

  LastPerfLookup.of(WorkoutExercise exercise)
    : name = exercise.name,
      exerciseId = exercise.exerciseId,
      isTimeBased = exercise.isTimeBased,
      target = exercise.currentTarget;

  final String name;
  final String? exerciseId;

  /// Part of [lastPerfKey], so the caller needs it to read its own entry back
  /// out of the result map.
  final bool isTimeBased;

  /// Reps (or seconds) this exercise is aiming for today. Ranks the candidate
  /// past sessions, never filters them — see [lastPerfKey].
  final int? target;

  /// Where this lookup's result lands in the map returned by the repository.
  String get key => lastPerfKey(
    exerciseName: name,
    isTimeBased: isTimeBased,
    exerciseId: exerciseId,
  );
}

/// Lookup key for an exercise's last perf: its identity and its kind.
///
/// Identity is the catalog [exerciseId] when known, and the normalized name
/// otherwise. Matching on the raw display name lost the history on a language
/// change (`Développé couché` → `Barbell Bench Press` is the same id), on a
/// rename, and across a certified exercise's aliases.
///
/// The rep/duration target is deliberately **not** part of the key: "last
/// time" means the most recent session on this exercise, whatever it targeted.
/// Keying on the target used to split one history into several and made the
/// reference vanish as soon as a template moved from 10 to 12 reps. Reps and
/// holds stay separate because their performances are not comparable.
///
/// The target still *ranks* the candidates — a 5-rep day must not be handed the
/// load of a 10-rep day. That happens in the repository, on
/// [LastPerfLookup.target], where losing the match degrades to an older session
/// instead of to none at all.
String lastPerfKey({
  required String exerciseName,
  required bool isTimeBased,
  String? exerciseId,
}) {
  final identity = exerciseIdentityKey(
    name: exerciseName,
    exerciseId: exerciseId,
  );
  return '$identity:${isTimeBased ? 'T' : 'R'}';
}

/// [lastPerfKey] of a live exercise. Single source of truth for the key, shared
/// by the pre-fill, the summary line and the per-set pills.
String exerciseLastPerfKey(WorkoutExercise exercise) => lastPerfKey(
  exerciseName: exercise.name,
  isTimeBased: exercise.isTimeBased,
  exerciseId: exercise.exerciseId,
);

/// Weight to start the exercise at: the load of the reference session's first
/// set, or `null` when there is nothing to go on (no history, bodyweight).
///
/// One load for the whole exercise, deliberately. Replaying the past set by
/// set brought back drop-sets and off-days as if they were the plan; the first
/// set is what you actually decided to lift that day, and the user adjusts
/// from there.
double? referenceWeight(List<LastPerf>? perfs) {
  if (perfs == null || perfs.isEmpty) return null;
  final weight = perfs.first.weight;
  return weight > 0 ? weight : null;
}

/// Reference perf for set [index]: the set that matches it in the past
/// session, or the last one when today's exercise has more sets. Shared by the
/// summary line, the per-set pill and the weight pre-fill so the three never
/// disagree.
LastPerf? perfForSet(List<LastPerf> perfs, int index) {
  if (perfs.isEmpty || index < 0) return null;
  return index < perfs.length ? perfs[index] : perfs.last;
}
