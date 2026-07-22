import 'dart:js_interop';

/// Subset of the (WebKit-only, experimental) `navigator.audioSession` API.
extension type _AudioSession._(JSObject _) implements JSObject {
  external String get type;
  external set type(String value);
}

extension type _Navigator._(JSObject _) implements JSObject {
  /// Present only on WebKit; `null` everywhere else (feature detection).
  external _AudioSession? get audioSession;
}

@JS('navigator')
external _Navigator get _navigator;

/// Asks iOS/WebKit to *duck* other audio (the user's music) for short cues
/// instead of interrupting it, by setting `navigator.audioSession.type` to
/// `'transient'` — the web counterpart of the native `duckOthers` option.
///
/// The API is non-standard and only exists on WebKit, so it is feature-detected
/// (`audioSession` is `null` elsewhere) and the whole call is wrapped so it can
/// never throw. A no-op where unsupported (the cue then behaves as before).
void configureWebAudioSessionForCues() {
  try {
    _navigator.audioSession?.type = 'transient';
  } on Object {
    // Unsupported / read-only on this browser: leave audio behaviour as-is.
  }
}
