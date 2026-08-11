import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/exercises/exercise_resolution.dart';
import 'package:repster/core/logging/app_logger.dart';
import 'package:repster/core/supabase/postgrest_paging.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// Name → id lookup over the certified "Repster" catalog.
///
/// Exists so that recording an exercise never forks a private copy of a
/// certified one: two ids for the same movement split the user's history, and
/// the fork silently comes back on every save. Every write path goes through
/// `ExerciseResolver`, which consults this first.
///
/// Matching spans the canonical `exercises.name` **and** every `exercise_names`
/// row (aliases + translations): the app records *localized* display names, so
/// `Développé couché` and `Panca piana` both have to resolve to the one
/// `Barbell Bench Press`.
class CertifiedExerciseIndex {
  CertifiedExerciseIndex(this._client);

  final sb.SupabaseClient _client;

  Future<Map<String, String>>? _memo;

  /// The whole index, keyed by `exerciseNameKey`.
  ///
  /// Memoized: the catalog is global and read-only, so one fetch per app run
  /// serves every save. A failed fetch is not memoized — see [_fetch].
  Future<Map<String, String>> byKey() => _memo ??= _fetch();

  /// Drops the memo so the next read hits the network. For a catalog that grew
  /// while the app was running.
  void invalidate() => _memo = null;

  Future<Map<String, String>> _fetch() async {
    final List<Map<String, dynamic>> rows;
    try {
      // Paged: a truncated page would make the catalog look smaller than it is
      // and quietly fork a personal duplicate for every exercise past the cap.
      rows = await fetchAllRows(
        () => _client
            .from('exercises')
            .select('id, name, exercise_names ( name )')
            .eq('is_certified', true),
      );
    } on Object catch (e, st) {
      log.w('certified exercise index unavailable', error: e, stackTrace: st);
      // Not memoized: retry on the next call. Falling back to a personal
      // exercise is better than failing to record a workout.
      _memo = null;
      return const {};
    }
    final lookup = indexCertifiedExercises(rows);
    if (lookup.ambiguous.isNotEmpty) {
      // Not a client bug to work around: two catalog entries answering to one
      // name means the caller forks a personal row, so say so out loud.
      log.w(
        'certified catalog: ${lookup.ambiguous.length} name(s) claimed by two '
        'exercises, ignored — they will fork personal rows: '
        '${lookup.ambiguous.values.join(', ')}',
      );
    }
    return lookup.byKey;
  }
}

final certifiedExerciseIndexProvider = Provider<CertifiedExerciseIndex>(
  (ref) => CertifiedExerciseIndex(ref.watch(supabaseClientProvider)),
);
