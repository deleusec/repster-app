import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/root_scaffold_messenger.dart';
import 'package:repster/core/theme/app_colors.dart';

/// Ephemeral notifications in the design-system "glass" style: blurred
/// translucent dark background, hairline border, rounded corners, tinted icon.
/// Goes through the root messenger (see [rootScaffoldMessengerKey]) so it does
/// not depend on a page Scaffold.
class AppToast {
  const AppToast._();

  static void showSuccess(BuildContext context, String message) {
    _show(
      context,
      message,
      icon: LucideIcons.circleCheck,
      accent: AppColors.accentEmerald,
    );
  }

  static void showError(BuildContext context, String message) {
    _show(
      context,
      message,
      icon: LucideIcons.circleAlert,
      accent: Theme.of(context).colorScheme.error,
    );
  }

  static void showInfo(BuildContext context, String message) {
    _show(
      context,
      message,
      icon: LucideIcons.info,
      accent: Theme.of(context).colorScheme.primary,
    );
  }

  static void _show(
    BuildContext context,
    String message, {
    required IconData icon,
    required Color accent,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final messenger = rootScaffoldMessengerKey.currentState;
    if (messenger == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: const Duration(seconds: 3),
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          content: _GlassToast(
            icon: icon,
            accent: accent,
            message: message,
            scheme: scheme,
          ),
        ),
      );
  }
}

class _GlassToast extends StatelessWidget {
  const _GlassToast({
    required this.icon,
    required this.accent,
    required this.message,
    required this.scheme,
  });

  final IconData icon;
  final Color accent;
  final String message;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final onSurface = scheme.onSurface;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: onSurface.withValues(alpha: 0.10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(icon, size: 17, color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: onSurface.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
