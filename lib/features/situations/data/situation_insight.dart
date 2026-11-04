import '../../../core/models/growth_gain.dart';
import '../../../core/models/growth_type.dart';
import '../models/situation_models.dart';

/// "What we noticed" + the points earned, shown on the saved screen.
class SituationInsight {
  const SituationInsight({required this.notices, required this.gains});

  final List<String> notices;
  final List<GrowthGain> gains;

  /// The server answers with CODES; here each code becomes its text.
  /// (The Text widget shows the Arabic version when the app is Arabic.)
  factory SituationInsight.fromCodes(List<String> codes, List<GrowthGain> gains) {
    return SituationInsight(
      notices: [
        for (final code in codes)
          if (_noticeTexts.containsKey(code)) _noticeTexts[code]!,
      ],
      gains: gains,
    );
  }
}

const _noticeTexts = <String, String>{
  'mixed_feelings':
  'You felt pulled in more than one direction, which is common when something matters to you.',
  'uncertainty':
  'Uncertainty seems to have played an important role in how you experienced this.',
  'positive': 'You approached this with energy and a fairly positive outlook.',
  'noticed_feelings':
  'You noticed your feelings in this moment, which is a good first step in understanding it.',
  'reflected': 'You also showed a strong tendency to reflect after an experience.',
  'writing_helps': 'Writing this down is already a way of understanding it better.',
  'very_sure': 'You felt very sure about how you responded.',
  'not_sure':
  "You weren't very sure about your response, which is worth coming back to later.",
};

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

/// The SAME rules as the server function submit_situation (003_situations.sql),
/// used only when Supabase is not set up. Keep the two in sync.
SituationInsight localInsight({
  required SituationType type,
  required Set<Feeling> feelings,
  required int confidence,
  required String afterwards,
  required String lesson,
}) {
  final hasHard = feelings.any(_hardFeelings.contains);
  final hasPositive = feelings.any(_positiveFeelings.contains);
  final hasLesson = lesson.trim().isNotEmpty;
  final reflected = hasLesson || afterwards.trim().isNotEmpty;

  final codes = <String>[
    if (hasHard && hasPositive)
      'mixed_feelings'
    else if (hasHard)
      'uncertainty'
    else if (hasPositive)
        'positive'
      else
        'noticed_feelings',
    if (reflected) 'reflected' else 'writing_helps',
    if (confidence >= 8)
      'very_sure'
    else if (confidence <= 3)
      'not_sure',
  ];

  final points = <GrowthType, int>{
    GrowthType.selfAwareness: 2,
    GrowthType.learning: hasLesson ? 2 : 1,
  };
  final bonus = switch (type) {
    SituationType.decision => GrowthType.decisionMaking,
    SituationType.challenge => GrowthType.adaptation,
    SituationType.work => GrowthType.consistency,
    SituationType.study => GrowthType.learning,
    SituationType.relationship => GrowthType.flexibility,
    SituationType.personal => GrowthType.selfAwareness,
    SituationType.unexpected => GrowthType.flexibility,
    SituationType.other => null,
  };
  if (bonus != null) points.update(bonus, (v) => v + 1, ifAbsent: () => 1);

  final gains = [
    for (final e in points.entries) GrowthGain(e.key, e.value),
  ]..sort((a, b) => b.points.compareTo(a.points));

  return SituationInsight.fromCodes(codes, gains);
}
