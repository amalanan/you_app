abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signUp = '/sign-up';

  // Bottom navigation tabs
  static const home = '/home';
  static const journey = '/journey';
  static const insights = '/insights';
  static const profile = '/profile';

  // Inside the Home tab (bottom nav stays visible)
  static const scenarios = '/home/scenarios';

  // Full-screen pages (no bottom nav)
  static const addSituation = '/add-situation';
  static const situationType = '/add-situation/type';
  static const situationFeelings = '/add-situation/feelings';
  static const situationResponse = '/add-situation/response';
  static const situationOutcome = '/add-situation/outcome';
  static const situationSaved = '/add-situation/saved';
  static const scenarioQuestion = '/scenario/question';
  static const scenarioConfidence = '/scenario/confidence';
  static const scenarioReflection = '/scenario/reflection';
  static const scenarioResult = '/scenario/result';
}
