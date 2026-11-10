import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/supabase/postgrest_error_x.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/features/templates/domain/program.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// CRUD repository for the `programs` table, plus the activation RPC.
class ProgramsRepository {
  ProgramsRepository(this._client);

  final sb.SupabaseClient _client;

  String get _userId {
    final id = _client.auth.currentUser?.id;
    if (id == null) {
      throw const AppAuthException(
        'Not authenticated',
        reason: AuthFailureReason.notSignedIn,
      );
    }
    return id;
  }

  static Program fromRow(Map<String, dynamic> row) => Program(
    id: row['id'] as String,
    name: row['name'] as String,
    isActive: (row['is_active'] as bool?) ?? false,
  );

  Future<List<Program>> fetchAll() async {
    try {
      final rows = await _client
          .from('programs')
          .select('id, name, is_active')
          .eq('user_id', _userId)
          .order('position', ascending: true)
          .order('created_at', ascending: true);
      return rows.map(fromRow).toList(growable: false);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<Program> create(String name) async {
    try {
      final userId = _userId;
      final last = await _client
          .from('programs')
          .select('position')
          .eq('user_id', userId)
          .order('position', ascending: false)
          .limit(1);
      final position = last.isEmpty ? 0 : (last.first['position'] as int) + 1;
      final row = await _client
          .from('programs')
          .insert({
            'user_id': userId,
            'name': name.trim(),
            'position': position,
          })
          .select('id, name, is_active')
          .single();
      return fromRow(row);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<void> rename(String id, String name) async {
    try {
      await _client
          .from('programs')
          .update({'name': name.trim()})
          .eq('id', id)
          .eq('user_id', _userId);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Deletes the program only: its sessions are released, not deleted.
  Future<void> delete(String id) async {
    try {
      await _client
          .from('programs')
          .delete()
          .eq('id', id)
          .eq('user_id', _userId);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  /// Switches a program and its sessions on or off. Turning one on turns the
  /// other programs off — one transaction on the server.
  Future<void> setActive(String id, {required bool isActive}) async {
    try {
      await _client.rpc<void>(
        'set_active_program',
        params: {'p_program_id': id, 'p_active': isActive},
      );
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<void> reorder(List<String> orderedIds) async {
    if (orderedIds.isEmpty) return;
    try {
      final userId = _userId;
      await Future.wait([
        for (var i = 0; i < orderedIds.length; i++)
          _client
              .from('programs')
              .update({'position': i})
              .eq('id', orderedIds[i])
              .eq('user_id', userId),
      ]);
    } on Object catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }
}

final programsRepositoryProvider = Provider<ProgramsRepository>((ref) {
  return ProgramsRepository(ref.watch(supabaseClientProvider));
});
