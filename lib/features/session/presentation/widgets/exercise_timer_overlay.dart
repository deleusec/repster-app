import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/session/application/session_audio.dart';
import 'package:repster/features/session/presentation/widgets/timer_ring.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';

enum _Phase { preroll, running, done }

/// Overlay for the time-based exercise timer: 3-2-1 preroll, countdown with an
/// amber ring, then end beep + auto-completion.
class ExerciseTimerOverlay extends StatefulWidget {
  const ExerciseTimerOverlay({
    required this.targetSeconds,
    required this.audio,
    required this.onCancel,
    required this.onComplete,
    super.key,
  });

  final int targetSeconds;
  final SessionAudio audio;
  final VoidCallback onCancel;
  final ValueChanged<int> onComplete;

  @override
  State<ExerciseTimerOverlay> createState() => _ExerciseTimerOverlayState();
}

class _ExerciseTimerOverlayState extends State<ExerciseTimerOverlay> {
  _Phase _phase = _Phase.preroll;
  int _prerollLeft = 3;
  Timer? _prerollTimer;
  Timer? _tick;
  DateTime? _startedAt;
  int _elapsedSec = 0;
  bool _endFired = false;
  int _lastVibratedSec = -1;

  @override
  void initState() {
    super.initState();
    _startPreroll();
  }

  @override
  void dispose() {
    _prerollTimer?.cancel();
    _tick?.cancel();
    super.dispose();
  }

  void _startPreroll() {
    _prerollTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_prerollLeft <= 1) {
        _prerollTimer?.cancel();
        _startRunning();
      } else {
        setState(() => _prerollLeft -= 1);
      }
    });
  }

  void _startRunning() {
    setState(() {
      _phase = _Phase.running;
      _startedAt = DateTime.now();
    });
    widget.audio.timerStart();
    HapticFeedback.mediumImpact();
    _tick = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final started = _startedAt;
      if (started == null) return;
      final ms = DateTime.now().difference(started).inMilliseconds;
      final sec = ms ~/ 1000;
      if (sec != _lastVibratedSec) {
        _lastVibratedSec = sec;
        HapticFeedback.selectionClick();
      }
      final remaining = widget.targetSeconds - sec;
      if (remaining <= 0) {
        if (!_endFired) {
          _endFired = true;
          widget.audio.timerEnd();
          HapticFeedback.heavyImpact();
        }
        _tick?.cancel();
        setState(() {
          _phase = _Phase.done;
          _elapsedSec = widget.targetSeconds;
        });
        Timer(const Duration(milliseconds: 350), () {
          if (mounted) widget.onComplete(widget.targetSeconds);
        });
        return;
      }
      setState(() => _elapsedSec = sec);
    });
  }

  void _stop() {
    if (_phase == _Phase.preroll) {
      widget.onCancel();
      return;
    }
    final elapsed = _elapsedSec.clamp(0, widget.targetSeconds);
    widget.onComplete(elapsed);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    const amber = AppColors.accentAmber;
    final remaining = (widget.targetSeconds - _elapsedSec).clamp(
      0,
      widget.targetSeconds,
    );
    final progress = _phase == _Phase.running
        ? remaining / (widget.targetSeconds < 1 ? 1 : widget.targetSeconds)
        : 1.0;
    final remainingDisplay = formatHoldDuration(remaining);

    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: ColoredBox(
          color: scheme.surface.withValues(alpha: 0.85),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        switch (_phase) {
                          _Phase.preroll => t.session.timer.preparation,
                          _Phase.running => t.session.timer.running,
                          _Phase.done => t.session.timer.done,
                        },
                        style: const TextStyle(
                          color: amber,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 24,
                        height: 1,
                        color: amber.withValues(alpha: 0.4),
                      ),
                    ],
                  ),
                  if (_phase == _Phase.preroll)
                    Text(
                      _prerollLeft > 0 ? '$_prerollLeft' : t.session.timer.go,
                      style: TextStyle(
                        color: onSurface,
                        fontSize: 88,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -4,
                        height: 1,
                      ),
                    )
                  else
                    TimerRing(
                      progress: progress,
                      color: amber,
                      trackColor: onSurface.withValues(alpha: 0.1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            remainingDisplay,
                            style: TextStyle(
                              color: onSurface,
                              fontSize: remainingDisplay.length <= 3 ? 84 : 64,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -4,
                              height: 1,
                            ),
                          ),
                          Text(
                            '/${formatHoldDuration(widget.targetSeconds)}',
                            style: TextStyle(
                              color: onSurface.withValues(alpha: 0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: _StopButton(
                      preroll: _phase == _Phase.preroll,
                      onTap: _stop,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StopButton extends StatelessWidget {
  const _StopButton({required this.preroll, required this.onTap});

  final bool preroll;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Material(
      color: scheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                preroll ? LucideIcons.x : LucideIcons.square,
                size: 16,
                color: onSurface,
              ),
              const SizedBox(width: 8),
              Text(
                preroll ? t.common.actions.cancel : t.session.timer.stop,
                style: TextStyle(color: onSurface, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
