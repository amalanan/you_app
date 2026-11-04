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
  const TodayScenario({
    required this.text,
    required this.minutes,
    this.id = '',
  });

  /// Id of the scenario (to open it directly).
  final String id;
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
  /// null when there are no scenarios at all.
  final TodayScenario? scenario;
  final List<GrowthScore> growth;
}
