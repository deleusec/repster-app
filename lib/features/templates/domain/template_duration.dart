import 'dart:math' as math;

import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/templates/domain/template.dart';

/// Seconds a rep takes under the tempo `e-p-c-p` (eccentric, pause,
/// concentric, pause). `X` means explosive and counts as one second. A tempo
/// that cannot be read counts as four seconds, a plain controlled rep.
int tempoSeconds(String tempo) {
  final parts = tempo.toUpperCase().split('-').where((p) => p.isNotEmpty);
  var total = 0;
  var read = 0;
  for (final part in parts) {
    final n = part == 'X' ? 1 : int.tryParse(part);
    if (n == null) continue;
    total += n;
    read++;
  }
  return read == 0 ? 4 : math.max(1, total);
}

/// Rough length of a session run from [template], in seconds: every set at
/// its tempo (or its hold), the rests between sets, and a little under a
/// minute per exercise to move and load the bar.
int estimateTemplateSeconds(Template template) {
  const setupSeconds = 50;
  var total = 0;
  for (final ex in template.primaryExercises) {
    final perSet = ex.isTimeBased
        ? (ex.durationSeconds ?? kDefaultHoldSeconds)
        : ex.reps * tempoSeconds(ex.tempo);
    final rests = math.max(0, ex.sets - 1) * ex.restTime;
    total += ex.sets * perSet + rests + setupSeconds;
  }
  return total;
}
