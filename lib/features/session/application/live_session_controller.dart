import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/logging/app_logger.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/session/application/live_session_state.dart';
import 'package:repster/features/session/data/sessions_repository.dart';
import 'package:repster/features/session/domain/exercise_history.dart';
import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/stats/application/stats_controller.dart';
import 'package:repster/features/templates/data/templates_repository.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:uuid/uuid.dart';

/// Controller for a live session. All mutations stay in memory; a debounced
/// snapshot is persisted to Supabase to allow resuming.
class LiveSessionController extends AutoDisposeNotifier<LiveSessionState> {
  static const _uuid = Uuid();
  static const _syncDebounce = Duration(seconds: 3);
  Timer? _syncTimer;

  SessionsRepository get _repo => ref.read(sessionsRepositoryProvider);

  @override
  LiveSessionState build() {
    ref.onDispose(() => _syncTimer?.cancel());
    return LiveSessionState.empty;
  }

  // ── Entry: start or resume ────────────────────────────────────────────────

  /// Screen entry point: resumes the in-progress session if [resume] and a
  /// snapshot exists, otherwise starts a fresh session from the template.
  Future<void> enter(String templateId, {required bool resume}) async {
    if (state.status == LiveSessionStatus.running ||
        state.status == LiveSessionStatus.loading) {
      return;
    }
    state = state.copyWith(status: LiveSessionStatus.loading, error: null);
    if (resume) {
      final ok = await _tryResume();
      if (ok) return;
    }
    await _startFromTemplate(templateId);
  }

  Future<bool> _tryResume() async {
    try {
      final snap = await _repo.fetchInProgressSnapshot();
      if (snap == null) return false;
      final s = snap.snapshot;
      final sessionJson = s['session'];
      if (sessionJson is! Map) return false;
      final session = WorkoutSession.fromJson(
        Map<String, Object?>.from(sessionJson),
      );
      state = state.copyWith(
        status: LiveSessionStatus.running,
        session: session,
        currentExerciseIndex: (s['currentExerciseIndex'] as num?)?.toInt() ?? 0,
        lastPerfs: _lastPerfsFromJson(s['lastPerfs']),
        lastPerfsMeta: _lastPerfsMetaFromJson(s['lastPerfsMeta']),
        isResting: false,
        restStartedAt: null,
        restTotalSeconds: 0,
        restReturnTo: null,
      );
      return true;
    } on Object catch (e, st) {
      log.w('resume snapshot failed', error: e, stackTrace: st);
      return false;
    }
  }

  Future<void> _startFromTemplate(String templateId) async {
    try {
      final template = await ref
          .read(templatesRepositoryProvider)
          .fetchById(templateId);
      final exercises = initialExercisesFromTemplate(template);
      final sessionId = await _repo.startSession(template);
      final lastPerfs = await _repo.bulkLastPerfs(
        exercises.map((e) => e.name).toList(growable: false),
      );

      final filled = [
        for (final ex in exercises) _prefillWeights(ex, lastPerfs),
      ];

      final session = WorkoutSession(
        id: sessionId,
        templateId: template.id,
        templateName: template.name,
        startedAt: DateTime.now(),
        duration: 0,
        exercises: filled,
        tags: template.tags,
        notes: '',
      );

      state = state.copyWith(
        status: LiveSessionStatus.running,
        session: session,
        currentExerciseIndex: 0,
        lastPerfs: lastPerfs,
        lastPerfsMeta: const {},
        isResting: false,
        restStartedAt: null,
        restTotalSeconds: 0,
        restReturnTo: null,
      );
    } on Object catch (e, st) {
      log.e('startFromTemplate failed', error: e, stackTrace: st);
      state = state.copyWith(
        status: LiveSessionStatus.idle,
        error: t.session.error.startFailed,
      );
    }
  }

  /// Pre-fills the weight of every set from the first set of the matching last
  /// perf.
  WorkoutExercise _prefillWeights(
    WorkoutExercise ex,
    Map<String, List<LastPerf>> perfsMap,
  ) {
    final firstSet = ex.sets.isEmpty ? null : ex.sets.first;
    if (firstSet == null) return ex;
    final target = ex.isTimeBased
        ? (firstSet.targetSeconds ?? 0)
        : firstSet.targetReps;
    final key = lastPerfKey(
      exerciseName: ex.name,
      target: target,
      isTimeBased: ex.isTimeBased,
    );
    final perfs = perfsMap[key];
    if (perfs == null || perfs.isEmpty) return ex;
    return ex.copyWith(
      sets: [
        for (var i = 0; i < ex.sets.length; i++)
          () {
            final perf = i < perfs.length ? perfs[i] : perfs.last;
            return perf.weight > 0
                ? ex.sets[i].copyWith(weight: perf.weight)
                : ex.sets[i];
          }(),
      ],
    );
  }

  // ── Navigation ─────────────────────────────────────────────────────────────

  void goToExercise(int index) {
    final session = state.session;
    if (session == null) return;
    if (index < 0 || index >= session.exercises.length) return;
    state = state.copyWith(currentExerciseIndex: index);
    _scheduleSync();
  }

  // ── Set mutations ──────────────────────────────────────────────────────────

  void updateSet(
    int exIdx,
    int setIdx, {
    int? actualReps,
    double? weight,
    int? actualSeconds,
  }) {
    _mutateSet(
      exIdx,
      setIdx,
      (s) => s.copyWith(
        actualReps: actualReps ?? s.actualReps,
        weight: weight ?? s.weight,
        actualSeconds: actualSeconds ?? s.actualSeconds,
      ),
    );
  }

  /// Completes a set. Handles superset chaining (instant jump to the next
  /// exercise in the block, otherwise rest + return to the block's first
  /// exercise).
  void completeSet(int exIdx, int setIdx) {
    final session = state.session;
    if (session == null) return;
    if (exIdx < 0 || exIdx >= session.exercises.length) return;
    final ex = session.exercises[exIdx];
    if (setIdx < 0 || setIdx >= ex.sets.length) return;

    final restTime = ex.restTime;
    final newExercises = _replaceSet(
      session.exercises,
      exIdx,
      setIdx,
      (s) => s.copyWith(completed: true),
    );
    final newSession = session.copyWith(exercises: newExercises);

    if (ex.supersetGroupId != null) {
      final blockIndices =
          [
            for (var i = 0; i < newExercises.length; i++)
              if (newExercises[i].supersetGroupId == ex.supersetGroupId) i,
          ]..sort(
            (a, b) => (newExercises[a].supersetPosition ?? 0).compareTo(
              newExercises[b].supersetPosition ?? 0,
            ),
          );
      final posInBlock = ex.supersetPosition ?? 0;

      if (posInBlock < blockIndices.length - 1) {
        // Mid-block: instant jump to the next exercise, no rest.
        state = state.copyWith(
          session: newSession,
          currentExerciseIndex: blockIndices[posInBlock + 1],
          isResting: false,
          restStartedAt: null,
          restTotalSeconds: 0,
          restReturnTo: null,
        );
        _scheduleSync();
        return;
      }
      // Last in block: rest + return to the block's first exercise.
      state = state.copyWith(
        session: newSession,
        isResting: restTime > 0,
        restStartedAt: restTime > 0 ? DateTime.now() : null,
        restTotalSeconds: restTime,
        restReturnTo: blockIndices.first,
      );
      _scheduleSync();
      return;
    }

    state = state.copyWith(
      session: newSession,
      isResting: restTime > 0,
      restStartedAt: restTime > 0 ? DateTime.now() : null,
      restTotalSeconds: restTime,
      restReturnTo: null,
    );
    _scheduleSync();
  }

  void uncompleteSet(int exIdx, int setIdx) {
    _mutateSet(exIdx, setIdx, (s) => s.copyWith(completed: false));
  }

  void addSet(int exIdx) {
    final session = state.session;
    if (session == null) return;
    if (exIdx < 0 || exIdx >= session.exercises.length) return;
    final ex = session.exercises[exIdx];
    final last = ex.sets.isNotEmpty ? ex.sets.last : null;
    final newSet = WorkoutSet(
      id: _uuid.v4(),
      setNumber: ex.sets.length + 1,
      targetReps: last?.targetReps ?? 10,
      actualReps: last?.actualReps ?? last?.targetReps ?? 10,
      weight: last?.weight ?? 0,
      completed: false,
      targetSeconds: ex.isTimeBased ? (last?.targetSeconds ?? 30) : null,
      actualSeconds: ex.isTimeBased ? 0 : null,
    );
    _replaceExerciseState(exIdx, ex.copyWith(sets: [...ex.sets, newSet]));
  }

  void removeSet(int exIdx, int setIdx) {
    final session = state.session;
    if (session == null) return;
    if (exIdx < 0 || exIdx >= session.exercises.length) return;
    final ex = session.exercises[exIdx];
    if (ex.sets.length <= 1) return;
    final newSets = [...ex.sets]..removeAt(setIdx);
    for (var i = 0; i < newSets.length; i++) {
      newSets[i] = newSets[i].copyWith(setNumber: i + 1);
    }
    _replaceExerciseState(exIdx, ex.copyWith(sets: newSets));
  }

  /// Applies a weight to all uncompleted sets of the exercise.
  void setExerciseWeight(int exIdx, double weight) {
    final session = state.session;
    if (session == null) return;
    if (exIdx < 0 || exIdx >= session.exercises.length) return;
    final ex = session.exercises[exIdx];
    _replaceExerciseState(
      exIdx,
      ex.copyWith(
        sets: [
          for (final s in ex.sets) s.completed ? s : s.copyWith(weight: weight),
        ],
      ),
    );
  }

  /// Applies a target duration to all uncompleted sets (time-based).
  void setExerciseTargetSeconds(int exIdx, int seconds) {
    final session = state.session;
    if (session == null) return;
    if (exIdx < 0 || exIdx >= session.exercises.length) return;
    final safe = seconds < 1 ? 1 : seconds;
    final ex = session.exercises[exIdx];
    _replaceExerciseState(
      exIdx,
      ex.copyWith(
        sets: [
          for (final s in ex.sets)
            s.completed ? s : s.copyWith(targetSeconds: safe),
        ],
      ),
    );
  }

  // ── Reorder / add / remove exercises ───────────────────────────────────────

  void reorderExercise(int fromIdx, int toIdx) {
    final session = state.session;
    if (session == null) return;
    final list = [...session.exercises];
    if (fromIdx < 0 || fromIdx >= list.length) return;
    if (toIdx < 0 || toIdx >= list.length) return;
    final moved = list.removeAt(fromIdx);
    list.insert(toIdx, moved);
    var current = state.currentExerciseIndex;
    if (current == fromIdx) {
      current = toIdx;
    } else if (fromIdx < toIdx && current > fromIdx && current <= toIdx) {
      current--;
    } else if (fromIdx > toIdx && current >= toIdx && current < fromIdx) {
      current++;
    }
    state = state.copyWith(
      session: session.copyWith(exercises: list),
      currentExerciseIndex: current,
    );
    _scheduleSync();
  }

  void addExercise(WorkoutExercise exercise, {int? insertAfter}) {
    final session = state.session;
    if (session == null) return;
    final list = [...session.exercises];
    final insertAt = (insertAfter == null || insertAfter < 0)
        ? list.length
        : (insertAfter + 1).clamp(0, list.length);
    list.insert(insertAt, exercise);
    var current = state.currentExerciseIndex;
    if (insertAt <= current) current += 1;
    state = state.copyWith(
      session: session.copyWith(exercises: list),
      currentExerciseIndex: current,
    );
    _scheduleSync();
  }

  void removeExercise(int exIdx) {
    final session = state.session;
    if (session == null) return;
    final list = session.exercises;
    if (list.length <= 1) return;
    if (exIdx < 0 || exIdx >= list.length) return;
    final next = [
      for (var i = 0; i < list.length; i++)
        if (i != exIdx) list[i],
    ];
    var current = state.currentExerciseIndex;
    if (exIdx < current) {
      current -= 1;
    } else if (exIdx == current) {
      current = current.clamp(0, next.length - 1);
    }
    state = state.copyWith(
      session: session.copyWith(exercises: next),
      currentExerciseIndex: current,
    );
    _scheduleSync();
  }

  /// Edits an exercise's metadata for this session only (swap).
  ///
  /// If [setsCount], [target] and [isTimeBased] are provided, the exercise
  /// format is adopted from a past exercise: the sets are rebuilt (count,
  /// target, kind). Ignored if a set is already completed.
  void updateExerciseMeta(
    int exIdx, {
    required String name,
    required int restTime,
    required String notes,
    required String tempo,
    int? setsCount,
    int? target,
    bool? isTimeBased,
  }) {
    final session = state.session;
    if (session == null) return;
    if (exIdx < 0 || exIdx >= session.exercises.length) return;
    final ex = session.exercises[exIdx];
    final nameChanged = name != ex.name;

    final adoptFormat =
        setsCount != null &&
        target != null &&
        isTimeBased != null &&
        !ex.sets.any((s) => s.completed);

    List<WorkoutSet>? newSets;
    var timeBased = ex.isTimeBased;
    if (adoptFormat) {
      timeBased = isTimeBased;
      final count = setsCount.clamp(1, 20);
      final tgt = target < 1 ? 1 : target;
      newSets = [
        for (var i = 0; i < count; i++)
          WorkoutSet(
            id: _uuid.v4(),
            setNumber: i + 1,
            targetReps: timeBased ? 0 : tgt,
            actualReps: timeBased ? 0 : tgt,
            weight: 0,
            completed: false,
            targetSeconds: timeBased ? tgt : null,
            actualSeconds: timeBased ? 0 : null,
          ),
      ];
    }

    _replaceExerciseState(
      exIdx,
      ex.copyWith(
        name: name,
        restTime: restTime,
        notes: notes,
        tempo: tempo,
        isTimeBased: timeBased,
        sets: newSets ?? ex.sets,
        sessionModified: true,
        originalName: nameChanged && ex.originalName == null
            ? ex.name
            : ex.originalName,
      ),
    );
  }

  /// Switches the exercise to another variant of its slot. Rebuilds the sets.
  /// Returns `false` (no-op) if a set is already completed.
  bool switchVariant(int exIdx, int variantIndex) {
    final session = state.session;
    if (session == null) return false;
    if (exIdx < 0 || exIdx >= session.exercises.length) return false;
    final ex = session.exercises[exIdx];
    final variants = ex.variants;
    if (variants == null ||
        variantIndex < 0 ||
        variantIndex >= variants.length) {
      return false;
    }
    if (ex.sets.any((s) => s.completed)) return false;
    if (ex.activeVariantIndex == variantIndex) return false;

    final v = variants[variantIndex];
    final isTimeBased = v.isTimeBased;
    final target = isTimeBased ? (v.durationSeconds ?? 30) : v.reps;
    final newSets = [
      for (var i = 0; i < v.sets; i++)
        WorkoutSet(
          id: _uuid.v4(),
          setNumber: i + 1,
          targetReps: isTimeBased ? 0 : target,
          actualReps: isTimeBased ? 0 : target,
          weight: 0,
          completed: false,
          targetSeconds: isTimeBased ? (v.durationSeconds ?? 30) : null,
          actualSeconds: isTimeBased ? 0 : null,
        ),
    ];
    final nameChanged = v.name != ex.name;
    _replaceExerciseState(
      exIdx,
      ex.copyWith(
        name: v.name,
        notes: v.notes,
        tempo: v.tempo,
        restTime: v.restTime,
        isTimeBased: isTimeBased,
        sets: newSets,
        activeVariantIndex: variantIndex,
        sessionModified: true,
        originalName: nameChanged && ex.originalName == null
            ? ex.name
            : ex.originalName,
      ),
    );
    return true;
  }

  /// Merges a `lastPerfs` entry (after swap / add). An empty `perfs` clears it.
  void setLastPerfsFor(String key, List<LastPerf> perfs, {LastPerfMeta? meta}) {
    final nextPerfs = {...state.lastPerfs};
    final nextMeta = {...state.lastPerfsMeta};
    if (perfs.isEmpty) {
      nextPerfs.remove(key);
      nextMeta.remove(key);
    } else {
      nextPerfs[key] = perfs;
      if (meta != null && (meta.isFallback || meta.originalTarget != null)) {
        nextMeta[key] = meta;
      } else {
        nextMeta.remove(key);
      }
    }
    state = state.copyWith(lastPerfs: nextPerfs, lastPerfsMeta: nextMeta);
    _scheduleSync();
  }

  // ── Rest ───────────────────────────────────────────────────────────────────

  void skipRest() {
    final target = state.restReturnTo;
    state = state.copyWith(
      isResting: false,
      restStartedAt: null,
      restTotalSeconds: 0,
      restReturnTo: null,
      currentExerciseIndex: target ?? state.currentExerciseIndex,
    );
  }

  void extendRest(int seconds) {
    if (!state.isResting) return;
    final next = (state.restTotalSeconds + seconds).clamp(0, 24 * 3600);
    state = state.copyWith(restTotalSeconds: next);
  }

  // ── Finalization ───────────────────────────────────────────────────────────

  Future<bool> endAndSave(String notes) async {
    final session = state.session;
    if (session == null) return false;
    if (session.completedSets == 0) return false;
    state = state.copyWith(status: LiveSessionStatus.saving);
    try {
      final duration = DateTime.now().difference(session.startedAt).inSeconds;
      final finalSession = session.copyWith(
        duration: duration,
        notes: notes.trim(),
      );
      await _repo.saveSession(finalSession);
      _syncTimer?.cancel();
      // The finished session feeds history, the dashboard (recent sessions +
      // weekly stats + cleared "in progress" card) and the stats.
      _invalidateSessionDependents();
      state = state.copyWith(
        status: LiveSessionStatus.finished,
        session: finalSession,
      );
      return true;
    } on Object catch (e, st) {
      log.e('saveSession failed', error: e, stackTrace: st);
      state = state.copyWith(
        status: LiveSessionStatus.running,
        error: t.session.error.saveFailed,
      );
      return false;
    }
  }

  Future<void> discard() async {
    final session = state.session;
    _syncTimer?.cancel();
    if (session != null) {
      try {
        await _repo.discardInProgress(session.id);
        // The dashboard's "in progress" card must disappear.
        ref.invalidate(dashboardControllerProvider);
      } on Object catch (e, st) {
        log.w('discardInProgress failed', error: e, stackTrace: st);
      }
    }
    state = LiveSessionState.empty;
  }

  /// Invalidates providers derived from persisted sessions after a session has
  /// been saved.
  void _invalidateSessionDependents() {
    ref
      ..invalidate(historyControllerProvider)
      ..invalidate(dashboardControllerProvider)
      ..invalidate(statsSessionsProvider);
  }

  // ── UI reads (delegate to the repo) ────────────────────────────────────────

  /// Last perf for a given exercise/format (shown on swap / variant change).
  /// Routed through the controller so the screen does not depend on `data/`.
  Future<ExerciseLastPerfResult?> lastPerfsForExercise({
    required String name,
    required int target,
    required bool isTimeBased,
  }) {
    return _repo.lastPerfsForExercise(
      name: name,
      target: target,
      isTimeBased: isTimeBased,
    );
  }

  /// Full per-exercise history (past sessions, most recent first) for the
  /// history sheet.
  Future<List<ExerciseHistoryEntry>> exerciseHistory(String name) =>
      _repo.fetchExerciseHistory(name);

  // ── Internal helpers ───────────────────────────────────────────────────────

  void _mutateSet(
    int exIdx,
    int setIdx,
    WorkoutSet Function(WorkoutSet) transform,
  ) {
    final session = state.session;
    if (session == null) return;
    if (exIdx < 0 || exIdx >= session.exercises.length) return;
    final ex = session.exercises[exIdx];
    if (setIdx < 0 || setIdx >= ex.sets.length) return;
    state = state.copyWith(
      session: session.copyWith(
        exercises: _replaceSet(session.exercises, exIdx, setIdx, transform),
      ),
    );
    _scheduleSync();
  }

  List<WorkoutExercise> _replaceSet(
    List<WorkoutExercise> exercises,
    int exIdx,
    int setIdx,
    WorkoutSet Function(WorkoutSet) transform,
  ) {
    final ex = exercises[exIdx];
    final newSets = [...ex.sets];
    newSets[setIdx] = transform(newSets[setIdx]);
    final copy = [...exercises];
    copy[exIdx] = ex.copyWith(sets: newSets);
    return copy;
  }

  void _replaceExerciseState(int exIdx, WorkoutExercise replacement) {
    final session = state.session;
    if (session == null) return;
    final copy = [...session.exercises];
    copy[exIdx] = replacement;
    state = state.copyWith(session: session.copyWith(exercises: copy));
    _scheduleSync();
  }

  // ── Snapshot / sync ────────────────────────────────────────────────────────

  void _scheduleSync() {
    _syncTimer?.cancel();
    final session = state.session;
    if (session == null) return;
    _syncTimer = Timer(_syncDebounce, _flushSync);
  }

  Future<void> _flushSync() async {
    final session = state.session;
    if (session == null || state.status != LiveSessionStatus.running) return;
    try {
      await _repo.syncSnapshot(session.id, _snapshotJson());
    } on Object catch (e, st) {
      log.w('syncSnapshot failed', error: e, stackTrace: st);
    }
  }

  Map<String, Object?> _snapshotJson() {
    final session = state.session!;
    return {
      'session': session.toJson(),
      'startTimestamp': session.startedAt.millisecondsSinceEpoch,
      'currentExerciseIndex': state.currentExerciseIndex,
      'lastPerfs': {
        for (final entry in state.lastPerfs.entries)
          entry.key: [for (final p in entry.value) p.toJson()],
      },
      'lastPerfsMeta': {
        for (final entry in state.lastPerfsMeta.entries)
          entry.key: entry.value.toJson(),
      },
    };
  }

  Map<String, List<LastPerf>> _lastPerfsFromJson(Object? raw) {
    if (raw is! Map) return const {};
    final result = <String, List<LastPerf>>{};
    raw.forEach((key, value) {
      if (value is List) {
        result[key as String] = [
          for (final item in value)
            if (item is Map) LastPerf.fromJson(Map<String, Object?>.from(item)),
        ];
      }
    });
    return result;
  }

  Map<String, LastPerfMeta> _lastPerfsMetaFromJson(Object? raw) {
    if (raw is! Map) return const {};
    final result = <String, LastPerfMeta>{};
    raw.forEach((key, value) {
      if (value is Map) {
        result[key as String] = LastPerfMeta.fromJson(
          Map<String, Object?>.from(value),
        );
      }
    });
    return result;
  }
}

final liveSessionControllerProvider =
    AutoDisposeNotifierProvider<LiveSessionController, LiveSessionState>(
      LiveSessionController.new,
    );
