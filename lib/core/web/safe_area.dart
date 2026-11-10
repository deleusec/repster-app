/// The device's safe-area insets as the web page measures them.
///
/// Flutter's web engine does not read `env(safe-area-inset-*)`, so an
/// installed iOS web app that draws under the status bar (which it must, or
/// iOS paints a black band there) would put the header under the clock. The
/// page measures the insets in CSS (see `web/index.html`) and the app merges
/// them into `MediaQuery` at the root (see `RepsterApp`).
///
/// Off the web this is always zero: native platforms report their insets.
///
/// Selected on `dart.library.html` (true for the JS build, false for native
/// and Wasm): `dart.library.js_interop` is true on every platform, so it
/// cannot tell the web apart.
library;

export 'safe_area_stub.dart' if (dart.library.html) 'safe_area_web.dart';
