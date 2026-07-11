import 'package:flutter/material.dart';

import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_dialog.dart';

/// "Quit the session?" dialog. Returns `true` if confirmed. Delegates to
/// [AppDialog.confirm] (shared glass modal).
Future<bool> showCancelDialog(BuildContext context) async {
  final ok = await AppDialog.confirm(
    context,
    title: t.session.confirm.quitTitle,
    message: t.session.confirm.quitMessage,
    cancelLabel: t.session.continueLabel,
    confirmLabel: t.session.confirm.quitConfirm,
    destructive: true,
  );
  return ok ?? false;
}
