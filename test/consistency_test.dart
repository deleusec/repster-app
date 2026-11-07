import 'package:flutter_test/flutter_test.dart';

import 'package:repster/features/dashboard/domain/consistency.dart';

// A Wednesday, so week arithmetic is not sitting on a boundary.
final _now = DateTime(2026, 7, 22, 18);

DateTime _daysAgo(int n) => _now.subtract(Duration(days: n));

Consistency _from(List<DateTime> dates) =>
    Consistency.fromDates(dates, now: _now);

void main() {
  test('no session is a flat zero, not a crash', () {
    final c = _from([]);
    expect(c.trainingDays, 0);
    expect(c.sessionsPerWeek, 0);
    expect(c.currentStreakWeeks, 0);
    expect(c.dayCounts, isEmpty);
  });

  test('counts distinct days, not sessions', () {
    final c = _from([_daysAgo(1), _daysAgo(1), _daysAgo(3)]);
    expect(c.trainingDays, 2);
    expect(c.dayCounts[Consistency.dayKey(_daysAgo(1))], 2);
  });

  test('ignores sessions older than the heatmap window', () {
    final c = _from([_daysAgo(1), _daysAgo(7 * kHeatmapWeeks + 30)]);
    expect(c.trainingDays, 1);
  });

  test('averages over the weeks the user has been around', () {
    // Three sessions inside a single week: 3/week, not 3 spread over 18.
    final c = _from([_daysAgo(1), _daysAgo(3), _daysAgo(5)]);
    expect(c.sessionsPerWeek, greaterThan(2.5));
  });

  group('day arithmetic', () {
    // Europe switches to winter time on 2026-10-25. A Duration of n days is
    // n × 24 h, so stepping across that date with one used to land at 01:00
    // and miss every midnight key — the heatmap went blank for all days
    // before the change. Only observable under a timezone with DST.
    test('addDays lands on local midnight across a DST change', () {
      final monday = DateTime(2026, 11, 2);
      final start = Consistency.addDays(monday, -7 * (kHeatmapWeeks - 1));
      expect(start, DateTime(2026, 7, 6));
      for (var n = 0; n < 7 * kHeatmapWeeks; n++) {
        final day = Consistency.addDays(start, n);
        expect(day, Consistency.dayKey(day), reason: 'day $n');
      }
      expect(Consistency.addDays(start, 7 * (kHeatmapWeeks - 1)), monday);
    });

    test('mondayOf returns the Monday at midnight', () {
      expect(
        Consistency.mondayOf(DateTime(2026, 11, 7, 18)),
        DateTime(2026, 11, 2),
      );
      expect(
        Consistency.mondayOf(DateTime(2026, 11, 2, 3)),
        DateTime(2026, 11, 2),
      );
    });

    test('a session on the first day of the window is kept', () {
      final now = DateTime(2026, 11, 7);
      final first = Consistency.addDays(
        Consistency.mondayOf(now),
        -7 * (kHeatmapWeeks - 1),
      );
      final c = Consistency.fromDates([
        first.add(const Duration(hours: 9)),
      ], now: now);
      expect(c.dayCounts[first], 1);
    });
  });

  group('streaks', () {
    test('counts consecutive trained weeks up to this one', () {
      final c = _from([_daysAgo(1), _daysAgo(8), _daysAgo(15)]);
      expect(c.currentStreakWeeks, 3);
    });

    test('a still-empty current week does not break the streak', () {
      final c = _from([_daysAgo(8), _daysAgo(15)]);
      expect(c.currentStreakWeeks, 2);
    });

    test('two quiet weeks do break it', () {
      final c = _from([_daysAgo(20), _daysAgo(27)]);
      expect(c.currentStreakWeeks, 0);
    });

    test('the best streak survives a later gap', () {
      final dates = [for (var w = 5; w <= 9; w++) _daysAgo(7 * w), _daysAgo(1)];
      final c = _from(dates);
      expect(c.bestStreakWeeks, 5);
      expect(c.currentStreakWeeks, 1);
    });

    test('longestStreak reads the whole list, window or not', () {
      final dates = [for (var w = 0; w < 30; w++) _daysAgo(7 * w)];
      expect(Consistency.longestStreak(dates), 30);
    });
  });
}
