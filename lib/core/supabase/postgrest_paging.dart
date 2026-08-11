import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// Rows asked for per page. A hint, not a contract: the server caps each page
/// at its own `max_rows`, which the client cannot read — so [fetchAllRows] is
/// written to be correct whatever that cap turns out to be.
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
  var from = 0;
  while (true) {
    final page = await query().range(from, from + pageSize - 1);
    // Only an empty page ends the walk, and the cursor advances by what the
    // server actually returned — never by what was asked for.
    //
    // Treating a short page as the last one would reintroduce the very bug this
    // function exists to prevent: the server caps a page at its own `max_rows`,
    // and if that cap is below [pageSize] then *every* page comes back short.
    // The walk would stop after the first one and report a truncated read as
    // complete. A range past the end answers `200` with `[]`, so the extra
    // request this costs is safe.
    if (page.isEmpty) return all;
    all.addAll(page);
    from += page.length;
  }
}
