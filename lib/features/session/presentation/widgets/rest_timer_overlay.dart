import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/session/presentation/widgets/timer_ring.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/glass_surface.dart';

/// Shared height for the full-screen actions ("Skip" / "Minimize") so they are
/// exactly identical.
const double _restActionHeight = 56;

/// Rest overlay: full-screen ring (with ± adjustments) or a minimized pill at
/// the bottom. Driven by the screen (the countdown is computed screen-side from
/// the state).
class RestTimerOverlay extends StatelessWidget {
  const RestTimerOverlay({
    required this.seconds,
    required this.total,
    required this.startedAt,
    required this.minimized,
    required this.onSkip,
    required this.onExtend,
    required this.onMinimize,
    required this.onExpand,
    super.key,
  });

  final int seconds;
  final int total;

  /// Rest start, used by the continuous gauge ([CountdownRing]).
  final DateTime startedAt;
  final bool minimized;
  final VoidCallback onSkip;
  final ValueChanged<int> onExtend;
  final VoidCallback onMinimize;
  final VoidCallback onExpand;

  @override
  Widget build(BuildContext context) {
    return minimized ? _buildMini(context) : _buildFull(context);
  }

  double get _progress => total > 0 ? (seconds / total).clamp(0, 1) : 0;

  Widget _buildFull(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: ColoredBox(
          // Slightly more transparent to let the session show through the blur.
          color: scheme.surface.withValues(alpha: 0.7),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        t.session.rest.title,
                        style: TextStyle(
                          color: scheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 24,
                        height: 1,
                        color: scheme.primary.withValues(alpha: 0.4),
                      ),
                    ],
                  ),
                  CountdownRing(
                    startedAt: startedAt,
                    totalSeconds: total,
                    color: scheme.primary,
                    trackColor: onSurface.withValues(alpha: 0.1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$seconds',
                          style: TextStyle(
                            color: onSurface,
                            fontSize: seconds.toString().length <= 2 ? 88 : 64,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -4,
                            height: 1,
                          ),
                        ),
                        Text(
                          t.session.rest.sec,
                          style: TextStyle(
                            color: onSurface.withValues(alpha: 0.5),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          for (final delta in const [-30, -10, 10, 30]) ...[
                            Expanded(
                              child: _AdjustChip(
                                delta: delta,
                                onTap: () => onExtend(delta),
                              ),
                            ),
                            if (delta != 30) const SizedBox(width: 8),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _RestAction(
                              icon: LucideIcons.skipForward,
                              label: t.session.rest.skip,
                              background: scheme.primary,
                              foreground: scheme.onPrimary,
                              onTap: onSkip,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _RestAction(
                              icon: LucideIcons.chevronDown,
                              label: t.session.rest.minimize,
                              background: scheme.surfaceContainer,
                              foreground: onSurface,
                              borderColor: onSurface.withValues(alpha: 0.1),
                              onTap: onMinimize,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMini(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Positioned(
      left: 16,
      right: 16,
      bottom: MediaQuery.paddingOf(context).bottom + 80,
      // Glass pill: background blur + translucent tint + hairline (via
      // `GlassSurface`), consistent with the sheets / drawers. The floating
      // shadow stays on the outer box, behind the clip.
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.55),
              blurRadius: 40,
              spreadRadius: -8,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: GlassSurface(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 12, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onExpand,
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            children: [
                              CountdownRing(
                                startedAt: startedAt,
                                totalSeconds: total,
                                color: scheme.primary,
                                trackColor: onSurface.withValues(alpha: 0.1),
                                size: 46,
                                stroke: 3.5,
                                glow: true,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      t.session.rest.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: onSurface.withValues(alpha: 0.5),
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          '$seconds',
                                          style: TextStyle(
                                            color: onSurface,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: -1.5,
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          's',
                                          style: TextStyle(
                                            color: onSurface.withValues(
                                              alpha: 0.5,
                                            ),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                LucideIcons.chevronUp,
                                size: 14,
                                color: onSurface.withValues(alpha: 0.4),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 44,
                        color: onSurface.withValues(alpha: 0.1),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      FilledButton(
                        onPressed: onSkip,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          minimumSize: const Size(0, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.xl),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(LucideIcons.skipForward, size: 15),
                            const SizedBox(width: 6),
                            Text(t.session.rest.skip),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.5,
                  child: Row(
                    children: [
                      Expanded(
                        flex: (_progress * 1000).round(),
                        child: ColoredBox(color: scheme.primary),
                      ),
                      Expanded(
                        flex: 1000 - (_progress * 1000).round(),
                        child: ColoredBox(
                          color: onSurface.withValues(alpha: 0.1),
                        ),
                      ),
                    ],
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

class _AdjustChip extends StatelessWidget {
  const _AdjustChip({required this.delta, required this.onTap});

  final int delta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: onSurface.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Container(
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: Text(
            delta > 0 ? '+${delta}s' : '${delta}s',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: onSurface.withValues(alpha: 0.9),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-screen rest action ("Skip" / "Minimize").
///
/// Both buttons share EXACTLY the same geometry (height, radius, padding, icon
/// and text sizes); only the colors differ, guaranteeing two buttons identical
/// in size.
class _RestAction extends StatelessWidget {
  const _RestAction({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
    this.borderColor,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;
  final Color? borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.xxl);
    return Material(
      color: background,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Container(
          height: _restActionHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: borderColor != null
                ? Border.all(color: borderColor!)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: foreground),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: foreground,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
