import 'package:go_router/go_router.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/onboarding/pages/onboarding_page.dart';
import '../../features/splash/pages/splash_page.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, __) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, __) => const HomePage(),
      ),
    ],
  );
}
