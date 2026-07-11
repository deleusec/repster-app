import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/supabase/postgrest_error_x.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/features/exercises/data/catalog_exercise_dto.dart';
import 'package:repster/features/exercises/domain/catalog_exercise.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// Read access to the searchable exercise catalog — certified "Repster"
/// exercises plus the user's own — backed by the `search_exercises` Postgres
/// RPC. Matching is accent-insensitive and spans every name/alias/translation;
/// each result carries a [CatalogExercise.displayName] already localized to the
/// requested locale. RLS keeps results scoped to certified + caller-owned rows.
class ExercisesCatalogRepository {
  ExercisesCatalogRepository(this._client);

  final sb.SupabaseClient _client;

  /// Searches the catalog. An empty [query] returns the catalog ordered by
  /// display name (capped by [limit]). [locale] is a 2-letter code
  /// (`en`/`fr`/`es`/`de`/`it`); unknown locales fall back to English.
  Future<List<CatalogExercise>> search(
    String query, {
    required String locale,
    int limit = 30,
  }) async {
    try {
      final rows = await _client.rpc<List<dynamic>>(
        'search_exercises',
        params: {
          'p_query': query.trim(),
          'p_locale': locale,
          'p_limit': limit,
        },
      );
      return rows
          .cast<Map<String, dynamic>>()
          .map(CatalogExerciseDto.fromRow)
          .toList(growable: false);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }
}

final exercisesCatalogRepositoryProvider = Provider<ExercisesCatalogRepository>(
  (ref) => ExercisesCatalogRepository(ref.watch(supabaseClientProvider)),
);
