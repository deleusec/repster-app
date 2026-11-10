import 'dart:js_interop';

import 'package:flutter/widgets.dart';

/// `window.repsterSafeArea()` from `web/index.html`: `[top, right, bottom,
/// left]` in CSS pixels, read from a probe element padded with
/// `env(safe-area-inset-*)`.
@JS('repsterSafeArea')
external JSArray<JSNumber>? _repsterSafeArea();

/// The insets the page measures, or zero when the shell does not provide
/// the hook (an old cached `index.html`, a test host).
EdgeInsets measuredSafeArea() {
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
