import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/auth/presentation/widgets/auth_tokens.dart';

/// Auth text field, aligned with the app's unified "glass" style: the
/// translucent background, hairline, radius, and focus ring come from the
/// global [InputDecorationTheme] — same as `AppTextField` elsewhere. Only the
/// auth-specific API is kept here (prefix, show/hide suffix button, red error
/// message under the field).
///
/// The suffix button ([suffixIcon] + [onSuffixTap]) is typically the
/// show/hide password eye.
class AuthInput extends StatelessWidget {
  const AuthInput({
    required this.controller,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.autocorrect = true,
    this.autofocus = false,
    this.enabled = true,
    this.maxLines = 1,
    this.focusNode,
    this.inputFormatters,
    this.autofillHints,
    this.errorText,
    super.key,
  });

  final TextEditingController controller;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool autocorrect;
  final bool autofocus;
  final bool enabled;
  final int maxLines;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasError = errorText != null && errorText!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          autofocus: autofocus,
          autocorrect: autocorrect,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          autofillHints: autofillHints,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          maxLines: obscureText ? 1 : maxLines,
          cursorColor: scheme.primary,
          // Background, hairline, radius, and focus ring inherited from the
          // global theme (InputDecorationTheme) → consistent with app inputs.
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 18) : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onSuffixTap,
                    icon: Icon(suffixIcon, size: 18),
                    color: scheme.onSurface.withValues(alpha: 0.4),
                    splashRadius: 20,
                    tooltip: 'Afficher / masquer',
                  )
                : null,
            // The auth error stays shown in red under the field; only the
            // border is colored here to match the error state.
            enabledBorder: hasError
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    borderSide: BorderSide(
                      color: AuthTokens.danger.withValues(alpha: 0.5),
                    ),
                  )
                : null,
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              errorText!,
              style: const TextStyle(fontSize: 12, color: AuthTokens.danger),
            ),
          ),
      ],
    );
  }
}
