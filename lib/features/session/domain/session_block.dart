import 'package:repster/features/session/domain/workout_exercise.dart';

/// A "block" is one on-screen slot: either a single exercise or a chain of
/// consecutive exercises linked by a `supersetGroupId`. The navigation arrows
/// move block by block, not exercise by exercise.
class SessionBlock {
  const SessionBlock({
    required this.exerciseIndices,
    required this.isSuperset,
    this.groupId,
  });

  final List<int> exerciseIndices;
  final bool isSuperset;
  final String? groupId;
}

List<SessionBlock> computeBlocks(List<WorkoutExercise> exercises) {
  final blocks = <SessionBlock>[];
  var i = 0;
  while (i < exercises.length) {
    final ex = exercises[i];
    if (ex.supersetGroupId != null && (ex.supersetSize ?? 0) > 1) {
      final groupId = ex.supersetGroupId;
      final indices = <int>[];
      while (i < exercises.length && exercises[i].supersetGroupId == groupId) {
        indices.add(i);
        i++;
      }
      blocks.add(
        SessionBlock(
          exerciseIndices: indices,
          groupId: groupId,
          isSuperset: indices.length > 1,
        ),
      );
    } else {
      blocks.add(SessionBlock(exerciseIndices: [i], isSuperset: false));
      i++;
    }
  }
  return blocks;
}
