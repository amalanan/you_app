import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/onboarding_screen.dart';
import '../../features/splash/pages/splash_screen.dart';
import '../constants/app_routes.dart';
import '../constants/cache_keys.dart';
import '../helpers/cache_helper.dart';

class AppRouter {
  static final bool isFirstTime =
      CacheHelper.getData(key: CacheKeys.isFirstTime) ?? true;

  static final GoRouter _router = GoRouter(
    initialLocation:
    isFirstTime ? '/${AppRoutes.splash}' : '/${AppRoutes.mainLayout}',

    debugLogDiagnostics: true,
    redirect: (context, state) async {
      return null;
    },
    routes: [
      GoRoute(
        path: '/${AppRoutes.splash}',
        name: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(
          nextRouteName: AppRoutes.onboarding,
        ),
      ),
      // Onboarding route
      GoRoute(
        path: '/${AppRoutes.onboarding}',
        name: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}