import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../storage/local_storage.dart';
import '../storage/storage_keys.dart';
import 'translations_ar.dart';
import 'translations_tr.dart';

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

  /// Value saved for "Language": 'system', 'en' or 'ar'.
  static const system = 'system';

  static String get savedChoice =>
      LocalStorage.instance.getString(StorageKeys.language) ?? system;


  static bool get isArabic => instance.value.languageCode == 'ar';

  static const supported = [Locale('en'), Locale('ar'), Locale('tr')];

  static Locale _resolve(String choice) {
    if (choice == 'en' || choice == 'ar' || choice == 'tr') return Locale(choice);
    final device = ui.PlatformDispatcher.instance.locale.languageCode;
    return Locale(device == 'ar' || device == 'tr' ? device : 'en');
  }

  static String get languageCode => instance.value.languageCode;
  static bool get isTurkish => languageCode == 'tr';

  String tr(String text) {
    switch (AppLocale.languageCode) {
      case 'ar': return arabicTexts[text] ?? text;
      case 'tr': return turkishTexts[text] ?? text;
      default: return text;
    }
  }
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
  return AppLocale.instance.tr(text);
}
