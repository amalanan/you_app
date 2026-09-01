import 'package:flutter/material.dart';

import 'core/helpers/cache_helper.dart';
import 'package:device_preview/device_preview.dart';
import 'package:you_app/features/splash/pages/splash_screen.dart';

import 'features/home/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    DevicePreview(enabled: true, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YOU',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primaryColor: const Color(0xFF4E7C63),
        scaffoldBackgroundColor: const Color(0xFFF3F3F0),
        fontFamily: 'Poppins',
      ),
      home: SplashScreen(nextRouteName: 'home',),
    );
  }
}