import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_keys.dart';

/// Thin wrapper over SharedPreferences. Call [init] once in main().
class LocalStorage {
  LocalStorage._(this._prefs);

  static late LocalStorage instance;
  final SharedPreferences _prefs;

  static Future<void> init() async {
    instance = LocalStorage._(await SharedPreferences.getInstance());
  }

  // Theme
  ThemeMode get themeMode {
    final saved = _prefs.getString(StorageKeys.themeMode);
    return ThemeMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) =>
      _prefs.setString(StorageKeys.themeMode, mode.name);

  // Onboarding
  bool get onboardingSeen => _prefs.getBool(StorageKeys.onboardingSeen) ?? false;

  Future<void> setOnboardingSeen(bool value) =>
      _prefs.setBool(StorageKeys.onboardingSeen, value);

  // Auth
  String? get token => _prefs.getString(StorageKeys.authToken);

  Future<void> setToken(String token) =>
      _prefs.setString(StorageKeys.authToken, token);

  Future<void> clearToken() => _prefs.remove(StorageKeys.authToken);
}
