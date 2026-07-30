import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/supabase/postgrest_error_x.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/features/dashboard/data/in_progress_session_info_dto.dart';
import 'package:repster/features/dashboard/data/workout_session_summary_dto.dart';
import 'package:repster/features/dashboard/domain/consistency.dart';
import 'package:repster/features/dashboard/domain/in_progress_session_info.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// Reads the data the dashboard needs (recent sessions, in-progress session).
/// Active templates are delegated to `templatesRepositoryProvider`.
class DashboardRepository {
  DashboardRepository(this._client);

  final sb.SupabaseClient _client;

  String get _userId {
    final id = _client.auth.currentUser?.id;
    if (id == null) {
      throw const AppAuthException(
        'Not authenticated',
        reason: AuthFailureReason.notSignedIn,
      );
    }
    return id;
  }

  /// Session start dates over the consistency window. One column, bounded by
  /// date: the heatmap needs when you trained, not what you lifted.
  Future<List<DateTime>> fetchTrainingDates({int weeks = kHeatmapWeeks}) async {
    try {
      final since = DateTime.now().subtract(Duration(days: 7 * weeks));
      final rows = await _client
          .from('workout_sessions')
          .select('started_at')
          .eq('user_id', _userId)
          .not('completed_at', 'is', null)
          .gte('started_at', since.toUtc().toIso8601String())
          .order('started_at', ascending: false);
      return [
        for (final row in rows.cast<Map<String, dynamic>>())
          if (DateTime.tryParse(row['started_at'] as String? ?? '')
              case final DateTime date)
            date,
      ];
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<List<WorkoutSessionSummary>> fetchRecentSessions({
    int limit = 30,
  }) async {
    try {
      final rows = await _client
          .from('workout_sessions')
          .select('''
id, template_id, template_name, started_at, completed_at, duration_seconds, tags,
session_exercises (
  is_time_based,
  session_sets (
    reps_performed, weight_kg, duration_performed_seconds, completed_at
  )
)
''')
          .eq('user_id', _userId)
          .not('completed_at', 'is', null)
          .order('started_at', ascending: false)
          .limit(limit);
      return rows.map(WorkoutSessionSummaryDto.fromRow).toList(growable: false);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<InProgressSessionInfo?> fetchInProgress() async {
    try {
      final rows = await _client
          .from('workout_sessions')
          .select('id, template_id, template_name, started_at')
          .eq('user_id', _userId)
          .filter('completed_at', 'is', null)
          .order('started_at', ascending: false)
          .limit(1);
      if (rows.isEmpty) return null;
      return InProgressSessionInfoDto.fromRow(rows.first);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }
}

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(ref.watch(supabaseClientProvider));
});
