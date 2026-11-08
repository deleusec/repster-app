import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_exercise.freezed.dart';

/// An exercise resolved from the searchable catalog: either a certified
/// "Repster" exercise ([isCertified]) or one of the user's own.
///
/// [displayName] is already localized to the requested locale (the primary
/// name for that language, English then the canonical name as fallbacks).
/// [matchedVia] is the actual name/alias/translation the query hit — useful to
/// surface "matched: `<alias>`" when it differs from [displayName].
@freezed
class CatalogExercise with _$CatalogExercise {
  const factory CatalogExercise({
    required String id,
    required String displayName,
    required bool isCertified,
    String? category,
    String? matchedVia,
  }) = _CatalogExercise;

  const CatalogExercise._();
}
