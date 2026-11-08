import 'dart:js_interop';

import 'package:flutter/widgets.dart';

/// `window.repsterSafeArea()` from `web/index.html`: `[top, right, bottom,
/// left]` in CSS pixels, read from a probe element padded with
/// `env(safe-area-inset-*)`.
@JS('repsterSafeArea')
external JSArray<JSNumber>? _repsterSafeArea();

/// `window.repsterDiag()` from `web/index.html`: one line describing the
/// host (shell version, standalone mode, raw env values, status-bar meta,
/// viewport), for the settings footer.
@JS('repsterDiag')
external JSString? _repsterDiag();

/// The bottom inset an iOS home-screen app gets when the page reports none.
/// Installed from Safari the app runs edge to edge, so a zero here means
/// WebKit did not expose `env(safe-area-inset-bottom)`, not that there is
/// no home indicator; this is the floor the tab bar used to carry.
const double _iosStandaloneBottomFloor = 20;

bool get _isIosStandalone => webDiagnostics().contains('standalone=1');

/// What the page knows about its host, or `shell=old` when the running
/// `index.html` predates the hook.
String webDiagnostics() {
  try {
    return _repsterDiag()?.toDart ?? 'shell=old';
  } on Object {
    return 'shell=old';
  }
}

/// The insets the page measures, or zero when the shell does not provide
/// the hook (an old cached `index.html`, a test host).
EdgeInsets measuredSafeArea() {
  final probed = _probed();
  if (!_isIosStandalone || probed.bottom >= _iosStandaloneBottomFloor) {
    return probed;
  }
  return probed.copyWith(bottom: _iosStandaloneBottomFloor);
}

EdgeInsets _probed() {
  final JSArray<JSNumber>? raw;
  try {
    raw = _repsterSafeArea();
  } on Object {
    return EdgeInsets.zero;
  }
  if (raw == null) return EdgeInsets.zero;
  final values = raw.toDart;
  if (values.length < 4) return EdgeInsets.zero;
  double at(int i) {
    final v = values[i].toDartDouble;
    return v.isFinite && v > 0 ? v : 0;
  }

  return EdgeInsets.fromLTRB(at(3), at(0), at(1), at(2));
}
