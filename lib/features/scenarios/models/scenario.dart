import '../../../core/constants/app_strings.dart';
import '../../../core/models/growth_gain.dart';

enum ScenarioCategory { decisions, challenges, change }

extension ScenarioCategoryX on ScenarioCategory {
  String get label => switch (this) {
        ScenarioCategory.decisions => AppStrings.filterDecisions,
        ScenarioCategory.challenges => AppStrings.filterChallenges,
        ScenarioCategory.change => AppStrings.filterChange,
      };
}

class ScenarioOption {
  const ScenarioOption({
    required this.text,
    required this.insight,
    required this.gains,
  });

  final String text;

  /// Shown on the result screen ("Your response suggests that...").
  final String insight;
  final List<GrowthGain> gains;
}

class Scenario {
  const Scenario({
    required this.id,
    required this.title,
    required this.summary,
    required this.situation,
    required this.category,
    required this.options,
    this.question = AppStrings.whatWouldYouDo,
    this.minutes = 2,
  });

  final String id;
  final String title;

  /// Short text on the list card.
  final String summary;

  /// Full text on the first step of the flow.
  final String situation;
  final String question;
  final int minutes;
  final ScenarioCategory category;
  final List<ScenarioOption> options;
}
