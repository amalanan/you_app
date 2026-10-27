import '../../../core/models/growth_gain.dart';
import '../../../core/models/growth_type.dart';
import '../logic/situation_flow_controller.dart';
import '../models/situation_models.dart';

class SituationInsight {
  const SituationInsight({required this.notices, required this.gains});

  final List<String> notices;
  final List<GrowthGain> gains;
}

const _hardFeelings = {
  Feeling.nervous,
  Feeling.confused,
  Feeling.frustrated,
  Feeling.disappointed,
  Feeling.overwhelmed,
};

const _positiveFeelings = {
  Feeling.excited,
  Feeling.confident,
  Feeling.hopeful,
  Feeling.calm,
};

/// Simple rules that read the answers (feelings, type, confidence, lesson).
/// You can replace this with something smarter later; the screen won't change.
SituationInsight buildInsight(SituationFlowController flow) {
  final feelings = flow.feelings;
  final hasHard = feelings.any(_hardFeelings.contains);
  final hasPositive = feelings.any(_positiveFeelings.contains);
  final hasLesson = flow.lesson.trim().isNotEmpty;
  final reflected = hasLesson || flow.afterwards.trim().isNotEmpty;

  final notices = <String>[
    if (hasHard && hasPositive)
      'You felt pulled in more than one direction, which is common when something matters to you.'
    else if (hasHard)
      'Uncertainty seems to have played an important role in how you experienced this.'
    else if (hasPositive)
        'You approached this with energy and a fairly positive outlook.'
      else
        'You noticed your feelings in this moment, which is a good first step in understanding it.',
    if (reflected)
      'You also showed a strong tendency to reflect after an experience.'
    else
      'Writing this down is already a way of understanding it better.',
    if (flow.confidence >= 8)
      'You felt very sure about how you responded.'
    else if (flow.confidence <= 3)
      "You weren't very sure about your response, which is worth coming back to later.",
  ];

  final points = <GrowthType, int>{
    GrowthType.selfAwareness: 2,
    GrowthType.learning: hasLesson ? 2 : 1,
  };

  final bonus = switch (flow.type) {
    SituationType.decision => GrowthType.decisionMaking,
    SituationType.challenge => GrowthType.adaptation,
    SituationType.work => GrowthType.consistency,
    SituationType.study => GrowthType.learning,
    SituationType.relationship => GrowthType.flexibility,
    SituationType.personal => GrowthType.selfAwareness,
    SituationType.unexpected => GrowthType.flexibility,
    _ => null,
  };
  if (bonus != null) {
    points.update(bonus, (v) => v + 1, ifAbsent: () => 1);
  }

  final gains = [
    for (final e in points.entries) GrowthGain(e.key, e.value),
  ]..sort((a, b) => b.points.compareTo(a.points));

  return SituationInsight(notices: notices, gains: gains.take(3).toList());
}
