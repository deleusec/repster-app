import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// Rows PostgREST returns in one page when no range is given. The server also
/// enforces its own `max_rows`; asking for pages smaller than or equal to it is
/// what keeps [fetchAllRows] from looping forever on a truncated page.
const int kPostgrestPageSize = 1000;

/// Every row [query] matches, read page by page.
///
/// For the reads that must be **exhaustive** to be correct, not merely
/// complete-looking. A plain `select()` is silently capped by the server's
/// `max_rows`: the rows past the cap simply do not come back, no error, no
/// flag. An exercise index built from a truncated page reports "this movement
/// is not in the catalog" and the caller forks a duplicate — the failure is
/// invisible until someone notices a split history months later.
///
/// [query] is a factory, not a builder: each page re-applies the filters from
/// scratch, since a builder can only be awaited once.
Future<List<Map<String, dynamic>>> fetchAllRows(
  sb.PostgrestTransformBuilder<sb.PostgrestList> Function() query, {
  int pageSize = kPostgrestPageSize,
}) async {
  final all = <Map<String, dynamic>>[];
  for (var from = 0; ; from += pageSize) {
    final page = await query().range(from, from + pageSize - 1);
    all.addAll(page);
    // A short page is the last one. An exactly-full page is ambiguous, so it
    // costs one more request to be sure.
    if (page.length < pageSize) return all;
  }
}
