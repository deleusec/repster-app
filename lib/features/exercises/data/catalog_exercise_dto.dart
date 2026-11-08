import 'package:repster/features/exercises/domain/catalog_exercise.dart';

/// Maps a `search_exercises` RPC row → [CatalogExercise].
class CatalogExerciseDto {
  const CatalogExerciseDto._();

  static CatalogExercise fromRow(Map<String, dynamic> row) {
    return CatalogExercise(
      id: row['id'] as String,
      displayName: (row['display_name'] as String?)?.trim() ?? '',
      isCertified: (row['is_certified'] as bool?) ?? false,
      category: row['category'] as String?,
      matchedVia: (row['matched_via'] as String?)?.trim(),
    );
  }
}
