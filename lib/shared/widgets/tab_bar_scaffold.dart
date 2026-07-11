import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/i18n/translations.g.dart';

/// Scaffold with bottom navigation, used by the
/// `StatefulShellRoute.indexedStack` app shell. Each tab's stack is preserved
/// across switches (scroll position, form state, in-flight loads).
///
/// Five tabs. The active background is an animated pill that slides toward the
/// tapped tab.
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

class _TabBar extends StatefulWidget {
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

  @override
  State<_TabBar> createState() => _TabBarState();
}

class _TabBarState extends State<_TabBar> {
  // Locally displayed index so the pill starts sliding on tap, without waiting
  // for the GoRouter shell to rebuild.
  late int _displayedIndex = widget.currentIndex;

  @override
  void didUpdateWidget(covariant _TabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex &&
        widget.currentIndex != _displayedIndex) {
      setState(() => _displayedIndex = widget.currentIndex);
    }
  }

  void _handleTap(int index) {
    if (index != _displayedIndex) {
      setState(() => _displayedIndex = index);
    }
    widget.onTap(index);
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth =
                      constraints.maxWidth / widget.destinations.length;
                  final pillLeft = _displayedIndex * itemWidth;
                  const pillTop = (_TabBar.barHeight - _TabBar.itemHeight) / 2;

                  return Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 320),
                        curve: Curves.easeOutCubic,
                        left: pillLeft,
                        top: pillTop,
                        width: itemWidth,
                        height: _TabBar.itemHeight,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: scheme.primary.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          for (var i = 0; i < widget.destinations.length; i++)
                            Expanded(
                              child: _TabItem(
                                destination: widget.destinations[i],
                                active: i == _displayedIndex,
                                onTap: () => _handleTap(i),
                              ),
                            ),
                        ],
                      ),
                    ],
                  );
                },
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

    return SizedBox(
      height: _TabBar.barHeight,
      child: Center(
        child: SizedBox(
          height: _TabBar.itemHeight,
          width: double.infinity,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            splashColor: scheme.primary.withValues(alpha: 0.08),
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  ),
                  child: HeroIcon(
                    destination.icon,
                    key: ValueKey(active),
                    style: active ? HeroIconStyle.solid : HeroIconStyle.outline,
                    size: 20,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 2),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
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
