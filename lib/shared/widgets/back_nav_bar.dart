import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';

/// The 38×38 square icon button the pushed screens use in their nav bar.
///
/// Distinct from a Material [IconButton] on purpose: same size and ink as the
/// PWA's, with a faint fill and border rather than a bare glyph.
class NavIconButton extends StatelessWidget {
  const NavIconButton({
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.busy = false,
    super.key,
  });

  final IconData icon;

  /// `null` disables the button — how a screen greys its action out while a
  /// save is in flight.
  final VoidCallback? onTap;

  final String? tooltip;

  /// Swaps the icon for a spinner, same footprint so the bar does not jump.
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final button = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.controlSm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.controlSm),
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppRadius.controlSm),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: busy
              ? SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: onSurface.withValues(alpha: 0.6),
                  ),
                )
              : Icon(
                  icon,
                  size: 17,
                  color: onSurface.withValues(alpha: 0.6),
                ),
        ),
      ),
    );
    final message = tooltip;
    return message == null ? button : Tooltip(message: message, child: button);
  }
}

/// Nav bar for a screen pushed above the tab shell: a back button, optionally
/// a centred title and a trailing action.
///
/// Six screens had grown their own private copy of this — profile, contact,
/// change-password and the three legal documents — which is how the same bar
/// ended up with six chances to drift apart.
class BackNavBar extends StatelessWidget {
  const BackNavBar({
    required this.onBack,
    this.title,
    this.actionIcon,
    this.onAction,
    this.actionTooltip,
    this.actionBusy = false,
    super.key,
  });

  final VoidCallback onBack;

  /// Spaced uppercase label, centred between the two buttons.
  final String? title;

  final IconData? actionIcon;

  /// `null` leaves the action visible but disabled.
  final VoidCallback? onAction;

  final String? actionTooltip;
  final bool actionBusy;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final back = NavIconButton(icon: LucideIcons.chevronLeft, onTap: onBack);

    // The plain case keeps its own layout rather than a Row with two empty
    // slots: it is what most callers need, and it stays a single child.
    if (title == null && actionIcon == null) {
      return Align(alignment: Alignment.centerLeft, child: back);
    }

    return Row(
      children: [
        back,
        Expanded(
          child: title == null
              ? const SizedBox.shrink()
              : Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: onSurface.withValues(alpha: 0.3),
                  ),
                ),
        ),
        // Balances the back button so a title stays centred, action or not.
        if (actionIcon case final icon?)
          NavIconButton(
            icon: icon,
            onTap: onAction,
            tooltip: actionTooltip,
            busy: actionBusy,
          )
        else
          const SizedBox(width: 38),
      ],
    );
  }
}
