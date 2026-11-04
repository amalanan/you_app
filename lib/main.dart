import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'app.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide LocalStorage;
import 'core/storage/local_storage.dart';
import 'core/theme/theme_controller.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/data/local_auth_repository.dart';
import 'features/auth/data/supabase_auth_repository.dart';
import 'core/config/supabase_config.dart';
import 'features/home/data/home_repository.dart';
import 'features/home/data/mock_home_repository.dart';
import 'features/home/data/supabase_home_repository.dart';
import 'features/scenarios/data/mock_scenario_repository.dart';
import 'features/scenarios/data/scenario_repository.dart';
import 'features/scenarios/data/supabase_scenario_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();

  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );
    AuthRepository.instance = SupabaseAuthRepository();
    ScenarioRepository.instance = SupabaseScenarioRepository();
    HomeRepository.instance = SupabaseHomeRepository();

  } else {
    AuthRepository.instance = await LocalAuthRepository.create();
    ScenarioRepository.instance = MockScenarioRepository();
    HomeRepository.instance = MockHomeRepository();

  }
  ThemeController.instance = ThemeController();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => YouApp(themeController: ThemeController.instance),
    ),
  );
}
