import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/supabase/postgrest_error_x.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/features/contact/data/contact_request_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class ContactRepository {
  ContactRepository(this._client);

  final sb.SupabaseClient _client;

  Future<void> submit({
    required String name,
    required String email,
    required String category,
    required String message,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AppAuthException(
        'Not authenticated',
        reason: AuthFailureReason.notSignedIn,
      );
    }
    try {
      await _client
          .from('contact_requests')
          .insert(
            ContactRequestDto.toInsert(
              userId: user.id,
              name: name,
              email: email,
              category: category,
              message: message,
            ),
          );
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }
}

final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  return ContactRepository(ref.watch(supabaseClientProvider));
});
