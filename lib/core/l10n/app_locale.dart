import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../storage/local_storage.dart';
import '../storage/storage_keys.dart';
import 'translations_ar.dart';

/// The language of the app: English ('en') or Arabic ('ar').
///
/// - The choice is saved on the device (Profile > Language).
/// - On the very first launch it follows the phone: Arabic phone -> Arabic app.
/// - Changing it rebuilds the whole app (see app.dart), so every text updates.
class AppLocale extends ValueNotifier<Locale> {
  AppLocale._(super.value);

  /// Created on first use (after LocalStorage.init() in main).
  static final AppLocale instance = AppLocale._(_initial());

  static const supported = [Locale('en'), Locale('ar')];

  static Locale _initial() {
    final saved = LocalStorage.instance.getString(StorageKeys.language);
    if (saved != null) return Locale(saved);
    final device = ui.PlatformDispatcher.instance.locale.languageCode;
    return Locale(device == 'ar' ? 'ar' : 'en');
  }

  static bool get isArabic => instance.value.languageCode == 'ar';

  Future<void> setLanguage(String code) async {
    await LocalStorage.instance.setString(StorageKeys.language, code);
    value = Locale(code);
  }
}

/// Translates an English text of the app. English stays as it is.
/// A text that has no Arabic pair yet is simply shown in English.
String tr(String text) {
  if (!AppLocale.isArabic) return text;
  return arabicTexts[text] ?? text;
}
