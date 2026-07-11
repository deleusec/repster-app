import 'package:intl/intl.dart';
import 'package:repster/i18n/translations.g.dart';

/// Shared formatting helpers (duration, tonnage, relative dates). Single source
/// of truth, used by the dashboard and the history screen.
///
/// Dates follow `Intl.defaultLocale` (kept in sync with the current language by
/// `LanguageController` / `main`); relative labels come from slang.

/// `45min`, `1h05`, `30s`.
String formatDuration(int seconds) {
  if (seconds < 60) return '${seconds}s';
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  if (h > 0) return '${h}h${m.toString().padLeft(2, '0')}';
  return '${m}min';
}

/// `12.5 t`, `850 kg`, `–` when zero.
String formatTonnage(double kg) {
  if (kg <= 0) return '–';
  if (kg >= 1000) return '${(kg / 1000).toStringAsFixed(1)} t';
  return '${kg.round()} kg';
}

/// Clean weight: integer when round (`80`), otherwise one decimal (`82.5`).
String formatWeight(double kg) =>
    kg == kg.roundToDouble() ? kg.toStringAsFixed(0) : kg.toStringAsFixed(1);

/// Live session timer: `mm:ss` or `h:mm:ss`.
String formatSessionTimer(int seconds) {
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  final s = seconds % 60;
  final mm = m.toString().padLeft(2, '0');
  final ss = s.toString().padLeft(2, '0');
  if (h > 0) return '$h:$mm:$ss';
  return '$mm:$ss';
}

/// Hold duration: `30s`, `1m`, `1m30`.
String formatHoldDuration(int seconds) {
  final s = seconds < 0 ? 0 : seconds;
  if (s < 60) return '${s}s';
  final m = s ~/ 60;
  final rem = s % 60;
  if (rem == 0) return '${m}m';
  return '${m}m${rem.toString().padLeft(2, '0')}';
}

/// Formats a tempo entry `312X` → `3-1-2-X` (max 4 characters). Accepts digits
/// and `X` (explosive concentric), normalized to uppercase.
String formatTempoInput(String raw) {
  final chars = raw.toUpperCase().replaceAll(RegExp('[^0-9X]'), '');
  final capped = chars.length > 4 ? chars.substring(0, 4) : chars;
  return capped.split('').join('-');
}

/// Translated relative date: `just now`, `5 min ago`, `yesterday`, `3 d ago`,
/// then a short date (`Mar 12`) beyond one week.
String relativeDate(DateTime when) {
  final now = DateTime.now();
  final diff = now.difference(when);
  if (diff.inMinutes < 1) return t.common.date.justNow;
  if (diff.inHours < 1) return t.common.date.minutesAgo(n: diff.inMinutes);
  if (diff.inDays < 1) return t.common.date.hoursAgo(n: diff.inHours);
  if (diff.inDays == 1) return t.common.date.yesterday;
  if (diff.inDays < 7) return t.common.date.daysAgo(n: diff.inDays);
  return DateFormat('d MMM').format(when);
}

/// Localized short date (`Mar 12`).
String shortDate(DateTime when) => DateFormat('d MMM').format(when);

/// Localized date and time of a session, for the history screen.
String sessionStamp(DateTime when) {
  final d = DateFormat('EEE d MMM').format(when);
  final time = DateFormat('HH:mm').format(when);
  return '$d · $time';
}

/// Capitalized month and year, for history group headers.
String monthLabel(DateTime when) {
  final raw = DateFormat('MMMM yyyy').format(when);
  return raw[0].toUpperCase() + raw.substring(1);
}

const _accentMap = {
  'à': 'a',
  'á': 'a',
  'â': 'a',
  'ä': 'a',
  'ã': 'a',
  'å': 'a',
  'ç': 'c',
  'è': 'e',
  'é': 'e',
  'ê': 'e',
  'ë': 'e',
  'ì': 'i',
  'í': 'i',
  'î': 'i',
  'ï': 'i',
  'ñ': 'n',
  'ò': 'o',
  'ó': 'o',
  'ô': 'o',
  'ö': 'o',
  'õ': 'o',
  'ù': 'u',
  'ú': 'u',
  'û': 'u',
  'ü': 'u',
  'ý': 'y',
  'ÿ': 'y',
  'œ': 'oe',
  'æ': 'ae',
};

/// Normalizes a string for search: lowercased with accents stripped.
/// `Développé` → `developpe`, enabling accent-insensitive matching.
String foldAccents(String input) {
  final lower = input.toLowerCase();
  final buffer = StringBuffer();
  for (final char in lower.split('')) {
    buffer.write(_accentMap[char] ?? char);
  }
  return buffer.toString();
}
