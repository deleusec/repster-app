import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/i18n/translations.g.dart';

/// Sticky page header with title, optional subtitle, back button and actions.
/// Large left-aligned title, with a hairline under the content when scrolled.
class PageHeader extends StatelessWidget implements PreferredSizeWidget {
  const PageHeader({
    required this.title,
    this.subtitle,
    this.actions,
    this.leading,
    this.showBack = false,
    this.centerTitle = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBack;
  final bool centerTitle;

  @override
  Size get preferredSize => Size.fromHeight(subtitle != null ? 84 : 64);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final canPop = showBack && Navigator.of(context).canPop();

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      leadingWidth: canPop || leading != null ? 56 : 0,
      leading: canPop
          ? IconButton(
              icon: const Icon(LucideIcons.chevronLeft),
              onPressed: () => Navigator.of(context).maybePop(),
              tooltip: t.common.actions.back,
            )
          : leading,
      title: Column(
        crossAxisAlignment: centerTitle
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            // Titles are bold (w700), not extrabold — w800 is for display
            // numbers only (see AppText).
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ],
      ),
      actions: actions,
    );
  }
}
