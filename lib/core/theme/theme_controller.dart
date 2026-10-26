import 'package:flutter/material.dart';

import '../storage/local_storage.dart';

/// Holds the current ThemeMode and persists it.
/// Usage: themeController.setMode(ThemeMode.dark)
class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController() : super(LocalStorage.instance.themeMode);

  /// Set once in main(); used by the Appearance screen.
  static late ThemeController instance;

  Future<void> setMode(ThemeMode mode) async {
    value = mode;
    await LocalStorage.instance.setThemeMode(mode);
  }
}
