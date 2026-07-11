import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repster/features/session/application/session_audio.dart';
import 'package:repster/features/session/presentation/widgets/exercise_timer_overlay.dart';
import 'package:repster/features/session/presentation/widgets/rest_timer_overlay.dart';

Widget _host(Widget child) => MaterialApp(
  home: Scaffold(body: Stack(children: [const SizedBox.expand(), child])),
);

void main() {
  testWidgets('rest overlay full lays out', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      _host(
        RestTimerOverlay(
          seconds: 45,
          total: 90,
          startedAt: DateTime.now(),
          minimized: false,
          onSkip: () {},
          onExtend: (_) {},
          onMinimize: () {},
          onExpand: () {},
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 50));
    expect(tester.takeException(), isNull);
  });

  testWidgets('rest overlay minimized pill lays out', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    for (final s in [90, 45, 0]) {
      await tester.pumpWidget(
        _host(
          RestTimerOverlay(
            seconds: s,
            total: 90,
            startedAt: DateTime.now(),
            minimized: true,
            onSkip: () {},
            onExtend: (_) {},
            onMinimize: () {},
            onExpand: () {},
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 50));
      expect(tester.takeException(), isNull, reason: 'seconds=$s');
    }
  });

  testWidgets('exercise timer overlay lays out', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      _host(
        ExerciseTimerOverlay(
          targetSeconds: 30,
          audio: SessionAudio(),
          onCancel: () {},
          onComplete: (_) {},
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 50));
    expect(tester.takeException(), isNull);
  });
}
