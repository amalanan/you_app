import '../../../core/models/growth_type.dart';
import '../models/home_data.dart';

/// TODO: replace with real data (repository / controller) later.
const mockHomeData = HomeData(
  journey: JourneyProgress(day: 12, completedSteps: 7),
  scenario: TodayScenario(
    text: "You receive an opportunity that could move you forward, but you're not sure you're ready.",
    minutes: 2,
  ),
  growth: [
    GrowthScore(GrowthType.decisionMaking, 72),
    GrowthScore(GrowthType.learning, 81),
    GrowthScore(GrowthType.selfAwareness, 76),
  ],
);
