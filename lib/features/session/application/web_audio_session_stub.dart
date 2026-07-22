/// Non-web no-op. The real implementation lives in
/// `web_audio_session_web.dart` and is selected by a conditional import
/// (`dart.library.js_interop`). On native there is no browser audio session to
/// configure — the `AudioContext` in `SessionAudio` handles ducking there.
void configureWebAudioSessionForCues() {}
