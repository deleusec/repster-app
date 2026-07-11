import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_perf.freezed.dart';
part 'last_perf.g.dart';

/// A performance previously recorded on an exercise. Its key is
/// `name:targetReps` (reps) or `name:T{seconds}` (time-based). Used to
/// pre-fill weights in the next session.
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

/// Metadata attached to a set of `LastPerf`: flags when we had to fall back
/// to a different target (`isFallback`) and which one (`originalTarget`).
@freezed
class LastPerfMeta with _$LastPerfMeta {
  const factory LastPerfMeta({
    @Default(false) bool isFallback,
    int? originalTarget,
  }) = _LastPerfMeta;

  const LastPerfMeta._();

  factory LastPerfMeta.fromJson(Map<String, Object?> json) =>
      _$LastPerfMetaFromJson(json);
}

/// Result of a last-perf lookup for an exercise (used after an in-session
/// swap or exercise add). `perfs` holds one entry per set.
class ExerciseLastPerfResult {
  const ExerciseLastPerfResult({
    required this.perfs,
    this.isFallback = false,
    this.originalTarget,
  });

  final List<LastPerf> perfs;
  final bool isFallback;
  final int? originalTarget;
}

String lastPerfKey({
  required String exerciseName,
  required int target,
  required bool isTimeBased,
}) => '$exerciseName:${isTimeBased ? "T" : ""}$target';
