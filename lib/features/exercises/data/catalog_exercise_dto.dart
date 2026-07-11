import 'package:repster/features/exercises/domain/catalog_exercise.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';

/// Maps a `search_exercises` RPC row → [CatalogExercise].
class CatalogExerciseDto {
  const CatalogExerciseDto._();

  static CatalogExercise fromRow(Map<String, dynamic> row) {
    return CatalogExercise(
      id: row['id'] as String,
      displayName: (row['display_name'] as String?)?.trim() ?? '',
      isCertified: (row['is_certified'] as bool?) ?? false,
      muscleGroups: MuscleGroup.listFromDb(
        row['muscle_groups'] as List<dynamic>?,
      ),
      category: row['category'] as String?,
      matchedVia: (row['matched_via'] as String?)?.trim(),
    );
  }
}
