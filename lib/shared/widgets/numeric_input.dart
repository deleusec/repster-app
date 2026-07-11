import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:repster/core/theme/app_colors.dart';

/// Compact numeric input for sets (reps, kg, seconds). Selects all on focus,
/// clamped to [min] / [max], with optional decimals.
class NumericInput extends StatefulWidget {
  const NumericInput({
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 9999,
    this.allowDecimal = false,
    this.placeholder,
    this.suffix,
    this.width = 72,
    this.height = 44,
    this.enabled = true,
    this.autofocus = false,
    this.textAlign = TextAlign.center,
    super.key,
  });

  /// Current value. `null` = empty field (show the placeholder).
  final num? value;
  final ValueChanged<num?> onChanged;
  final num min;
  final num max;
  final bool allowDecimal;
  final String? placeholder;
  final String? suffix;
  final double width;
  final double height;
  final bool enabled;
  final bool autofocus;
  final TextAlign textAlign;

  @override
  State<NumericInput> createState() => _NumericInputState();
}

class _NumericInputState extends State<NumericInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _format(widget.value));
    _focusNode = FocusNode()..addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(NumericInput old) {
    super.didUpdateWidget(old);
    if (widget.value != old.value && !_focusNode.hasFocus) {
      _controller.text = _format(widget.value);
    }
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  String _format(num? v) {
    if (v == null) return '';
    if (widget.allowDecimal) {
      if (v == v.truncate()) return v.toInt().toString();
      return v.toString();
    }
    return v.toInt().toString();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    } else {
      // Snap-back at end of edit.
      final parsed = _parse(_controller.text);
      _controller.text = _format(parsed);
    }
  }

  num? _parse(String raw) {
    if (raw.trim().isEmpty) return null;
    final v = num.tryParse(raw.replaceAll(',', '.'));
    if (v == null) return null;
    return v.clamp(widget.min, widget.max);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final field = SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        textAlign: widget.textAlign,
        keyboardType: TextInputType.numberWithOptions(
          decimal: widget.allowDecimal,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            widget.allowDecimal ? RegExp('[0-9.,]') : RegExp('[0-9]'),
          ),
        ],
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        onChanged: (text) => widget.onChanged(_parse(text)),
        decoration: InputDecoration(
          hintText: widget.placeholder,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          filled: true,
          fillColor: scheme.onSurface.withValues(alpha: 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.controlSm),
            borderSide: BorderSide(
              color: scheme.onSurface.withValues(alpha: 0.08),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.controlSm),
            borderSide: BorderSide(
              color: scheme.onSurface.withValues(alpha: 0.08),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.controlSm),
            borderSide: BorderSide(
              color: scheme.primary.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
        ),
      ),
    );

    if (widget.suffix == null) return field;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        field,
        const SizedBox(width: 4),
        Text(
          widget.suffix!,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
