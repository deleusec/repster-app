import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/dashboard/domain/in_progress_session_info.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/templates/domain/template.dart';

part 'dashboard_data.freezed.dart';

@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData({
    required AuthUser user,
    required List<Template> activeTemplates,
    required List<WorkoutSessionSummary> recentSessions,
    InProgressSessionInfo? inProgress,
  }) = _DashboardData;

  const DashboardData._();
}
