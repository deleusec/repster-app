import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:repster/core/error/app_exception.dart';
import 'package:repster/core/supabase/postgrest_error_x.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  group('mapSupabaseError', () {
    test('PostgrestException PGRST116 → NotFoundException', () {
      final result = mapSupabaseError(
        const PostgrestException(message: 'no rows', code: 'PGRST116'),
      );
      expect(result, isA<NotFoundException>());
    });

    test('other PostgrestException → UnexpectedException', () {
      final result = mapSupabaseError(
        const PostgrestException(message: 'boom', code: '42P01'),
      );
      expect(result, isA<UnexpectedException>());
      expect(result.message, contains('boom'));
    });

    test('SocketException → NetworkException', () {
      final result = mapSupabaseError(const SocketException('offline'));
      expect(result, isA<NetworkException>());
    });

    test('AppException is returned as-is', () {
      const original = NotFoundException('déjà mappée');
      expect(mapSupabaseError(original), same(original));
    });

    test('unknown error → UnexpectedException', () {
      final result = mapSupabaseError(const FormatException('bad'));
      expect(result, isA<UnexpectedException>());
    });

    group('AuthException → AppAuthException with the right reason', () {
      AppAuthException mapAuth(String message) {
        final result = mapSupabaseError(AuthException(message));
        expect(result, isA<AppAuthException>());
        return result as AppAuthException;
      }

      test('invalid login credentials', () {
        expect(
          mapAuth('Invalid login credentials').reason,
          AuthFailureReason.invalidCredentials,
        );
      });

      test('email not confirmed', () {
        expect(
          mapAuth('Email not confirmed').reason,
          AuthFailureReason.emailNotConfirmed,
        );
      });

      test('user already registered', () {
        expect(
          mapAuth('User already registered').reason,
          AuthFailureReason.userAlreadyExists,
        );
      });

      test('token expired', () {
        expect(
          mapAuth('Token has expired').reason,
          AuthFailureReason.sessionExpired,
        );
      });

      test('unknown message → reason null', () {
        expect(mapAuth('Something odd happened').reason, isNull);
      });
    });
  });
}
