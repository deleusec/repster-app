import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:repster/features/exercises/data/exercises_catalog_repository.dart';
import 'package:repster/features/exercises/domain/catalog_exercise.dart';
import 'package:repster/i18n/translations.g.dart';

/// Catalog search for the screens that autocomplete an exercise name.
///
/// The feature had no `application/` layer, so both callers reached into
/// `data/` themselves — the only place the presentation layer was breaking the
/// dependency rules. It also left each screen restating which locale to search
/// in; that belongs here, next to the search, not in a widget.
class ExercisesSearch {
  ExercisesSearch(this._repo);

  final ExercisesCatalogRepository _repo;

  /// Certified exercises plus the caller's own, matched accent-insensitively
  /// and returned with display names in the app's current language.
  Future<List<CatalogExercise>> search(String query) =>
      _repo.search(query, locale: LocaleSettings.currentLocale.languageCode);
}

final exercisesSearchProvider = Provider<ExercisesSearch>(
  (ref) => ExercisesSearch(ref.watch(exercisesCatalogRepositoryProvider)),
);
