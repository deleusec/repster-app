/// Time window for stats computation.
enum StatsRange {
  last4Weeks,
  last3Months,
  all;

  Duration? get window => switch (this) {
    StatsRange.last4Weeks => const Duration(days: 28),
    StatsRange.last3Months => const Duration(days: 92),
    StatsRange.all => null,
  };

  String get label => switch (this) {
    StatsRange.last4Weeks => '4 semaines',
    StatsRange.last3Months => '3 mois',
    StatsRange.all => 'Tout',
  };
}
