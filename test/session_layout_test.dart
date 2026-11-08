import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/features/session/application/live_session_controller.dart';
import 'package:repster/features/session/application/live_session_state.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/session/presentation/session_screen.dart';

class _FakeController extends LiveSessionController {
  _FakeController(this._initial);
  final LiveSessionState _initial;
  @override
  LiveSessionState build() => _initial;
}

LiveSessionState _runningState({bool resting = false}) {
  final session = WorkoutSession(
    id: 's',
    templateId: 't',
    templateName: 'Séance test',
    startedAt: DateTime.now().subtract(const Duration(minutes: 5)),
    duration: 0,
    exercises: [
      const WorkoutExercise(
        id: 'e1',
        name: 'Squat',
        notes: 'Dos droit',
        tempo: '2-0-2-0',
        restTime: 90,
        sets: [
          WorkoutSet(
            id: 'a',
            setNumber: 1,
            targetReps: 10,
            actualReps: 10,
            weight: 60,
            completed: true,
          ),
          WorkoutSet(
            id: 'b',
            setNumber: 2,
            targetReps: 10,
            actualReps: 10,
            weight: 60,
            completed: false,
          ),
        ],
      ),
    ],
    notes: '',
  );
  return LiveSessionState(
    status: LiveSessionStatus.running,
    currentExerciseIndex: 0,
    lastPerfs: const {},
    lastPerfsMeta: const {},
    session: session,
    isResting: resting,
    restStartedAt: resting ? DateTime.now() : null,
    restTotalSeconds: resting ? 90 : 0,
  );
}

void main() {
  testWidgets('session running body lays out without error', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          liveSessionControllerProvider.overrideWith(
            () => _FakeController(_runningState()),
          ),
        ],
        child: const MaterialApp(home: SessionScreen(templateId: 't')),
      ),
    );
    await tester.pump(const Duration(milliseconds: 600));
    expect(tester.takeException(), isNull);
  });

  testWidgets('session with rest overlay lays out without error', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          liveSessionControllerProvider.overrideWith(
            () => _FakeController(_runningState(resting: true)),
          ),
        ],
        child: const MaterialApp(home: SessionScreen(templateId: 't')),
      ),
    );
    await tester.pump(const Duration(milliseconds: 600));
    expect(tester.takeException(), isNull);
  });
}
