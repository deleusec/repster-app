import 'package:repster/features/dashboard/domain/in_progress_session_info.dart';

/// Maps a DB row → [InProgressSessionInfo] from an unfinished
/// `workout_sessions` row (columns `id, template_id, template_name,
/// started_at`).
class InProgressSessionInfoDto {
  const InProgressSessionInfoDto._();

  static InProgressSessionInfo fromRow(Map<String, dynamic> row) {
    return InProgressSessionInfo(
      sessionId: row['id'] as String,
      templateId: row['template_id'] as String?,
      templateName: row['template_name'] as String,
      startedAt: DateTime.parse(row['started_at'] as String),
    );
  }
}
