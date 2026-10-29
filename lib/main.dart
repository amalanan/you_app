import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'app.dart';
import 'core/storage/local_storage.dart';
import 'core/theme/theme_controller.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/data/local_auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  AuthRepository.instance = await LocalAuthRepository.create();
  ThemeController.instance = ThemeController();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => YouApp(themeController: ThemeController.instance),
    ),
  );
}