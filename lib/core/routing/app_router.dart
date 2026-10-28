import 'package:go_router/go_router.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/home/insights/pages/growth_detail_page.dart';
import '../../features/home/insights/pages/growth_page.dart';
import '../../features/home/insights/pages/insights_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/journey/pages/journey_page.dart';
import '../../features/main/pages/main_shell_page.dart';
import '../../features/onboarding/pages/onboarding_page.dart';
import '../../features/profile/data/legal_content.dart';
import '../../features/profile/pages/about_page.dart';
import '../../features/profile/pages/appearance_page.dart';
import '../../features/profile/pages/help_page.dart';
import '../../features/profile/pages/language_page.dart';
import '../../features/profile/pages/legal_page.dart';
import '../../features/profile/pages/notifications_page.dart';
import '../../features/profile/pages/privacy_data_page.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/profile/pages/reflection_preferences_page.dart';
import '../../features/scenarios/logic/scenario_flow_controller.dart';
import '../../features/scenarios/pages/confidence_page.dart';
import '../../features/scenarios/pages/reflection_page.dart';
import '../../features/scenarios/pages/result_page.dart';
import '../../features/scenarios/pages/scenario_question_page.dart';
import '../../features/scenarios/pages/scenarios_page.dart';
import '../../features/situations/logic/situation_flow_controller.dart';
import '../../features/situations/pages/add_situation_page.dart';
import '../../features/situations/pages/situation_feelings_page.dart';
import '../../features/situations/pages/situation_outcome_page.dart';
import '../../features/situations/pages/situation_response_page.dart';
import '../../features/situations/pages/situation_saved_page.dart';
import '../../features/situations/pages/situation_type_page.dart';
import '../../features/splash/pages/splash_page.dart';
import '../constants/app_strings.dart';
import '../models/growth_type.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  /// The scenario steps share one [ScenarioFlowController] passed as `extra`.
  /// If it is missing (e.g. app restarted on that page), go back Home.
  static String? _needsFlow(_, GoRouterState state) =>
      state.extra is ScenarioFlowController ? null : AppRoutes.home;

  static ScenarioFlowController _flow(GoRouterState state) =>
      state.extra! as ScenarioFlowController;

  static String? _needsSituationFlow(_, GoRouterState state) =>
      state.extra is SituationFlowController ? null : AppRoutes.home;

  static SituationFlowController _situationFlow(GoRouterState state) =>
      state.extra! as SituationFlowController;

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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (_, __) => const HomePage(),
                routes: [
                  // full path: /home/scenarios
                  GoRoute(
                    path: 'scenarios',
                    builder: (_, __) => const ScenariosPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.journey,
                builder: (_, __) => const JourneyPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.insights,
                builder: (_, __) => const InsightsPage(),
                routes: [
                  // /insights/growth
                  GoRoute(
                    path: 'growth',
                    builder: (_, __) => const GrowthPage(),
                    routes: [
                      // /insights/growth/learning, /insights/growth/consistency ...
                      GoRoute(
                        path: ':type',
                        builder:
                            (_, state) =>
                            GrowthDetailPage(
                              type:
                              GrowthType.values.asNameMap()[state
                                  .pathParameters['type']] ??
                                  GrowthType.learning,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (_, __) => const ProfilePage(),
                routes: [
                  GoRoute(
                    path: 'notifications',
                    builder: (_, __) => const NotificationsPage(),
                  ),
                  GoRoute(
                    path: 'appearance',
                    builder: (_, __) => const AppearancePage(),
                  ),
                  GoRoute(
                    path: 'language',
                    builder: (_, __) => const LanguagePage(),
                  ),
                  GoRoute(
                    path: 'preferences',
                    builder: (_, __) => const ReflectionPreferencesPage(),
                  ),
                  GoRoute(
                    path: 'privacy',
                    builder: (_, __) => const PrivacyDataPage(),
                  ),
                  GoRoute(path: 'help', builder: (_, __) => const HelpPage()),
                  GoRoute(
                    path: 'terms',
                    builder:
                        (_, __) =>
                    const LegalPage(
                      title: AppStrings.menuTerms,
                      sections: termsSections,
                    ),
                  ),
                  GoRoute(
                    path: 'privacy-policy',
                    builder:
                        (_, __) =>
                    const LegalPage(
                      title: AppStrings.menuPrivacyPolicy,
                      sections: privacyPolicySections,
                    ),
                  ),
                  GoRoute(path: 'about', builder: (_, __) => const AboutPage()),
                ],
              ),
            ],
          ),
        ],
      ),

      // Opened on top of the tabs (no bottom nav).

      // Add situation flow: what happened -> type -> feelings -> response
      // -> outcome -> saved. The first page creates the controller.
      GoRoute(
        path: AppRoutes.addSituation,
        builder: (_, __) => const AddSituationPage(),
      ),
      GoRoute(
        path: AppRoutes.situationType,
        redirect: _needsSituationFlow,
        builder: (_, state) => SituationTypePage(flow: _situationFlow(state)),
      ),
      GoRoute(
        path: AppRoutes.situationFeelings,
        redirect: _needsSituationFlow,
        builder:
            (_, state) => SituationFeelingsPage(flow: _situationFlow(state)),
      ),
      GoRoute(
        path: AppRoutes.situationResponse,
        redirect: _needsSituationFlow,
        builder:
            (_, state) => SituationResponsePage(flow: _situationFlow(state)),
      ),
      GoRoute(
        path: AppRoutes.situationOutcome,
        redirect: _needsSituationFlow,
        builder:
            (_, state) => SituationOutcomePage(flow: _situationFlow(state)),
      ),
      GoRoute(
        path: AppRoutes.situationSaved,
        redirect: _needsSituationFlow,
        builder: (_, state) => SituationSavedPage(flow: _situationFlow(state)),
      ),

      // Scenario flow: question -> confidence -> reflection -> result
      GoRoute(
        path: AppRoutes.scenarioQuestion,
        redirect: _needsFlow,
        builder: (_, state) => ScenarioQuestionPage(flow: _flow(state)),
      ),
      GoRoute(
        path: AppRoutes.scenarioConfidence,
        redirect: _needsFlow,
        builder: (_, state) => ConfidencePage(flow: _flow(state)),
      ),
      GoRoute(
        path: AppRoutes.scenarioReflection,
        redirect: _needsFlow,
        builder: (_, state) => ReflectionPage(flow: _flow(state)),
      ),
      GoRoute(
        path: AppRoutes.scenarioResult,
        redirect: _needsFlow,
        builder: (_, state) => ResultPage(flow: _flow(state)),
      ),
    ],
  );
}
