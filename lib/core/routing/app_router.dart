import 'package:go_router/go_router.dart';

import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/main/pages/main_shell_page.dart';
import '../../features/onboarding/pages/onboarding_page.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/splash/pages/splash_page.dart';
import '../constants/app_strings.dart';
import '../widgets/placeholder_page.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, __) => const SplashPage()),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, __) => const OnboardingPage(),
      ),
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginPage()),
      GoRoute(path: AppRoutes.signUp, builder: (_, __) => const SignUpPage()),

      // The 4 tabs share one shell (bottom navigation bar).
      // Each tab keeps its own state when you switch between them.
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => MainShellPage(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.home, builder: (_, __) => const HomePage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.journey,
              // TODO: replace with JourneyPage
              builder: (_, __) => PlaceholderPage(title: AppStrings.navJourney),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.insights,
              // TODO: replace with InsightsPage
              builder: (_, __) => PlaceholderPage(title: AppStrings.navInsights),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (_, __) => const ProfilePage(),
            ),
          ]),
        ],
      ),

      // Opened on top of the tabs (no bottom nav).
      GoRoute(
        path: AppRoutes.addSituation,
        // TODO: replace with AddSituationPage
        builder: (_, __) => PlaceholderPage(title: AppStrings.addSituation),
      ),
      GoRoute(
        path: AppRoutes.scenarios,
        // TODO: replace with ScenariosPage
        builder: (_, __) => PlaceholderPage(title: AppStrings.exploreScenario),
      ),
    ],
  );
}
