import 'package:freezed_annotation/freezed_annotation.dart';

part 'in_progress_session_info.freezed.dart';

/// Metadata shown in the dashboard's "in-progress session" banner.
@freezed
class InProgressSessionInfo with _$InProgressSessionInfo {
  const factory InProgressSessionInfo({
    required String sessionId,
    required String templateName,
    required DateTime startedAt,
    String? templateId,
  }) = _InProgressSessionInfo;

  const InProgressSessionInfo._();
}
