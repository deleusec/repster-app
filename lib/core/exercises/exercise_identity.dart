/// Exercise identity — the one place that decides what "the same exercise"
/// means, and the single door through which the `exercises` table is written.
///
/// The module exists because an exercise has **three** names and only one
/// identity:
///   * `exercises.name` — the canonical name, English for certified rows
///   * `exercise_names` — one primary name per locale, plus free aliases
///   * `session_exercises.name` — the label frozen at save time, a snapshot of
///     what the user saw that day, in the app language of that day
///
/// Treating any of those as the identity splits one movement per language and
/// per spelling. The identity is the row id, with the normalized name as the
/// only fallback for an exercise the catalog does not know.
///
/// What lives where:
///   * `exercise_name_key.dart` — `exerciseNameKey` / `exerciseIdentityKey`:
///     normalization and identity, pure Dart, mirrors of the DB's own rules
///   * `exercise_display_name.dart` — `exerciseDisplayName`: the name to
///     *show*, localized, mirror of the `search_exercises` RPC
///   * `certified_exercise_index.dart` — name → id over the certified catalog
///   * `exercise_resolution.dart` — `planExerciseResolution`: the resolution
///     precedence, pure and tested
///   * `exercise_resolver.dart` — the only writer of `exercises`
///
/// Import this file rather than the parts: callers get the whole vocabulary,
/// and `domain/` can still depend on `exercise_name_key.dart` alone, which
/// pulls in neither Supabase nor Riverpod.
library;

export 'package:repster/core/exercises/certified_exercise_index.dart';
export 'package:repster/core/exercises/exercise_display_name.dart';
export 'package:repster/core/exercises/exercise_name_key.dart';
export 'package:repster/core/exercises/exercise_resolution.dart';
export 'package:repster/core/exercises/exercise_resolver.dart';
