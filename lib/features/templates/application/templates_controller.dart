import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/emoji/fluent_emoji.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/templates/data/templates_repository.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_slot.dart';

/// Global state of the current user's template list. Hydrated via
/// `TemplatesRepository.fetchAll()`; exposes every mutation.
class TemplatesController extends AsyncNotifier<List<Template>> {
  TemplatesRepository get _repo => ref.read(templatesRepositoryProvider);

  @override
  Future<List<Template>> build() => _repo.fetchAll();

  Future<void> refresh() async {
    state = const AsyncLoading<List<Template>>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _repo.fetchAll());
  }

  /// The dashboard fetches its own copy of the active templates (carousel).
  /// Invalidate after any mutation so it reflects the changes.
  void _syncDashboard() => ref.invalidate(dashboardControllerProvider);

  Future<String> create({
    required String name,
    required String description,
    required List<TemplateSlot> slots,
    required FluentEmoji emoji,
    String? programId,
    bool isActive = true,
  }) async {
    final id = await _repo.create(
      name: name,
      description: description,
      slots: slots,
      emoji: emoji,
      programId: programId,
      isActive: isActive,
    );
    await refresh();
    _syncDashboard();
    return id;
  }

  Future<void> save({
    required String id,
    required String name,
    required String description,
    required List<TemplateSlot> slots,
    required FluentEmoji emoji,
  }) async {
    await _repo.update(
      id: id,
      name: name,
      description: description,
      slots: slots,
      emoji: emoji,
    );
    await refresh();
    _syncDashboard();
  }

  Future<void> delete(String id) async {
    // Optimistic: remove locally, refetch on failure.
    final previous = state.valueOrNull;
    if (previous != null) {
      state = AsyncData<List<Template>>(
        previous.where((t) => t.id != id).toList(growable: false),
      );
    }
    try {
      await _repo.delete(id);
      _syncDashboard();
    } on Object {
      // Rollback: re-fetch from the server.
      await refresh();
      rethrow;
    }
  }

  Future<String> duplicate(String id) async {
    final newId = await _repo.duplicate(id);
    await refresh();
    _syncDashboard();
    return newId;
  }

  Future<void> toggleActive(String id, {required bool isActive}) async {
    final previous = state.valueOrNull;
    if (previous != null) {
      state = AsyncData<List<Template>>(
        previous
            .map((t) => t.id == id ? t.copyWith(isActive: isActive) : t)
            .toList(growable: false),
      );
    }
    try {
      await _repo.toggleActive(id, isActive: isActive);
      _syncDashboard();
    } on Object {
      await refresh();
      rethrow;
    }
  }

  /// Files a session under [programId], or takes it out with `null`.
  Future<void> moveToProgram(String id, String? programId) async {
    final previous = state.valueOrNull;
    if (previous != null) {
      // Moved sessions land at the end of their new group.
      final moved = previous.firstWhere((t) => t.id == id);
      state = AsyncData<List<Template>>([
        for (final t in previous)
          if (t.id != id) t,
        moved.copyWith(programId: programId),
      ]);
    }
    try {
      await _repo.moveToProgram(id, programId);
      _syncDashboard();
    } on Object {
      await refresh();
      rethrow;
    }
  }

  /// Reorders one group of sessions — a program's, or the loose ones.
  /// [orderedIds] must hold every session of that group.
  Future<void> reorder(List<String> orderedIds) async {
    final previous = state.valueOrNull;
    if (previous != null) {
      // The group keeps the slots it occupied in the list; only the order
      // inside those slots changes.
      final byId = {for (final t in previous) t.id: t};
      final group = orderedIds.toSet();
      final next = orderedIds.iterator;
      state = AsyncData<List<Template>>([
        for (final t in previous)
          if (group.contains(t.id) && next.moveNext())
            byId[next.current]!
          else
            t,
      ]);
    }
    try {
      await _repo.reorder(orderedIds);
      _syncDashboard();
    } on Object {
      await refresh();
      rethrow;
    }
  }

  /// Mirrors what `set_active_program` does to the sessions on the server,
  /// so the page answers before the round trip. Local only.
  void applyProgramActivation(String programId, {required bool isActive}) {
    final previous = state.valueOrNull;
    if (previous == null) return;
    state = AsyncData<List<Template>>([
      for (final t in previous)
        if (t.programId == null)
          t
        else if (isActive)
          t.copyWith(isActive: t.programId == programId)
        else if (t.programId == programId)
          t.copyWith(isActive: false)
        else
          t,
    ]);
  }

  /// A deleted program releases its sessions. Local only.
  void releaseProgram(String programId) {
    final previous = state.valueOrNull;
    if (previous == null) return;
    state = AsyncData<List<Template>>([
      for (final t in previous)
        if (t.programId == programId) t.copyWith(programId: null) else t,
    ]);
  }
}

final templatesControllerProvider =
    AsyncNotifierProvider<TemplatesController, List<Template>>(
      TemplatesController.new,
    );

/// Convenience lookup by id — derived from the cached list.
final templateByIdProvider = Provider.family<AsyncValue<Template>, String>((
  ref,
  id,
) {
  final list = ref.watch(templatesControllerProvider);
  return list.whenData((items) {
    final found = items.where((t) => t.id == id).toList(growable: false);
    if (found.isEmpty) {
      throw StateError('Template $id not found');
    }
    return found.first;
  });
});
