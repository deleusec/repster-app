import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_exercise.freezed.dart';

/// An exercise (a slot variant) of a template.
/// `tempo` as a four-phase `eccentric-pause-concentric-pause` string (e.g.
/// `3-1-2-0`). `restTime` in seconds. When `isTimeBased`, the exercise is
/// measured by `durationSeconds` instead of reps.
@freezed
class TemplateExercise with _$TemplateExercise {
  const factory TemplateExercise({
    required String id,
    required String name,
    required int sets,
    required int reps,
    required String tempo,
    required int restTime,
    required String notes,
    required int order,
    @Default(false) bool isTimeBased,
    int? durationSeconds,
  }) = _TemplateExercise;

  const TemplateExercise._();
}
