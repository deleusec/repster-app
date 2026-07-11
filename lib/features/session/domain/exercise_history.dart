/// One past session's performance on a given exercise, feeding the
/// per-exercise history sheet. Entries are ordered most-recent first.
class ExerciseHistoryEntry {
  const ExerciseHistoryEntry({
    required this.date,
    required this.isTimeBased,
    required this.sets,
  });

  /// Session completion date.
  final DateTime date;
  final bool isTimeBased;

  /// Completed sets, ordered by set number.
  final List<ExerciseHistorySet> sets;
}

/// A single completed set within an [ExerciseHistoryEntry].
class ExerciseHistorySet {
  const ExerciseHistorySet({
    required this.setNumber,
    required this.reps,
    required this.weight,
    this.seconds,
  });

  final int setNumber;
  final int reps;
  final double weight;

  /// Duration held, for time-based exercises (`null` otherwise).
  final int? seconds;
}
