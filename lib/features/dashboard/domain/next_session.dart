import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/templates/domain/template.dart';

/// Next session of the program: the template that follows the last one
/// trained, cycling back to the first at the end. This is what ties the order
/// the user arranged their templates in to the order the sessions come up.
///
/// [templates] must be the active templates in program order, [sessions] the
/// completed sessions most recent first. When the last session's template is
/// gone (deleted or deactivated) the cycle restarts at the first template.
Template? suggestNextTemplate(
  List<Template> templates,
  List<WorkoutSessionSummary> sessions,
) {
  if (templates.isEmpty) return null;
  final lastId = sessions.isEmpty ? null : sessions.first.templateId;
  final lastIndex = lastId == null
      ? -1
      : templates.indexWhere((tpl) => tpl.id == lastId);
  return templates[(lastIndex + 1) % templates.length];
}
