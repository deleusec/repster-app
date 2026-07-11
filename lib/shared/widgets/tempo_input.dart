import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:repster/shared/widgets/app_text_field.dart';

/// Field for lifting tempo in the `E-P-C-P` format (eccentric - pause -
/// concentric - pause), e.g. `3-1-2-0` or `3-1-X-0` (X = explosive concentric).
/// Reformats live as you type: digits and `X`, with auto-inserted dashes.
class TempoInput extends StatefulWidget {
  const TempoInput({
    required this.value,
    required this.onChanged,
    this.label,
    this.helperText,
    super.key,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final String? label;
  final String? helperText;

  @override
  State<TempoInput> createState() => _TempoInputState();
}

class _TempoInputState extends State<TempoInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(TempoInput old) {
    super.didUpdateWidget(old);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      label: widget.label,
      hint: '3-1-2-0',
      helperText:
          widget.helperText ??
          'Excentrique — pause — concentrique — pause (en s)',
      keyboardType: TextInputType.text,
      inputFormatters: [_TempoFormatter()],
      onChanged: widget.onChanged,
    );
  }
}

/// Auto-inserts dashes between the 4 characters: `312X` → `3-1-2-X`. Accepts
/// digits and `X` (explosive concentric), normalized to uppercase.
class _TempoFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final chars = newValue.text.toUpperCase().replaceAll(RegExp('[^0-9X]'), '');
    final clamped = chars.length > 4 ? chars.substring(0, 4) : chars;
    final buf = StringBuffer();
    for (var i = 0; i < clamped.length; i++) {
      if (i > 0) buf.write('-');
      buf.write(clamped[i]);
    }
    final formatted = buf.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Validates a tempo. Returns `null` if valid, otherwise an error message.
String? validateTempo(String? input) {
  if (input == null || input.isEmpty) return null;
  final ok = RegExp(r'^[0-9X]-[0-9X]-[0-9X]-[0-9X]$').hasMatch(input);
  if (!ok) return 'Format attendu : 3-1-X-0';
  return null;
}
