import '../../../core/models/growth_gain.dart';
import '../../../core/models/growth_type.dart';
import '../logic/situation_flow_controller.dart';

class SituationInsight {
  const SituationInsight({required this.notices, required this.gains});

  final List<String> notices;
  final List<GrowthGain> gains;
}

/// TODO: replace with the real logic (rules or AI) that reads the answers.
/// For now it always returns the text from the design.
SituationInsight buildInsight(SituationFlowController flow) {
  return const SituationInsight(
    notices: [
      'Uncertainty seems to have played an important role in your decision.',
      'You also showed a strong tendency to reflect after a difficult experience.',
    ],
    gains: [
      GrowthGain(GrowthType.selfAwareness, 2),
      GrowthGain(GrowthType.learning, 2),
      GrowthGain(GrowthType.decisionMaking, 1),
    ],
  );
}
