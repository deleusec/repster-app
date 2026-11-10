import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/data/programs_repository.dart';
import 'package:repster/features/templates/domain/program.dart';

/// The current user's programs, in display order. Which sessions each one
/// holds lives on the templates (`Template.programId`).
class ProgramsController extends AsyncNotifier<List<Program>> {
  ProgramsRepository get _repo => ref.read(programsRepositoryProvider);
  TemplatesController get _templates =>
      ref.read(templatesControllerProvider.notifier);

  @override
  Future<List<Program>> build() => _repo.fetchAll();

  Future<void> refresh() async {
    state = const AsyncLoading<List<Program>>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _repo.fetchAll());
  }

  void _syncDashboard() => ref.invalidate(dashboardControllerProvider);

  Future<Program> create(String name) async {
    final program = await _repo.create(name);
    final previous = state.valueOrNull;
    if (previous != null) {
      state = AsyncData<List<Program>>([...previous, program]);
    } else {
      await refresh();
    }
    return program;
  }

  Future<void> rename(String id, String name) async {
    final previous = state.valueOrNull;
    if (previous != null) {
      state = AsyncData<List<Program>>([
        for (final p in previous)
          if (p.id == id) p.copyWith(name: name.trim()) else p,
      ]);
    }
    try {
      await _repo.rename(id, name);
    } on Object {
      await refresh();
      rethrow;
    }
  }

  /// Deletes the program and releases its sessions (they are kept).
  Future<void> delete(String id) async {
    final previous = state.valueOrNull;
    if (previous != null) {
      state = AsyncData<List<Program>>(
        previous.where((p) => p.id != id).toList(growable: false),
      );
    }
    _templates.releaseProgram(id);
    try {
      await _repo.delete(id);
    } on Object {
      await Future.wait([refresh(), _templates.refresh()]);
      rethrow;
    }
  }

  /// Switches a program on or off, its sessions with it. Only one program is
  /// active at a time: turning one on turns the others off.
  Future<void> setActive(String id, {required bool isActive}) async {
    final previous = state.valueOrNull;
    if (previous != null) {
      state = AsyncData<List<Program>>([
        for (final p in previous)
          if (p.id == id)
            p.copyWith(isActive: isActive)
          else if (isActive)
            p.copyWith(isActive: false)
          else
            p,
      ]);
    }
    _templates.applyProgramActivation(id, isActive: isActive);
    try {
      await _repo.setActive(id, isActive: isActive);
      _syncDashboard();
    } on Object {
      await Future.wait([refresh(), _templates.refresh()]);
      rethrow;
    }
  }

  Future<void> reorder(List<String> orderedIds) async {
    final previous = state.valueOrNull;
    if (previous != null) {
      final byId = {for (final p in previous) p.id: p};
      state = AsyncData<List<Program>>([
        for (final id in orderedIds)
          if (byId[id] case final p?) p,
      ]);
    }
    try {
      await _repo.reorder(orderedIds);
    } on Object {
      await refresh();
      rethrow;
    }
  }
}

final programsControllerProvider =
    AsyncNotifierProvider<ProgramsController, List<Program>>(
      ProgramsController.new,
    );
