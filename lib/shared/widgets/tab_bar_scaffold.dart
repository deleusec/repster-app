import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/pressable.dart';

/// Scaffold with bottom navigation, used by the
/// `StatefulShellRoute.indexedStack` app shell. Each tab's stack is preserved
/// across switches (scroll position, form state, in-flight loads).
///
/// Five tabs. Like the PWA, the active state is a plain 200ms cross-fade of the
/// item's background and colors — nothing slides, nothing pops.
class TabBarScaffold extends StatelessWidget {
  const TabBarScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  // Heroicons: solid when the tab is active, outline otherwise. Labels are
  // translated and rebuilt on every build (so they follow language changes).
  List<_TabDestination> _destinations() => [
    _TabDestination(icon: HeroIcons.squares2x2, label: t.nav.home),
    _TabDestination(icon: HeroIcons.rectangleStack, label: t.nav.program),
    _TabDestination(icon: HeroIcons.clock, label: t.nav.history),
    _TabDestination(icon: HeroIcons.chartBar, label: t.nav.stats),
    _TabDestination(icon: HeroIcons.cog6Tooth, label: t.nav.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _TabBar(
        currentIndex: navigationShell.currentIndex,
        destinations: _destinations(),
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.currentIndex,
    required this.destinations,
    required this.onTap,
  });

  final int currentIndex;
  final List<_TabDestination> destinations;
  final ValueChanged<int> onTap;

  // Dimensions mirror the PWA: h-16 container, h-13 items, px-2 padding.
  static const double barHeight = 64;
  static const double itemHeight = 52;
  static const double hPadding = 8;
  static const Duration transition = Duration(milliseconds: 200);

  void _handleTap(int index) {
    HapticFeedback.selectionClick();
    onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Top border: `white/[0.07]` in dark, the `border` token in light.
    final topBorder = isDark
        ? Colors.white.withValues(alpha: 0.07)
        : AppColors.lightBorder;

    return Material(
      color: scheme.surface,
      // The bottom inset is real on every platform now: native reports it,
      // and on the web the page measures `env(safe-area-inset-bottom)` and
      // the app merges it into MediaQuery (see `RepsterApp`).
      child: SafeArea(
        top: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: topBorder)),
          ),
          child: SizedBox(
            height: _TabBar.barHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: _TabBar.hPadding),
              child: Row(
                children: [
                  for (var i = 0; i < destinations.length; i++)
                    Expanded(
                      child: _TabItem(
                        destination: destinations[i],
                        active: i == currentIndex,
                        onTap: () => _handleTap(i),
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

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.destination,
    required this.active,
    required this.onTap,
  });

  final _TabDestination destination;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final muted = Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkMutedForeground
        : AppColors.lightMutedForeground;

    final iconColor = active ? scheme.primary : muted;
    final labelColor = active ? scheme.primary : muted.withValues(alpha: 0.6);
    final borderRadius = BorderRadius.circular(16);

    return SizedBox(
      height: _TabBar.barHeight,
      child: Center(
        child: AnimatedContainer(
          duration: _TabBar.transition,
          curve: Curves.easeOut,
          height: _TabBar.itemHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: active
                ? scheme.primary.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: borderRadius,
          ),
          child: Pressable(
            onTap: onTap,
            scale: 0.92,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeroIcon(
                  destination.icon,
                  style: active ? HeroIconStyle.solid : HeroIconStyle.outline,
                  size: 20,
                  color: iconColor,
                ),
                const SizedBox(height: 2),
                AnimatedDefaultTextStyle(
                  duration: _TabBar.transition,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.25,
                    color: labelColor,
                  ),
                  child: Text(
                    destination.label,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabDestination {
  const _TabDestination({required this.icon, required this.label});

  final HeroIcons icon;
  final String label;
}
