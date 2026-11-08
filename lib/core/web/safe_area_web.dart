import 'dart:js_interop';

import 'package:flutter/widgets.dart';

/// `window.repsterSafeArea()` from `web/index.html`: `[top, right, bottom,
/// left]` in CSS pixels, read from a probe element padded with
/// `env(safe-area-inset-*)`.
@JS('repsterSafeArea')
external JSArray<JSNumber>? _repsterSafeArea();

/// `navigator.standalone`: true only for an iOS home-screen web app.
@JS('navigator.standalone')
external JSBoolean? get _navigatorStandalone;

/// The bottom inset an iOS home-screen app gets when the page reports none.
/// Installed from Safari the app runs edge to edge, so a zero here means
/// WebKit did not expose `env(safe-area-inset-bottom)`, not that there is
/// no home indicator; this is the floor the tab bar used to carry.
const double _iosStandaloneBottomFloor = 20;

bool get _isIosStandalone {
  try {
    return _navigatorStandalone?.toDart ?? false;
  } on Object {
    return false;
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
