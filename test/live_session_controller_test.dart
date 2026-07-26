import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repster/features/session/application/live_session_controller.dart';
import 'package:repster/features/session/application/live_session_state.dart';
import 'package:repster/features/session/data/sessions_repository.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/stats/application/stats_controller.dart';

// ── Fake repository ──────────────────────────────────────────────────────────

class _FakeSessionsRepo extends Fake implements SessionsRepository {
  _FakeSessionsRepo({this.saveThrows = false});

  bool saveThrows;
  InProgressSnapshot? snapshot;

  WorkoutSession? savedSession;
  String? discardedId;
  int syncCount = 0;

  @override
  Future<InProgressSnapshot?> fetchInProgressSnapshot() async => snapshot;

  @override
  Future<void> saveSession(WorkoutSession session) async {
    if (saveThrows) throw Exception('save boom');
    savedSession = session;
  }

  @override
  Future<void> discardInProgress(String sessionId) async {
    discardedId = sessionId;
  }

  @override
  Future<void> syncSnapshot(String sessionId, Map<String, Object?> snap) async {
    syncCount++;
  }
}

// ── Fixtures ─────────────────────────────────────────────────────────────────

WorkoutSet _set(
  String id, {
  int targetReps = 10,
  int actualReps = 10,
  double weight = 50,
  bool completed = false,
  int? targetSeconds,
  int? actualSeconds,
}) => WorkoutSet(
  id: id,
  setNumber: 1,
  targetReps: targetReps,
  actualReps: actualReps,
  weight: weight,
  completed: completed,
  targetSeconds: targetSeconds,
  actualSeconds: actualSeconds,
);

WorkoutExercise _ex(
  String id,
  String name, {
  int restTime = 90,
  List<WorkoutSet>? sets,
  String? supersetGroupId,
  int? supersetPosition,
  int? supersetSize,
  List<WorkoutVariant>? variants,
  int? activeVariantIndex,
}) => WorkoutExercise(
  id: id,
  name: name,
  notes: '',
  tempo: '2-0-2-0',
  restTime: restTime,
  sets: sets ?? [_set('$id-1')],
  supersetGroupId: supersetGroupId,
  supersetPosition: supersetPosition,
  supersetSize: supersetSize,
  variants: variants,
  activeVariantIndex: activeVariantIndex,
);

WorkoutSession _session(List<WorkoutExercise> exercises) => WorkoutSession(
  id: 'sess-1',
  templateId: 'tpl-1',
  templateName: 'Push Day',
  startedAt: DateTime(2026, 1, 1, 10),
  duration: 0,
  exercises: exercises,
  tags: const [],
  notes: '',
);

InProgressSnapshot _snapshot(
  WorkoutSession session, {
  int currentExerciseIndex = 0,
  int? bankedSeconds,
  DateTime? segmentStartedAt,
  DateTime? lastActivityAt,
  DateTime? liveUpdatedAt,
}) => InProgressSnapshot(
  sessionId: session.id,
  liveUpdatedAt: liveUpdatedAt,
  snapshot: {
    // JSON round-trip to reproduce the real Supabase serialization
    // (json.encode calls toJson() recursively on nested objects).
    'session': jsonDecode(jsonEncode(session)) as Map<String, dynamic>,
    'currentExerciseIndex': currentExerciseIndex,
    'lastPerfs': <String, dynamic>{},
    'lastPerfsMeta': <String, dynamic>{},
    if (bankedSeconds != null) 'bankedSeconds': bankedSeconds,
    if (segmentStartedAt != null)
      'segmentStartedAt': segmentStartedAt.millisecondsSinceEpoch,
    if (lastActivityAt != null)
      'lastActivityAt': lastActivityAt.millisecondsSinceEpoch,
  },
);

// ── Harness ──────────────────────────────────────────────────────────────────

/// Builds a container with the fake repo, keeps the notifier alive
/// (autoDispose) and starts a session via the `resume` path (snapshot →
/// session).
Future<(ProviderContainer, LiveSessionController)> _boot(
  WorkoutSession session, {
  _FakeSessionsRepo? repo,
  int currentExerciseIndex = 0,
  List<Override> extra = const [],
  InProgressSnapshot? snapshot,
}) async {
  final r = (repo ?? _FakeSessionsRepo())
    ..snapshot =
        snapshot ??
        _snapshot(session, currentExerciseIndex: currentExerciseIndex);
  final container = ProviderContainer(
    overrides: [sessionsRepositoryProvider.overrideWithValue(r), ...extra],
  );
  addTearDown(container.dispose);
  // A listener keeps the autoDispose provider alive between reads.
  final sub = container.listen(liveSessionControllerProvider, (_, _) {});
  addTearDown(sub.close);

  final ctl = container.read(liveSessionControllerProvider.notifier);
  await ctl.enter('tpl-1', resume: true);
  return (container, ctl);
}

LiveSessionState _state(ProviderContainer c) =>
    c.read(liveSessionControllerProvider);

void main() {
  group('enter / resume', () {
    test('resume loads the session and goes running', () async {
      final (c, _) = await _boot(_session([_ex('e1', 'Squat')]));
      final s = _state(c);
      expect(s.status, LiveSessionStatus.running);
      expect(s.session?.id, 'sess-1');
      expect(s.session?.exercises, hasLength(1));
      expect(s.currentExerciseIndex, 0);
    });

    test('enter is a no-op if a session is already running', () async {
      final repo = _FakeSessionsRepo();
      final (c, ctl) = await _boot(_session([_ex('e1', 'Squat')]), repo: repo);
      repo.snapshot = _snapshot(_session([_ex('e2', 'Bench')]));
      await ctl.enter('tpl-1', resume: true);
      expect(_state(c).session?.exercises.first.name, 'Squat');
    });
  });

  group('sets', () {
    test('completeSet validates the set and starts rest', () async {
      final (c, ctl) = await _boot(_session([_ex('e1', 'Squat')]));
      ctl.completeSet(0, 0);
      final s = _state(c);
      expect(s.session!.exercises[0].sets[0].completed, isTrue);
      expect(s.isResting, isTrue);
      expect(s.restTotalSeconds, 90);
      expect(s.restReturnTo, isNull);
    });

    test('completeSet without rest starts no timer', () async {
      final (c, ctl) = await _boot(_session([_ex('e1', 'Squat', restTime: 0)]));
      ctl.completeSet(0, 0);
      expect(_state(c).isResting, isFalse);
    });

    test('updateSet updates reps and weight', () async {
      final (c, ctl) = await _boot(_session([_ex('e1', 'Squat')]));
      ctl.updateSet(0, 0, actualReps: 12, weight: 62.5);
      final set = _state(c).session!.exercises[0].sets[0];
      expect(set.actualReps, 12);
      expect(set.weight, 62.5);
    });

    test('addSet inherits from the last set', () async {
      final (c, ctl) = await _boot(
        _session([
          _ex('e1', 'Squat', sets: [_set('e1-1', weight: 80, targetReps: 5)]),
        ]),
      );
      ctl.addSet(0);
      final sets = _state(c).session!.exercises[0].sets;
      expect(sets, hasLength(2));
      expect(sets[1].setNumber, 2);
      expect(sets[1].weight, 80);
      expect(sets[1].targetReps, 5);
      expect(sets[1].completed, isFalse);
    });

    test('removeSet removes, renumbers and protects the last', () async {
      final (c, ctl) = await _boot(
        _session([
          _ex('e1', 'Squat', sets: [_set('a'), _set('b'), _set('c')]),
        ]),
      );
      ctl.removeSet(0, 0);
      var sets = _state(c).session!.exercises[0].sets;
      expect(sets, hasLength(2));
      expect(sets.map((s) => s.setNumber), [1, 2]);

      ctl.removeSet(0, 0);
      sets = _state(c).session!.exercises[0].sets;
      expect(sets, hasLength(1));
      ctl.removeSet(0, 0);
      expect(_state(c).session!.exercises[0].sets, hasLength(1));
    });

    test('setExerciseWeight spares validated sets', () async {
      final (c, ctl) = await _boot(
        _session([
          _ex('e1', 'Squat', sets: [_set('a', completed: true), _set('b')]),
        ]),
      );
      ctl.setExerciseWeight(0, 100);
      final sets = _state(c).session!.exercises[0].sets;
      expect(sets[0].weight, 50, reason: 'validated set left unchanged');
      expect(sets[1].weight, 100);
    });
  });

  group('supersets', () {
    List<WorkoutExercise> block() => [
      _ex('e1', 'A', supersetGroupId: 'g', supersetPosition: 0),
      _ex('e2', 'B', supersetGroupId: 'g', supersetPosition: 1),
    ];

    test('superset mid-block: jump without rest', () async {
      final (c, ctl) = await _boot(_session(block()));
      ctl.completeSet(0, 0);
      final s = _state(c);
      expect(s.currentExerciseIndex, 1);
      expect(s.isResting, isFalse);
    });

    test('superset last of block: rest back to start', () async {
      final (c, ctl) = await _boot(_session(block()), currentExerciseIndex: 1);
      ctl.completeSet(1, 0);
      final s = _state(c);
      expect(s.isResting, isTrue);
      expect(s.restReturnTo, 0);
    });

    // A block whose stored positions no longer start at 0 — what a snapshot
    // written before block metadata was renormalized looks like, and what
    // removeExercise used to leave behind.
    test('a stale position does not make a mid-block set the last', () async {
      final (c, ctl) = await _boot(
        _session([
          _ex('e2', 'B', supersetGroupId: 'g', supersetPosition: 1),
          _ex('e3', 'C', supersetGroupId: 'g', supersetPosition: 2),
        ]),
      );
      ctl.completeSet(0, 0);
      final s = _state(c);
      expect(s.isResting, isFalse, reason: 'B must chain to C, not rest');
      expect(s.currentExerciseIndex, 1);
    });

    test('removeExercise renumbers the block it shrank', () async {
      final (c, ctl) = await _boot(
        _session([
          _ex('e1', 'A', supersetGroupId: 'g', supersetPosition: 0),
          _ex('e2', 'B', supersetGroupId: 'g', supersetPosition: 1),
          _ex('e3', 'C', supersetGroupId: 'g', supersetPosition: 2),
        ]),
      );
      ctl.removeExercise(0);
      final left = _state(c).session!.exercises;
      expect(left.map((e) => e.supersetPosition), [0, 1]);
      expect(
        left.map((e) => e.supersetSize),
        [2, 2],
        reason: 'a stale size persists a wrong superset_with_next',
      );

      // And the chaining that depends on it still works.
      ctl.completeSet(0, 0);
      expect(_state(c).isResting, isFalse);
    });

    test('a block down to one member is no longer a superset', () async {
      final (c, ctl) = await _boot(
        _session([
          _ex('e1', 'A', supersetGroupId: 'g', supersetPosition: 0),
          _ex('e2', 'B', supersetGroupId: 'g', supersetPosition: 1),
          _ex('e3', 'Solo'),
        ]),
      );
      ctl.removeExercise(0);
      final left = _state(c).session!.exercises;
      expect(left.first.supersetGroupId, isNull);
      expect(left.first.supersetPosition, isNull);
      expect(left.first.supersetSize, isNull);

      // A lone exercise rests like any other.
      ctl.completeSet(0, 0);
      expect(_state(c).isResting, isTrue);
    });

    test('reorderExercise renumbers the block in list order', () async {
      final (c, ctl) = await _boot(
        _session([
          _ex('e1', 'A', supersetGroupId: 'g', supersetPosition: 0),
          _ex('e2', 'B', supersetGroupId: 'g', supersetPosition: 1),
          _ex('e3', 'C', supersetGroupId: 'g', supersetPosition: 2),
        ]),
      );
      ctl.reorderExercise(2, 0); // C moves to the front of the block
      final left = _state(c).session!.exercises;
      expect(left.map((e) => e.name), ['C', 'A', 'B']);
      expect(
        left.map((e) => e.supersetPosition),
        [0, 1, 2],
        reason: 'block order is the list order, not the old stored order',
      );
    });
  });

  group('exercises', () {
    test('reorderExercise follows the current index', () async {
      final (c, ctl) = await _boot(
        _session([_ex('e1', 'A'), _ex('e2', 'B'), _ex('e3', 'C')]),
      );
      ctl.reorderExercise(0, 2);
      final s = _state(c);
      expect(s.session!.exercises.map((e) => e.name), ['B', 'C', 'A']);
      expect(s.currentExerciseIndex, 2);
    });

    test('removeExercise adjusts the index and protects the last', () async {
      final (c, ctl) = await _boot(
        _session([_ex('e1', 'A'), _ex('e2', 'B')]),
        currentExerciseIndex: 1,
      );
      ctl.removeExercise(0);
      final s = _state(c);
      expect(s.session!.exercises.map((e) => e.name), ['B']);
      expect(s.currentExerciseIndex, 0);

      ctl.removeExercise(0);
      expect(_state(c).session!.exercises, hasLength(1));
    });

    test('addExercise inserts after the given index', () async {
      final (c, ctl) = await _boot(_session([_ex('e1', 'A'), _ex('e2', 'B')]));
      ctl.addExercise(_ex('e3', 'C'), insertAfter: 0);
      final s = _state(c);
      expect(s.session!.exercises.map((e) => e.name), ['A', 'C', 'B']);
    });

    test('removeSet ignores an out-of-range index', () async {
      final (c, ctl) = await _boot(
        _session([
          _ex('e1', 'A', sets: [_set('s1'), _set('s2')]),
        ]),
      );
      // Every sibling mutation bounds-checks; this one used to RangeError.
      expect(() => ctl.removeSet(0, 7), returnsNormally);
      expect(_state(c).session!.exercises.first.sets, hasLength(2));
    });
  });

  group('rest', () {
    test('skipRest exits rest toward restReturnTo', () async {
      final (c, ctl) = await _boot(
        _session([
          _ex('e1', 'A', supersetGroupId: 'g', supersetPosition: 0),
          _ex('e2', 'B', supersetGroupId: 'g', supersetPosition: 1),
        ]),
        currentExerciseIndex: 1,
      );
      ctl.completeSet(1, 0);
      expect(_state(c).isResting, isTrue);
      ctl.skipRest();
      final s = _state(c);
      expect(s.isResting, isFalse);
      expect(s.currentExerciseIndex, 0);
    });

    test('skipRest persists the exercise it lands on', () async {
      final repo = _FakeSessionsRepo();
      final (c, ctl) = await _boot(
        _session([
          _ex('e1', 'A', supersetGroupId: 'g', supersetPosition: 0),
          _ex('e2', 'B', supersetGroupId: 'g', supersetPosition: 1),
        ]),
        repo: repo,
        currentExerciseIndex: 1,
      );
      ctl.completeSet(1, 0);
      final before = _state(c).lastActivityAt;
      ctl.skipRest();
      // Leaving rest moves currentExerciseIndex; a resume that never learns
      // about it reopens the session on the wrong exercise.
      expect(
        _state(c).lastActivityAt,
        isNot(before),
        reason: 'skipping a rest is an action: it must mark activity and sync',
      );
    });
  });

  group('variants', () {
    WorkoutExercise withVariants({bool firstCompleted = false}) => _ex(
      'e1',
      'A',
      activeVariantIndex: 0,
      sets: [_set('a', completed: firstCompleted)],
      variants: const [
        WorkoutVariant(
          name: 'A',
          sets: 1,
          reps: 10,
          tempo: '2-0-2-0',
          restTime: 90,
          notes: '',
        ),
        WorkoutVariant(
          name: 'B',
          sets: 3,
          reps: 8,
          tempo: '2-0-2-0',
          restTime: 60,
          notes: '',
        ),
      ],
    );

    test('switchVariant switches and rebuilds the sets', () async {
      final (c, ctl) = await _boot(_session([withVariants()]));
      final ok = ctl.switchVariant(0, 1);
      expect(ok, isTrue);
      final ex = _state(c).session!.exercises[0];
      expect(ex.name, 'B');
      expect(ex.sets, hasLength(3));
      expect(ex.sets.first.targetReps, 8);
      expect(ex.activeVariantIndex, 1);
    });

    test('switchVariant refuses if a set is validated', () async {
      final (c, ctl) = await _boot(
        _session([withVariants(firstCompleted: true)]),
      );
      final ok = ctl.switchVariant(0, 1);
      expect(ok, isFalse);
      expect(_state(c).session!.exercises[0].name, 'A');
    });
  });

  group('finalization', () {
    WorkoutSession withCompletedSet() => _session([
      _ex('e1', 'A', sets: [_set('a', completed: true)]),
    ]);

    test('endAndSave: false if no validated set', () async {
      final repo = _FakeSessionsRepo();
      final (_, ctl) = await _boot(_session([_ex('e1', 'A')]), repo: repo);
      final saved = await ctl.endAndSave('notes');
      expect(saved, isFalse);
      expect(repo.savedSession, isNull);
    });

    test('endAndSave persists and goes finished', () async {
      final repo = _FakeSessionsRepo();
      final (c, ctl) = await _boot(withCompletedSet(), repo: repo);
      final saved = await ctl.endAndSave('  bonne séance  ');
      expect(saved, isTrue);
      expect(repo.savedSession, isNotNull);
      expect(repo.savedSession!.notes, 'bonne séance');
      expect(repo.savedSession!.duration, greaterThanOrEqualTo(0));
      expect(_state(c).status, LiveSessionStatus.finished);
    });

    test('endAndSave fails → running + error', () async {
      final repo = _FakeSessionsRepo(saveThrows: true);
      final (c, ctl) = await _boot(withCompletedSet(), repo: repo);
      final saved = await ctl.endAndSave('notes');
      expect(saved, isFalse);
      final s = _state(c);
      expect(s.status, LiveSessionStatus.running);
      expect(s.error, isNotNull);
    });

    test('endAndSave invalidates the stats', () async {
      var statsBuilds = 0;
      final (c, ctl) = await _boot(
        withCompletedSet(),
        extra: [
          statsSessionsProvider.overrideWith((ref) async {
            statsBuilds++;
            return <WorkoutSession>[];
          }),
        ],
      );
      await c.read(statsSessionsProvider.future);
      expect(statsBuilds, 1);

      await ctl.endAndSave('');
      await c.read(statsSessionsProvider.future);
      expect(statsBuilds, 2, reason: 'statsSessions must be recomputed');
    });

    test('discard deletes the session and resets', () async {
      final repo = _FakeSessionsRepo();
      final (c, ctl) = await _boot(_session([_ex('e1', 'A')]), repo: repo);
      await ctl.discard();
      expect(repo.discardedId, 'sess-1');
      expect(_state(c).status, LiveSessionStatus.idle);
      expect(_state(c).session, isNull);
    });
  });

  // The clock measures active time, so a session left open never reports the
  // hours it spent open. `activeSecondsAt` takes `now`, which keeps these
  // assertions exact instead of clock-dependent.
  group('active time', () {
    final t0 = DateTime(2026, 7, 20, 18);

    LiveSessionState stateAt({
      int banked = 0,
      Duration segmentStart = Duration.zero,
      Duration lastActivity = Duration.zero,
    }) => LiveSessionState.empty.copyWith(
      bankedSeconds: banked,
      segmentStartedAt: t0.add(segmentStart),
      lastActivityAt: t0.add(lastActivity),
    );

    test('counts the open segment while the session is live', () {
      final s = stateAt(lastActivity: const Duration(minutes: 40));
      expect(
        s.activeSecondsAt(t0.add(const Duration(minutes: 41))),
        const Duration(minutes: 41).inSeconds,
      );
    });

    test('a long rest under the gap still counts as training', () {
      // 29 min under the gap: a slow set or a busy machine must not split it.
      final s = stateAt(lastActivity: const Duration(minutes: 1));
      final now = t0.add(const Duration(minutes: 30));
      expect(s.activeSecondsAt(now), const Duration(minutes: 30).inSeconds);
    });

    test('freezes at the last action once the gap is exceeded', () {
      final s = stateAt(lastActivity: const Duration(minutes: 45));
      // Twelve hours later the clock still reads the 45 min actually trained.
      final s45 = const Duration(minutes: 45).inSeconds;
      expect(s.activeSecondsAt(t0.add(const Duration(hours: 12))), s45);
      expect(s.activeSecondsAt(t0.add(const Duration(days: 3))), s45);
    });

    test('banked segments add up across resumes', () {
      final s = stateAt(
        banked: const Duration(minutes: 45).inSeconds,
        segmentStart: const Duration(hours: 12),
        lastActivity: const Duration(hours: 12, minutes: 10),
      );
      expect(
        s.activeSecondsAt(t0.add(const Duration(hours: 12, minutes: 10))),
        const Duration(minutes: 55).inSeconds,
      );
    });

    test('an empty session reports nothing rather than a negative', () {
      expect(LiveSessionState.empty.activeSecondsAt(t0), 0);
      // A clock skew backwards must not produce a negative duration.
      expect(
        stateAt().activeSecondsAt(t0.subtract(const Duration(hours: 1))),
        0,
      );
    });

    test('resume restores the clock from the snapshot', () async {
      final session = _session([_ex('e1', 'A')]);
      final (c, _) = await _boot(
        session,
        snapshot: _snapshot(
          session,
          bankedSeconds: 300,
          segmentStartedAt: session.startedAt,
          lastActivityAt: session.startedAt.add(const Duration(minutes: 45)),
        ),
      );
      final s = _state(c);
      expect(s.bankedSeconds, 300);
      expect(
        s.lastActivityAt,
        session.startedAt.add(const Duration(minutes: 45)),
      );
      // Resumed long after the fact: frozen at 300 + 45 min, not at wall clock.
      expect(
        s.activeSecondsAt(DateTime.now()),
        300 + const Duration(minutes: 45).inSeconds,
      );
    });

    test('resume falls back to the row sync time on an old snapshot', () async {
      final session = _session([_ex('e1', 'A')]);
      final synced = session.startedAt.add(const Duration(minutes: 50));
      final (c, _) = await _boot(
        session,
        // No activity fields: written before they existed.
        snapshot: _snapshot(session, liveUpdatedAt: synced),
      );
      final s = _state(c);
      expect(s.lastActivityAt, synced);
      expect(s.segmentStartedAt, session.startedAt);
      expect(
        s.activeSecondsAt(DateTime.now()),
        const Duration(minutes: 50).inSeconds,
      );
    });

    test(
      'an action after the gap banks the segment and opens a new one',
      () async {
        final session = _session([
          _ex('e1', 'A', sets: [_set('a')]),
        ]);
        final (c, ctl) = await _boot(
          session,
          snapshot: _snapshot(
            session,
            segmentStartedAt: session.startedAt,
            lastActivityAt: session.startedAt.add(const Duration(minutes: 45)),
          ),
        );
        ctl.completeSet(0, 0);

        final s = _state(c);
        expect(
          s.bankedSeconds,
          const Duration(minutes: 45).inSeconds,
          reason: 'the trained segment is kept, the dead gap is not',
        );
        expect(
          DateTime.now().difference(s.segmentStartedAt!).inSeconds,
          lessThan(5),
          reason: 'the new segment starts at the action',
        );
        expect(s.activeSecondsAt(DateTime.now()), closeTo(45 * 60, 5));
      },
    );

    test('endAndSave stores the active time, not the wall clock', () async {
      final repo = _FakeSessionsRepo();
      final session = _session([
        _ex('e1', 'A', sets: [_set('a', completed: true)]),
      ]);
      await _boot(
        session,
        repo: repo,
        snapshot: _snapshot(
          session,
          segmentStartedAt: session.startedAt,
          lastActivityAt: session.startedAt.add(const Duration(minutes: 72)),
        ),
      ).then((r) => r.$2.endAndSave(''));

      expect(
        repo.savedSession!.duration,
        const Duration(minutes: 72).inSeconds,
      );
    });
  });
}
