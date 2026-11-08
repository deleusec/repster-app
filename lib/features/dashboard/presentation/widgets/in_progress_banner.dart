import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/dashboard/domain/in_progress_session_info.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/app_dialog.dart';
import 'package:repster/shared/widgets/app_loading.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/pressable.dart';
import 'package:repster/shared/widgets/soft_glow.dart';

/// In-progress session banner — a gradient hero card with a pulsing LIVE dot,
/// a timeline bar and Resume / Discard actions.
class InProgressBanner extends ConsumerStatefulWidget {
  const InProgressBanner({required this.info, super.key});

  final InProgressSessionInfo info;

  @override
  ConsumerState<InProgressBanner> createState() => _InProgressBannerState();
}

class _InProgressBannerState extends ConsumerState<InProgressBanner> {
  bool _busy = false;

  Future<void> _discard() async {
    final ok = await AppDialog.confirm(
      context,
      title: t.dashboard.inProgress.discardTitle,
      message: t.dashboard.inProgress.discardMessage,
      confirmLabel: t.dashboard.inProgress.discard,
      destructive: true,
    );
    if (ok != true) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(dashboardControllerProvider.notifier)
          .discardInProgress(widget.info.sessionId);
    } on Object catch (_) {
      if (mounted) {
        AppToast.showError(context, t.dashboard.inProgress.discardError);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final primary = scheme.glow;
    final onSurface = scheme.onSurface;
    final info = widget.info;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.cardLg),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.cardLg),
          border: Border.all(color: primary.withValues(alpha: 0.25)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primary.withValues(alpha: 0.10),
              onSurface.withValues(alpha: 0.04),
              onSurface.withValues(alpha: 0.05),
            ],
            stops: const [0, 0.5, 1],
          ),
        ),
        child: Stack(
          children: [
            // Decorative halos.
            Positioned(
              bottom: -64,
              left: -64,
              child: SoftGlow(
                color: primary.withValues(alpha: 0.25),
                size: 208,
              ),
            ),
            Positioned(
              top: -40,
              right: -40,
              child: SoftGlow(
                color: primary.withValues(alpha: 0.12),
                size: 112,
                blur: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _LiveDot(color: primary),
                      const SizedBox(width: 8),
                      Text(
                        t.dashboard.inProgress.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.2,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    info.templateName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      color: onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.dashboard.inProgress.startedAt(
                      when: relativeDate(info.startedAt),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      color: onSurface.withValues(alpha: 0.40),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (info.templateId != null)
                        AppButton(
                          label: t.dashboard.inProgress.resume,
                          icon: Icons.play_arrow_rounded,
                          iconSize: 22,
                          size: AppButtonSize.sm,
                          onPressed: _busy
                              ? null
                              : () => context.push(
                                  Routes.session(
                                    info.templateId!,
                                    resume: true,
                                  ),
                                ),
                        ),
                      const SizedBox(width: 4),
                      _DiscardButton(
                        loading: _busy,
                        onTap: _busy ? null : _discard,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Understated "Discard" button: text + X in muted grey on a faint translucent
/// background — deliberately subdued next to the (pink) "Resume".
class _DiscardButton extends StatelessWidget {
  const _DiscardButton({required this.loading, required this.onTap});

  final bool loading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final fg = onSurface.withValues(alpha: 0.5);
    return Pressable(
      onTap: onTap,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onSurface.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppRadius.xxl),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading)
              AppSpinner(size: 14, color: fg)
            else
              Icon(LucideIcons.x, size: 15, color: fg),
            const SizedBox(width: 6),
            Text(
              t.dashboard.inProgress.discard,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// LIVE dot: a solid dot plus a ring that expands on a loop.
class _LiveDot extends StatelessWidget {
  const _LiveDot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 8,
      height: 8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.75),
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .scaleXY(
                begin: 1,
                end: 2.6,
                duration: 1200.ms,
                curve: Curves.easeOut,
              )
              .fadeOut(duration: 1200.ms),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        ],
      ),
    );
  }
}
