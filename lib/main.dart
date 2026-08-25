import 'package:flutter/material.dart';

import 'core/helpers/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    DevicePreview(enabled: false, builder: (context) => const ElectroLinkApp()),
  );
}
