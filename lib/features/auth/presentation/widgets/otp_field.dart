import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:repster/features/auth/presentation/widgets/auth_motion.dart';
import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';

/// Six-slot OTP field: each slot takes 1/6 of the width, 56 px tall,
/// rounded-2xl. When the code is complete without error, the slots switch to
/// the primary-tinted style.
class OtpField extends StatefulWidget {
  const OtpField({
    required this.value,
    required this.onChanged,
    this.length = 6,
    this.error = false,
    this.enabled = true,
    super.key,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final int length;
  final bool error;
  final bool enabled;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late final List<TextEditingController> _ctls;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _ctls = List.generate(widget.length, (_) => TextEditingController());
    _nodes = List.generate(widget.length, (_) => FocusNode());
    _hydrate(widget.value);
  }

  @override
  void didUpdateWidget(OtpField old) {
    super.didUpdateWidget(old);
    if (widget.value != _currentText) _hydrate(widget.value);
  }

  @override
  void dispose() {
    for (final c in _ctls) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _currentText => _ctls.map((c) => c.text).join();

  void _hydrate(String v) {
    final digits = v.replaceAll(RegExp('[^0-9]'), '');
    for (var i = 0; i < widget.length; i++) {
      _ctls[i].text = i < digits.length ? digits[i] : '';
    }
  }

  void _onDigit(int i, String value) {
    if (value.length > 1) {
      // Pasting a full code → distribute it across the slots.
      final digits = value.replaceAll(RegExp('[^0-9]'), '');
      for (var j = 0; j < widget.length; j++) {
        _ctls[j].text = j < digits.length ? digits[j] : '';
      }
      final next = digits.length >= widget.length
          ? widget.length - 1
          : digits.length;
      _nodes[next].requestFocus();
    } else if (value.isNotEmpty && i < widget.length - 1) {
      _nodes[i + 1].requestFocus();
    } else if (value.isEmpty && i > 0) {
      _nodes[i - 1].requestFocus();
    }
    widget.onChanged(_currentText);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isComplete = _currentText.length == widget.length;
    return Row(
      children: [
        for (var i = 0; i < widget.length; i++) ...[
          Expanded(
            child: _Slot(
              controller: _ctls[i],
              focusNode: _nodes[i],
              filled: _ctls[i].text.isNotEmpty,
              highlight: isComplete && !widget.error,
              primary: scheme.primary,
              enabled: widget.enabled,
              onChanged: (v) => _onDigit(i, v),
            ),
          ),
          if (i < widget.length - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _Slot extends StatelessWidget {
  const _Slot({
    required this.controller,
    required this.focusNode,
    required this.filled,
    required this.highlight,
    required this.primary,
    required this.enabled,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool filled;
  final bool highlight;
  final Color primary;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final bg = highlight ? primary.withValues(alpha: 0.12) : AuthTokens.cardBg;
    final border = highlight
        ? primary.withValues(alpha: 0.40)
        : AuthTokens.cardBorderStrong;
    return AnimatedContainer(
      duration: AuthMotion.feedback,
      curve: AuthMotion.curve,
      height: 56,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AuthTokens.radiusXl),
        border: Border.all(color: border),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        cursorColor: primary,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
        decoration: const InputDecoration(
          counterText: '',
          isCollapsed: true,
          filled: false,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
