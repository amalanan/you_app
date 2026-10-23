import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/errors/exceptions.dart';
import 'auth_repository.dart';

/// TEMPORARY (development only): accounts are kept on the device in
/// SharedPreferences, passwords in plain text. Replace it with a real backend
/// by writing another AuthRepository and changing one line in main.dart.
class LocalAuthRepository implements AuthRepository {
  LocalAuthRepository._(this._prefs);

  final SharedPreferences _prefs;

  static Future<LocalAuthRepository> create() async =>
      LocalAuthRepository._(await SharedPreferences.getInstance());

  static const _usersKey = 'dev_users';
  static const _sessionKey = 'dev_session_email';

  Map<String, dynamic> get _users {
    final raw = _prefs.getString(_usersKey);
    return raw == null ? {} : jsonDecode(raw) as Map<String, dynamic>;
  }

  String _key(String email) => email.trim().toLowerCase();

  Future<void> _fakeDelay() => Future.delayed(const Duration(milliseconds: 600));

  @override
  bool get isLoggedIn => _prefs.getString(_sessionKey) != null;

  @override
  String? get currentEmail => _prefs.getString(_sessionKey);

  @override
  String? get currentName {
    final user = _users[currentEmail] as Map<String, dynamic>?;
    return user?['name'] as String?;
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _fakeDelay();
    final user = _users[_key(email)] as Map<String, dynamic>?;
    if (user == null || user['password'] != password) {
      throw const AuthException(AppStrings.wrongCredentials);
    }
    await _prefs.setString(_sessionKey, _key(email));
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await _fakeDelay();
    final users = _users;
    if (users.containsKey(_key(email))) {
      throw const AuthException(AppStrings.emailInUse);
    }
    users[_key(email)] = {'name': name.trim(), 'password': password};
    await _prefs.setString(_usersKey, jsonEncode(users));
    await _prefs.setString(_sessionKey, _key(email));
  }

  @override
  Future<void> signInWithGoogle() async {
    throw const AuthException(AppStrings.googleUnavailable);
  }

  @override
  Future<void> sendPasswordReset(String email) => _fakeDelay();

  @override
  Future<void> signOut() => _prefs.remove(_sessionKey);
}
