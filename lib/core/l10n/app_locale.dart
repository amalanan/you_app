import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../storage/local_storage.dart';
import '../storage/storage_keys.dart';
import 'translations_ar.dart';

/// The language of the app: English ('en') or Arabic ('ar').
///
/// - By default ("system") the app FOLLOWS THE PHONE, live: change the phone to
///   Arabic and the app becomes Arabic (right-to-left); change it back and the
///   app follows.
/// - Profile > Language can force English or Arabic instead.
/// - Changing it rebuilds the whole app (see app.dart), so every text updates.
class AppLocale extends ValueNotifier<Locale> with WidgetsBindingObserver {
  AppLocale._(super.value) {
    WidgetsBinding.instance.addObserver(this);
  }

  /// Created on first use (after LocalStorage.init() in main).
  static final AppLocale instance = AppLocale._(_resolve(savedChoice));

  static const supported = [Locale('en'), Locale('ar')];

  /// Value saved for "Language": 'system', 'en' or 'ar'.
  static const system = 'system';

  static String get savedChoice =>
      LocalStorage.instance.getString(StorageKeys.language) ?? system;

  static Locale _resolve(String choice) {
    if (choice == 'en' || choice == 'ar') return Locale(choice);
    final device = ui.PlatformDispatcher.instance.locale.languageCode;
    return Locale(device == 'ar' ? 'ar' : 'en');
  }

  static bool get isArabic => instance.value.languageCode == 'ar';

  /// The phone language changed while the app is open.
  @override
  void didChangeLocales(List<Locale>? locales) {
    if (savedChoice == system) value = _resolve(system);
  }

  /// [choice] is 'system', 'en' or 'ar'.
  Future<void> setLanguage(String choice) async {
    await LocalStorage.instance.setString(StorageKeys.language, choice);
    value = _resolve(choice);
  }
}

/// Translates an English text of the app. English stays as it is.
/// A text that has no Arabic pair yet is simply shown in English.
String tr(String text) {
  if (!AppLocale.isArabic) return text;
  return arabicTexts[text] ?? text;
}
