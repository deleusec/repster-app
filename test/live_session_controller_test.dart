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
}) => InProgressSnapshot(
  sessionId: session.id,
  snapshot: {
    // JSON round-trip to reproduce the real Supabase serialization
    // (json.encode calls toJson() recursively on nested objects).
    'session': jsonDecode(jsonEncode(session)) as Map<String, dynamic>,
    'currentExerciseIndex': currentExerciseIndex,
    'lastPerfs': <String, dynamic>{},
    'lastPerfsMeta': <String, dynamic>{},
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
}) async {
  final r = (repo ?? _FakeSessionsRepo())
    ..snapshot = _snapshot(session, currentExerciseIndex: currentExerciseIndex);
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
}
