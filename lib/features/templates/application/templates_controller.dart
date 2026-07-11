import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/templates/data/templates_repository.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
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
    required List<MuscleGroup> tags,
    required List<TemplateSlot> slots,
  }) async {
    final id = await _repo.create(
      name: name,
      description: description,
      tags: tags,
      slots: slots,
    );
    await refresh();
    _syncDashboard();
    return id;
  }

  Future<void> save({
    required String id,
    required String name,
    required String description,
    required List<MuscleGroup> tags,
    required List<TemplateSlot> slots,
  }) async {
    await _repo.update(
      id: id,
      name: name,
      description: description,
      tags: tags,
      slots: slots,
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

  Future<void> reorder(List<String> orderedIds) async {
    await _repo.reorder(orderedIds);
    await refresh();
    _syncDashboard();
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
