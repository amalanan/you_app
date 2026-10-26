import '../../../core/models/growth_score.dart';

class JourneyProgress {
  const JourneyProgress({
    required this.day,
    required this.completedSteps,
    this.totalSteps = 14,
  });

  final int day;
  final int completedSteps;
  final int totalSteps;
}

class TodayScenario {
  const TodayScenario({required this.text, required this.minutes});

  final String text;
  final int minutes;
}

class HomeData {
  const HomeData({
    required this.journey,
    required this.scenario,
    required this.growth,
  });

  final JourneyProgress journey;
  final TodayScenario scenario;
  final List<GrowthScore> growth;
}
