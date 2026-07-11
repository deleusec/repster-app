import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/dashboard/domain/in_progress_session_info.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_dialog.dart';

/// Starts a session from a template, guarding any session already in progress.
///
/// Starting a session **permanently deletes** the in-progress one (invariant:
/// one active session per user, see `SessionsRepository`), so the user is
/// warned before launching.
Future<void> startTemplateSession(
  BuildContext context,
  WidgetRef ref,
  String templateId,
) async {
  final InProgressSessionInfo? inProgress;
  try {
    inProgress = await ref
        .read(dashboardControllerProvider.notifier)
        .checkInProgress();
  } on Object catch (_) {
    // If the check fails, launch anyway rather than blocking the user.
    if (context.mounted) unawaited(context.push(Routes.session(templateId)));
    return;
  }
  if (!context.mounted) return;

  if (inProgress != null) {
    final ok = await AppDialog.confirm(
      context,
      title: t.session.confirm.inProgressTitle,
      message: t.session.confirm.inProgressMessage(
        name: inProgress.templateName,
        date: relativeDate(inProgress.startedAt),
      ),
      confirmLabel: t.session.confirm.overwriteAndStart,
      destructive: true,
    );
    if (ok != true || !context.mounted) return;
  }

  unawaited(context.push(Routes.session(templateId)));
}
