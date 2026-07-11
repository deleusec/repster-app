import 'package:repster/features/stats/domain/stats_range.dart';
import 'package:repster/i18n/translations.g.dart';

/// Translated labels for a [StatsRange]. Lives in the presentation layer to
/// keep the domain pure (the enum doesn't import generated translations).
extension StatsRangeL10n on StatsRange {
  String get localizedLabel => switch (this) {
    StatsRange.last4Weeks => t.stats.range.last4Weeks.label,
    StatsRange.last3Months => t.stats.range.last3Months.label,
    StatsRange.all => t.stats.range.all.label,
  };

  String get localizedShort => switch (this) {
    StatsRange.last4Weeks => t.stats.range.last4Weeks.short,
    StatsRange.last3Months => t.stats.range.last3Months.short,
    StatsRange.all => t.stats.range.all.short,
  };
}
