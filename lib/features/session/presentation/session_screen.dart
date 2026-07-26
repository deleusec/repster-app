import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/exercises/application/exercises_search.dart';
import 'package:repster/features/exercises/domain/catalog_exercise.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/session/application/live_session_controller.dart';
import 'package:repster/features/session/application/live_session_state.dart';
import 'package:repster/features/session/application/rest_notifier.dart';
import 'package:repster/features/session/application/session_audio.dart';
import 'package:repster/features/session/domain/last_perf.dart';
import 'package:repster/features/session/domain/session_block.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/session/presentation/widgets/add_exercise_drawer.dart';
import 'package:repster/features/session/presentation/widgets/cancel_dialog.dart';
import 'package:repster/features/session/presentation/widgets/exercise_history_sheet.dart';
import 'package:repster/features/session/presentation/widgets/exercise_timer_overlay.dart';
import 'package:repster/features/session/presentation/widgets/exercise_view.dart';
import 'package:repster/features/session/presentation/widgets/finish_modal.dart';
import 'package:repster/features/session/presentation/widgets/overview_panel.dart';
import 'package:repster/features/session/presentation/widgets/rest_timer_overlay.dart';
import 'package:repster/features/session/presentation/widgets/superset_block_view.dart';
import 'package:repster/features/session/presentation/widgets/swap_exercise_drawer.dart';
import 'package:repster/features/session/presentation/widgets/variant_picker_drawer.dart';
import 'package:repster/features/stats/application/stats_controller.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/glass_surface.dart';
import 'package:uuid/uuid.dart';

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({
    required this.templateId,
    this.resume = false,
    super.key,
  });

  final String templateId;
  final bool resume;

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen>
    with WidgetsBindingObserver {
  static const _uuid = Uuid();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _ticker;
  int _elapsed = 0;
  int _restRemaining = 0;
  bool _restMinimized = false;
  bool _bootstrapped = false;
  bool _restSoundFired = false;
  DateTime? _lastRestStart;
  DateTime? _notifiedRestEnd;
  ({int exIdx, int setIdx})? _timerSet;

  /// Captured in [initState] so it stays usable in [dispose], where `ref` is
  /// no longer accessible.
  late final RestNotifier _restNotifier;

  LiveSessionController get _ctl =>
      ref.read(liveSessionControllerProvider.notifier);

  @override
  void initState() {
    super.initState();
    _restNotifier = ref.read(restNotifierProvider);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_bootstrapped) return;
      _bootstrapped = true;
      await _ctl.enter(widget.templateId, resume: widget.resume);
    });
    _ticker = Timer.periodic(const Duration(milliseconds: 500), (_) => _tick());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
    _restNotifier
      ..cancel()
      ..cancelRestDone();
    super.dispose();
  }

  /// The rest-end chime is normally played in-app by [_tick], but the ticker is
  /// suspended while the app is backgrounded. So on the way out we schedule the
  /// chime as an alarm (fires while locked); on the way back we cancel it — and
  /// if rest already ended meanwhile, suppress the in-app chime to avoid a
  /// double.
  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycle) {
    final state = ref.read(liveSessionControllerProvider);
    if (!state.isResting || state.restStartedAt == null) return;
    final endsAt = state.restStartedAt!.add(
      Duration(seconds: state.restTotalSeconds),
    );
    switch (lifecycle) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        if (endsAt.isAfter(DateTime.now())) {
          _restNotifier.scheduleRestDone(endsAt: endsAt);
        }
      case AppLifecycleState.resumed:
        _restNotifier.cancelRestDone();
        if (!endsAt.isAfter(DateTime.now())) {
          // Rest ended while backgrounded: the scheduled chime already sounded.
          _restSoundFired = true;
        }
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  /// Removes the lock-screen rest notification, if any is showing.
  void _cancelRestNotification() {
    if (_notifiedRestEnd == null) return;
    _notifiedRestEnd = null;
    _restNotifier.cancel();
  }

  void _tick() {
    if (!mounted) return;
    final state = ref.read(liveSessionControllerProvider);
    final session = state.session;
    if (session == null) return;
    // Active time, not wall clock: the displayed clock must be the duration
    // that will be saved, freeze included.
    final elapsed = state.activeSecondsAt(DateTime.now());

    var remaining = 0;
    if (state.isResting && state.restStartedAt != null) {
      final since = DateTime.now().difference(state.restStartedAt!).inSeconds;
      remaining = state.restTotalSeconds - since;
      if (state.restStartedAt != _lastRestStart) {
        _lastRestStart = state.restStartedAt;
        _restSoundFired = false;
        _restMinimized = false;
      }
      if (remaining <= 0) {
        remaining = 0;
        if (!_restSoundFired) {
          _restSoundFired = true;
          ref.read(sessionAudioProvider).restEnd();
        }
        _cancelRestNotification();
        _ctl.skipRest();
      } else {
        // Mirror the countdown on the lock screen. `endsAt` changes on +30s,
        // which updates the same notification in place.
        final endsAt = state.restStartedAt!.add(
          Duration(seconds: state.restTotalSeconds),
        );
        if (endsAt != _notifiedRestEnd) {
          _notifiedRestEnd = endsAt;
          _restNotifier.show(endsAt: endsAt);
        }
      }
    } else {
      _lastRestStart = null;
      _cancelRestNotification();
    }

    setState(() {
      _elapsed = elapsed;
      _restRemaining = remaining;
    });
  }

  // ── lastPerfs key / refetch after swap / variant / add ─────────────────────

  Future<void> _refetchPerfs(
    String name,
    bool isTimeBased,
    String? exerciseId,
  ) async {
    final key = lastPerfKey(
      exerciseName: name,
      isTimeBased: isTimeBased,
      exerciseId: exerciseId,
    );
    try {
      final res = await _ctl.lastPerfsForExercise(
        name: name,
        isTimeBased: isTimeBased,
        exerciseId: exerciseId,
      );
      if (res == null) {
        _ctl.setLastPerfsFor(key, const []);
      } else {
        _ctl.setLastPerfsFor(key, res.perfs, meta: res.meta);
      }
    } on Object {
      // Network error: keep the existing cache.
    }
  }

  // ── Drawer actions ─────────────────────────────────────────────────────────

  /// Live catalog search (certified Repster exercises + the user's own),
  /// localized to the current app language.
  Future<List<CatalogExercise>> _search(String query) =>
      ref.read(exercisesSearchProvider).search(query);

  Future<void> _openSwap(int exIdx) async {
    final session = ref.read(liveSessionControllerProvider).session;
    if (session == null || exIdx >= session.exercises.length) return;
    final ex = session.exercises[exIdx];
    final data = await showSwapDrawer(
      context,
      currentName: ex.name,
      currentRestTime: ex.restTime,
      currentNotes: ex.notes,
      currentTempo: ex.tempo,
      search: _search,
      currentExerciseId: ex.exerciseId,
    );
    if (data == null) return;
    _ctl.updateExerciseMeta(
      exIdx,
      name: data.name,
      restTime: data.restTime,
      notes: data.notes,
      tempo: data.tempo,
      exerciseId: data.exerciseId,
    );
    // Keep the current format; refresh the last-perf ghosts for the new name.
    await _refetchPerfs(data.name, ex.isTimeBased, data.exerciseId);
  }

  void _openHistory(int exIdx) {
    final session = ref.read(liveSessionControllerProvider).session;
    if (session == null || exIdx >= session.exercises.length) return;
    final name = session.exercises[exIdx].name;
    unawaited(
      showExerciseHistorySheet(
        context,
        name: name,
        future: _ctl.exerciseHistory(name),
      ),
    );
  }

  Future<void> _openVariants(int exIdx) async {
    final session = ref.read(liveSessionControllerProvider).session;
    if (session == null || exIdx >= session.exercises.length) return;
    final ex = session.exercises[exIdx];
    final variants = ex.variants ?? const [];
    final idx = await showVariantPicker(
      context,
      variants: variants,
      activeIndex: ex.activeVariantIndex ?? 0,
      anyCompleted: ex.sets.any((s) => s.completed),
    );
    if (idx == null || idx >= variants.length) return;
    final ok = _ctl.switchVariant(exIdx, idx);
    if (!ok) {
      if (mounted) {
        AppToast.showError(context, t.session.toast.finishOrSwap);
      }
      return;
    }
    final v = variants[idx];
    await _refetchPerfs(v.name, v.isTimeBased, v.exerciseId);
  }

  Future<void> _openAdd() async {
    final data = await showAddExerciseDrawer(context, search: _search);
    if (data == null) return;
    final current = ref
        .read(liveSessionControllerProvider)
        .currentExerciseIndex;
    final sets = [
      for (var i = 0; i < data.setsCount; i++)
        WorkoutSet(
          id: _uuid.v4(),
          setNumber: i + 1,
          targetReps: data.isTimeBased ? 0 : data.targetReps,
          actualReps: data.isTimeBased ? 0 : data.targetReps,
          weight: 0,
          completed: false,
          targetSeconds: data.isTimeBased ? data.targetSeconds : null,
          actualSeconds: data.isTimeBased ? 0 : null,
        ),
    ];
    _ctl.addExercise(
      WorkoutExercise(
        id: _uuid.v4(),
        name: data.name,
        exerciseId: data.exerciseId,
        notes: data.notes,
        tempo: data.tempo,
        restTime: data.restTime,
        sets: sets,
        isTimeBased: data.isTimeBased,
        slotId: _uuid.v4(),
        sessionModified: true,
      ),
      insertAfter: current,
    );
    await _refetchPerfs(data.name, data.isTimeBased, data.exerciseId);
    if (mounted) {
      AppToast.showSuccess(
        context,
        t.session.toast.exerciseAdded(name: data.name),
      );
    }
  }

  // ── Finish / cancel ──────────────────────────────────────────────────────

  Future<void> _finish() async {
    final session = ref.read(liveSessionControllerProvider).session;
    if (session == null) return;
    final completed = session.completedSets;
    if (completed == 0) {
      AppToast.showError(context, t.session.toast.validateOneSet);
      return;
    }
    final totalSets = session.exercises.fold<int>(
      0,
      (n, ex) => n + ex.sets.length,
    );
    final incomplete = [
      for (final ex in session.exercises)
        if (ex.completedSetCount < ex.sets.length)
          IncompleteExercise(
            name: ex.name,
            completed: ex.completedSetCount,
            total: ex.sets.length,
          ),
    ];
    await showFinishSheet(
      context,
      tonnage: session.tonnageKg,
      completedSets: completed,
      totalSets: totalSets,
      incomplete: incomplete,
      onConfirm: (notes) => _ctl.endAndSave(notes),
    );
    if (!mounted) return;
    final status = ref.read(liveSessionControllerProvider).status;
    if (status == LiveSessionStatus.finished) {
      // The session is complete: the dashboard and history must reflect it
      // (banner removed, new session on top).
      ref
        ..invalidate(dashboardControllerProvider)
        ..invalidate(historyControllerProvider)
        ..invalidate(statsSessionsProvider);
      AppToast.showSuccess(context, t.session.toast.sessionSaved);
      context.go(Routes.history);
    }
  }

  Future<void> _cancel() async {
    final ok = await showCancelDialog(context);
    if (!ok) return;
    await _ctl.discard();
    // The in-progress session was deleted from the DB: refresh the dashboard
    // so the "in progress" banner disappears.
    ref.invalidate(dashboardControllerProvider);
    if (mounted) context.go(Routes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    // A failure while the session is running (typically a failed save) has no
    // place to render: only the `idle` branch below shows `state.error`.
    // Without this the finish sheet would just stop spinning, silently.
    ref.listen(liveSessionControllerProvider, (prev, next) {
      final error = next.error;
      if (error == null || error == prev?.error) return;
      if (next.status == LiveSessionStatus.idle) return;
      AppToast.showError(context, error);
    });
    final state = ref.watch(liveSessionControllerProvider);
    // Unlock web audio on the first tap: cues fire from Timers, which the
    // browser autoplay policy would otherwise mute (see [SessionAudio.unlock]).
    // Idempotent + web-only, so this is harmless on native.
    return Listener(
      onPointerDown: (_) => ref.read(sessionAudioProvider).unlock(),
      child: Scaffold(
        key: _scaffoldKey,
        drawerScrimColor: Colors.black.withValues(alpha: kGlassScrimAlpha),
        endDrawer: OverviewPanel(onGoTo: _ctl.goToExercise, onAdd: _openAdd),
        body: switch (state.status) {
          LiveSessionStatus.idle when state.error != null => _ErrorBody(
            message: state.error!,
            onBack: () => context.pop(),
          ),
          LiveSessionStatus.idle || LiveSessionStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
          LiveSessionStatus.finished => const Center(
            child: CircularProgressIndicator(),
          ),
          LiveSessionStatus.running ||
          LiveSessionStatus.saving => _buildRunning(context, state),
        },
      ),
    );
  }

  Widget _buildRunning(BuildContext context, LiveSessionState state) {
    final session = state.session!;
    final scheme = Theme.of(context).colorScheme;
    final blocks = computeBlocks(session.exercises);
    final currentBlockIndex = blocks.indexWhere(
      (b) => b.exerciseIndices.contains(state.currentExerciseIndex),
    );
    final currentBlock = currentBlockIndex >= 0
        ? blocks[currentBlockIndex]
        : null;
    final isLastBlock = currentBlockIndex == blocks.length - 1;

    final completedAll = session.exercises.fold<int>(
      0,
      (n, ex) => n + ex.completedSetCount,
    );
    final totalAll = session.exercises.fold<int>(
      0,
      (n, ex) => n + ex.sets.length,
    );
    final progress = totalAll > 0 ? completedAll / totalAll : 0.0;

    void goToBlock(int idx) {
      if (idx < 0 || idx >= blocks.length) return;
      _ctl.goToExercise(blocks[idx].exerciseIndices.first);
    }

    return Stack(
      children: [
        Column(
          children: [
            _Header(
              templateName: session.templateName,
              completedSets: completedAll,
              totalSets: totalAll,
              elapsed: _elapsed,
              progress: progress,
              onCancel: _cancel,
              onOverview: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
            _BlockNav(
              label: currentBlock?.isSuperset ?? false
                  ? t.session.live.supersetPosition(
                      current: currentBlockIndex + 1,
                      total: blocks.length,
                    )
                  : t.session.live.exercisePosition(
                      current: currentBlockIndex + 1,
                      total: blocks.length,
                    ),
              canPrev: currentBlockIndex > 0,
              canNext: !isLastBlock,
              onPrev: () => goToBlock(currentBlockIndex - 1),
              onNext: () => goToBlock(currentBlockIndex + 1),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  state.isResting && _restMinimized ? 176 : 16,
                ),
                child: currentBlock == null
                    ? const SizedBox.shrink()
                    : (currentBlock.isSuperset
                          ? SupersetBlockView(
                              block: currentBlock,
                              onOpenSwap: _openSwap,
                              onOpenVariants: _openVariants,
                              onOpenHistory: _openHistory,
                              onStartTimer: _startTimer,
                            )
                          : ExerciseView(
                              exerciseIndex: currentBlock.exerciseIndices.first,
                              onOpenSwap: _openSwap,
                              onOpenVariants: _openVariants,
                              onOpenHistory: _openHistory,
                              onStartTimer: _startTimer,
                            )),
              ),
            ),
            _BottomBar(
              tonnage: session.tonnageKg,
              isLastBlock: isLastBlock,
              isSuperset: currentBlock?.isSuperset ?? false,
              onFinish: _finish,
              onNext: () => goToBlock(currentBlockIndex + 1),
            ),
          ],
        ),
        if (state.isResting)
          RestTimerOverlay(
            seconds: _restRemaining,
            total: state.restTotalSeconds,
            startedAt: state.restStartedAt ?? DateTime.now(),
            minimized: _restMinimized,
            onSkip: _ctl.skipRest,
            onExtend: _ctl.extendRest,
            onMinimize: () => setState(() => _restMinimized = true),
            onExpand: () => setState(() => _restMinimized = false),
          ),
        if (_timerSet != null) _buildTimerOverlay(session, scheme),
      ],
    );
  }

  void _startTimer(int exIdx, int setIdx) {
    setState(() => _timerSet = (exIdx: exIdx, setIdx: setIdx));
  }

  Widget _buildTimerOverlay(WorkoutSession session, ColorScheme scheme) {
    final ts = _timerSet!;
    if (ts.exIdx >= session.exercises.length) return const SizedBox.shrink();
    final ex = session.exercises[ts.exIdx];
    if (ts.setIdx >= ex.sets.length) return const SizedBox.shrink();
    final set = ex.sets[ts.setIdx];
    return ExerciseTimerOverlay(
      targetSeconds: set.targetSeconds ?? kDefaultHoldSeconds,
      audio: ref.read(sessionAudioProvider),
      onCancel: () => setState(() => _timerSet = null),
      onComplete: (actualSeconds) {
        _ctl
          ..updateSet(ts.exIdx, ts.setIdx, actualSeconds: actualSeconds)
          ..completeSet(ts.exIdx, ts.setIdx);
        setState(() => _timerSet = null);
      },
    );
  }
}

// ─── Header ─────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({
    required this.templateName,
    required this.completedSets,
    required this.totalSets,
    required this.elapsed,
    required this.progress,
    required this.onCancel,
    required this.onOverview,
  });

  final String templateName;
  final int completedSets;
  final int totalSets;
  final int elapsed;
  final double progress;
  final VoidCallback onCancel;
  final VoidCallback onOverview;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.paddingOf(context).top + 12,
        16,
        12,
      ),
      child: Column(
        children: [
          Row(
            children: [
              _IconChipButton(icon: LucideIcons.x, onTap: onCancel),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      templateName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: onSurface,
                      ),
                    ),
                    Text(
                      t.session.live.headerSubtitle(
                        completed: completedSets,
                        total: totalSets,
                        time: formatSessionTimer(elapsed),
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _IconChipButton(icon: LucideIcons.list, onTap: onOverview),
              const SizedBox(width: 8),
              Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: onSurface.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.clock,
                      size: 13,
                      color: onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      formatSessionTimer(elapsed),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: onSurface.withValues(alpha: 0.08),
              color: scheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Block navigation ─────────────────────────────────────────────────────

class _BlockNav extends StatelessWidget {
  const _BlockNav({
    required this.label,
    required this.canPrev,
    required this.canNext,
    required this.onPrev,
    required this.onNext,
  });

  final String label;
  final bool canPrev;
  final bool canNext;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          _IconChipButton(
            icon: LucideIcons.chevronLeft,
            onTap: canPrev ? onPrev : null,
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          _IconChipButton(
            icon: LucideIcons.chevronRight,
            onTap: canNext ? onNext : null,
          ),
        ],
      ),
    );
  }
}

// ─── Bottom bar ─────────────────────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.tonnage,
    required this.isLastBlock,
    required this.isSuperset,
    required this.onFinish,
    required this.onNext,
  });

  final double tonnage;
  final bool isLastBlock;
  final bool isSuperset;
  final VoidCallback onFinish;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        10,
        16,
        MediaQuery.paddingOf(context).bottom + 12,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: onSurface.withValues(alpha: 0.08)),
        ),
      ),
      // The tonnage (Expanded) absorbs free space and pushes the buttons to
      // the right edge; the buttons keep their natural size (flag + "next"
      // sized to content, same height).
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.session.live.totalTonnage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: onSurface.withValues(alpha: 0.5),
                  ),
                ),
                Text(
                  formatTonnage(tonnage),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _FinishButton(compact: !isLastBlock, onTap: onFinish),
          if (!isLastBlock) ...[
            const SizedBox(width: 10),
            _NextButton(
              label: isSuperset
                  ? t.session.live.nextBlock
                  : t.session.live.nextExercise,
              onTap: onNext,
            ),
          ],
        ],
      ),
    );
  }
}

class _FinishButton extends StatelessWidget {
  const _FinishButton({required this.compact, required this.onTap});

  final bool compact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const emerald = AppColors.accentEmerald;
    return Material(
      color: emerald.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: emerald.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.flag, size: 16, color: emerald),
              if (!compact) ...[
                const SizedBox(width: 8),
                Text(
                  t.session.live.finishSession,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: emerald,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Primary "next exercise/block" button. Deliberately built with a `Container`
/// (not `FilledButton`): the bottom bar can be measured with unbounded
/// constraints (infinite width/height) on the first web layout, which crashes
/// the `_InputPadding` of a Material button. A `Container` tolerates these
/// constraints.
class _NextButton extends StatelessWidget {
  const _NextButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.primary,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: scheme.onPrimary,
                ),
              ),
              const SizedBox(width: 4),
              Icon(LucideIcons.chevronRight, size: 16, color: scheme.onPrimary),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconChipButton extends StatelessWidget {
  const _IconChipButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final disabled = onTap == null;
    return Opacity(
      opacity: disabled ? 0.3 : 1,
      child: Material(
        color: onSurface.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: onTap,
          child: SizedBox(
            width: 36,
            height: 36,
            child: Icon(
              icon,
              size: 17,
              color: onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onBack});

  final String message;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.dumbbell,
            size: 40,
            color: onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(color: onSurface)),
          const SizedBox(height: 16),
          FilledButton(onPressed: onBack, child: Text(t.common.actions.back)),
        ],
      ),
    );
  }
}
