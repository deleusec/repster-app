import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';

/// -/value/+ control with press-and-hold repeat (400 ms then 100 ms). The
/// [accent] variant tints it with the primary color.
class StepperControl extends StatefulWidget {
  const StepperControl({
    required this.label,
    required this.displayValue,
    required this.onDecrement,
    required this.onIncrement,
    this.accent = false,
    super.key,
  });

  final String label;
  final String displayValue;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final bool accent;

  @override
  State<StepperControl> createState() => _StepperControlState();
}

class _StepperControlState extends State<StepperControl> {
  Timer? _delay;
  Timer? _repeat;

  void _start(VoidCallback action) {
    action();
    HapticFeedback.selectionClick();
    _delay = Timer(const Duration(milliseconds: 400), () {
      _repeat = Timer.periodic(const Duration(milliseconds: 100), (_) {
        action();
      });
    });
  }

  void _stop() {
    _delay?.cancel();
    _repeat?.cancel();
    _delay = null;
    _repeat = null;
  }

  @override
  void dispose() {
    _stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final accentColor = widget.accent ? scheme.primary : onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: widget.accent
                ? scheme.primary.withValues(alpha: 0.10)
                : onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: widget.accent
                  ? scheme.primary.withValues(alpha: 0.40)
                  : onSurface.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            children: [
              _RepeatButton(
                icon: LucideIcons.minus,
                color: widget.accent
                    ? scheme.primary
                    : onSurface.withValues(alpha: 0.6),
                onStart: () => _start(widget.onDecrement),
                onStop: _stop,
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.displayValue,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: accentColor,
                    ),
                  ),
                ),
              ),
              _RepeatButton(
                icon: LucideIcons.plus,
                color: widget.accent
                    ? scheme.primary
                    : onSurface.withValues(alpha: 0.6),
                onStart: () => _start(widget.onIncrement),
                onStop: _stop,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RepeatButton extends StatelessWidget {
  const _RepeatButton({
    required this.icon,
    required this.color,
    required this.onStart,
    required this.onStop,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onStart(),
      onTapUp: (_) => onStop(),
      onTapCancel: onStop,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
