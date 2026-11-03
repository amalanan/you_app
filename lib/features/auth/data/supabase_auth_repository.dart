import 'dart:io' show SocketException;

import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../core/constants/app_strings.dart';
import '../../../core/errors/exceptions.dart';
import 'auth_repository.dart';

/// Accounts stored in Supabase (Auth). Screens do not know about it:
/// they only use [AuthRepository].
class SupabaseAuthRepository implements AuthRepository {
  sb.SupabaseClient get _client => sb.Supabase.instance.client;
  sb.GoTrueClient get _auth => _client.auth;

  @override
  bool get isLoggedIn => _auth.currentSession != null;

  @override
  String? get currentName => _auth.currentUser?.userMetadata?['name'] as String?;

  @override
  String? get currentEmail => _auth.currentUser?.email;

  @override
  Future<void> signIn({required String email, required String password}) {
    return _guard(() async {
      await _auth.signInWithPassword(email: email.trim(), password: password);
    });
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final res = await _auth.signUp(
        email: email.trim(),
        password: password,
        data: {'name': name.trim()}, // saved in profiles by the database trigger
      );
      // "Confirm email" is ON in Supabase: the account exists but must be confirmed first.
      if (res.session == null) {
        throw const AuthException(AppStrings.checkEmailToConfirm);
      }
    });
  }

  @override
  Future<void> signInWithGoogle() async {
    // TODO: Google needs a deep link + provider setup (next step).
    throw const AuthException(AppStrings.googleUnavailable);
  }

  @override
  Future<void> sendPasswordReset(String email) {
    return _guard(() async {
      await _auth.resetPasswordForEmail(email.trim());
    });
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<void> deleteAccount() {
    return _guard(() async {
      // The server deletes the user (needs the secret key, so not from the app).
      await _client.functions.invoke('delete-account');
      try {
        await _auth.signOut(scope: sb.SignOutScope.local);
      } catch (_) {
        // the user is already gone on the server: nothing else to do
      }
    });
  }

  // ---- helpers ----

  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
    } on sb.AuthException catch (e) {
      throw AuthException(_message(e));
    } on SocketException {
      throw const AuthException(AppStrings.networkError);
    }
  }

  static String _message(sb.AuthException e) {
    final m = e.message.toLowerCase();
    if (m.contains('invalid login')) return AppStrings.wrongCredentials;
    if (m.contains('already registered') || m.contains('already been registered')) {
      return AppStrings.emailInUse;
    }
    if (m.contains('password') && m.contains('characters')) return AppStrings.shortPassword;
    if (m.contains('not confirmed')) return AppStrings.checkEmailToConfirm;
    if (m.contains('rate limit') || m.contains('too many') || e.statusCode == '429') {
      return AppStrings.tooManyRequests;
    }
    if (m.contains('valid email') || m.contains('invalid email')) return AppStrings.invalidEmail;
    return AppStrings.unknownError;
  }
}
