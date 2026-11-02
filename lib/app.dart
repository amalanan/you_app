
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/app_strings.dart';
import 'core/l10n/app_locale.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

class YouApp extends StatelessWidget {
  const YouApp({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: AppLocale.instance,
      builder: (_, locale, __) => ValueListenableBuilder<ThemeMode>(
        valueListenable: themeController,
        builder: (_, mode, __) => MaterialApp.router(
          useInheritedMediaQuery: true,
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,

          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,

          locale: DevicePreview.locale(context) ?? locale,
          supportedLocales: AppLocale.supported,

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          routerConfig: AppRouter.router,

          builder: (context, child) {
            return DevicePreview.appBuilder(
              context,
              Directionality(
                textDirection: locale.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
        ),
      ),
    );
  }
}


// class YouApp extends StatelessWidget {
//   const YouApp({super.key, required this.themeController});
//
//   final ThemeController themeController;
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ThemeMode>(
//       valueListenable: themeController,
//       builder:
//           (_, mode, __) => MaterialApp.router(
//             useInheritedMediaQuery: true,
//             title: AppStrings.appName,
//             debugShowCheckedModeBanner: false,
//             theme: AppTheme.light,
//             darkTheme: AppTheme.dark,
//             themeMode: mode,
//             routerConfig: AppRouter.router,
//             locale: DevicePreview.locale(context),
//             builder: DevicePreview.appBuilder,
//           ),
//     );
//   }
// }
