import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/logging/app_logger.dart';
// Web-only: hints WebKit to duck (not interrupt) the user's music. No-op on
// native, where the AudioContext below handles ducking.
import 'package:repster/features/session/application/web_audio_session_stub.dart'
    if (dart.library.js_interop) 'package:repster/features/session/application/web_audio_session_web.dart';

/// Live-session sounds: rest-end chime plus start/end beeps for the
/// time-based exercise timer (pre-rendered as WAV assets in `assets/audio/`).
///
/// Each sound has its own [AudioPlayer] (`stop` mode, low latency). Playback
/// never blocks the UI and errors are swallowed.
///
/// The sounds *duck* the user's own audio (music, podcast) instead of stopping
/// it: while a cue plays, the system lowers the other app's volume, then
/// restores it automatically. This is driven entirely by the [AudioContext]
/// below — no manual volume juggling.
class SessionAudio {
  SessionAudio() {
    _ready = _init();
  }

  static const _restChime = 'audio/rest_chime.wav';
  static const _timerStart = 'audio/timer_start.wav';
  static const _timerEnd = 'audio/timer_end.wav';

  /// Ducking context: keep the user's music playing (mixed) but temporarily
  /// lowered while a cue sounds.
  ///
  /// - Android: `gainTransientMayDuck` requests transient focus that asks the
  ///   other app to duck; focus is released when the cue finishes, restoring
  ///   the music.
  /// - iOS: `playback` + `duckOthers` ducks other audio; `mixWithOthers` keeps
  ///   it playing. `playback` also lets cues sound while the ringer is on
  ///   silent — a rest-end beep must be heard.
  static final AudioContext _duckingContext = AudioContext(
    android: const AudioContextAndroid(
      audioFocus: AndroidAudioFocus.gainTransientMayDuck,
    ),
    iOS: AudioContextIOS(
      // Default category is `playback`.
      options: const {
        AVAudioSessionOptions.mixWithOthers,
        AVAudioSessionOptions.duckOthers,
      },
    ),
  );

  final Map<String, AudioPlayer> _players = {
    _restChime: AudioPlayer(playerId: 'rest_chime'),
    _timerStart: AudioPlayer(playerId: 'timer_start'),
    _timerEnd: AudioPlayer(playerId: 'timer_end'),
  };

  late final Future<void> _ready;
  bool _unlocked = false;

  /// Unlocks audio on the web: browsers (iOS Safari especially) only allow
  /// sound to start from within a user gesture, but our cues fire from Timers
  /// (rest end, timer preroll/end) — so without priming they stay silent. Call
  /// this from a real tap early in the session; it plays each cue muted once to
  /// satisfy the autoplay policy. No-op on native and after the first call.
  Future<void> unlock() async {
    if (!kIsWeb || _unlocked) return;
    _unlocked = true;
    // Ask WebKit to duck (not stop) the user's music while cues play.
    configureWebAudioSessionForCues();
    try {
      await _ready;
      for (final entry in _players.entries) {
        final player = entry.value;
        await player.setVolume(0);
        await player.play(AssetSource(entry.key));
        await player.stop();
        await player.setVolume(1);
      }
    } on Object catch (e, st) {
      log.w('SessionAudio unlock failed', error: e, stackTrace: st);
    }
  }

  Future<void> _init() async {
    try {
      await AudioPlayer.global.setAudioContext(_duckingContext);
      for (final p in _players.values) {
        await p.setReleaseMode(ReleaseMode.stop);
      }
    } on Object catch (e, st) {
      log.w('SessionAudio init failed', error: e, stackTrace: st);
    }
  }

  Future<void> _play(String asset) async {
    final player = _players[asset];
    if (player == null) return;
    try {
      await _ready;
      await player.stop();
      await player.play(AssetSource(asset));
    } on Object catch (e, st) {
      log.w('SessionAudio play failed ($asset)', error: e, stackTrace: st);
    }
  }

  Future<void> restEnd() => _play(_restChime);
  Future<void> timerStart() => _play(_timerStart);
  Future<void> timerEnd() => _play(_timerEnd);

  void dispose() {
    for (final p in _players.values) {
      p.dispose();
    }
  }
}

/// Provides a shared [SessionAudio], disposed automatically.
final sessionAudioProvider = Provider<SessionAudio>((ref) {
  final audio = SessionAudio();
  ref.onDispose(audio.dispose);
  return audio;
});
