import '../../../core/models/growth_score.dart';
import '../../../core/models/growth_type.dart';
import '../models/growth_detail.dart';

/// TODO: replace the mock data below with real data.

// ---- Insights tab (text from the design) ----
const mockInsights = [
  InsightItem(
    kind: InsightKind.improvement,
    title: 'Biggest improvement',
    body: 'Your learning index increased over your recent reflections.',
  ),
  InsightItem(
    kind: InsightKind.pattern,
    title: 'We noticed a pattern',
    body:
        'You often prefer to understand the available options before making important decisions.',
  ),
  InsightItem(
    kind: InsightKind.explore,
    title: 'Worth exploring',
    body:
        'You seem good at planning, but consistency in execution was lower in some of your experiences.',
  ),
];

// ---- My Growth ----
const mockGrowthProfile = [
  GrowthScore(GrowthType.decisionMaking, 72),
  GrowthScore(GrowthType.selfAwareness, 78),
  GrowthScore(GrowthType.flexibility, 64),
  GrowthScore(GrowthType.adaptation, 70),
  GrowthScore(GrowthType.consistency, 58),
  GrowthScore(GrowthType.learning, 83),
];

int _scoreOf(GrowthType type) =>
    mockGrowthProfile.firstWhere((g) => g.type == type).score;

// ---- Growth detail ----
// One short meaning + two example experiences for every skill.
GrowthDetail growthDetailFor(GrowthType type, GrowthRange range) {
  final current = _scoreOf(type);

  // Shape of the line chart (offsets from the current score) for each range.
  final (labels, offsets, delta) = switch (range) {
    GrowthRange.week => (
        ['17', '18', '19', '20', '21', '22', '23'],
        [-11, -5, -8, -4, -5, -3, 0],
        7,
      ),
    GrowthRange.month => (
        ['W1', 'W2', 'W3', 'W4', 'W5'],
        [-14, -9, -10, -4, 0],
        10,
      ),
    GrowthRange.quarter => (
        ['Jul', 'Aug', 'Sep', 'Oct'],
        [-20, -12, -6, 0],
        14,
      ),
  };

  final points = [
    for (var i = 0; i < labels.length; i++)
      GrowthPoint(labels[i], (current + offsets[i]).clamp(0, 100)),
  ];

  final (meaning, experiences) = _notes[type]!;

  return GrowthDetail(
    current: current,
    previous: (current - delta).clamp(0, 100),
    points: points,
    meaning: meaning,
    experiences: experiences,
  );
}

const _notes = <GrowthType, (String, List<String>)>{
  GrowthType.decisionMaking: (
    'Your recent responses show that you weigh your options carefully before you commit to a choice.',
    [
      'I listed the pros and cons before accepting the offer...',
      'I asked for advice, then trusted my own judgment in the end...',
    ],
  ),
  GrowthType.selfAwareness: (
    'Your reflections show that you notice your feelings and reactions more clearly than before.',
    [
      'I noticed that I get nervous when I am not prepared...',
      'I realized I need quiet time before I make big decisions...',
    ],
  ),
  GrowthType.flexibility: (
    'You are showing more openness to changing your approach when something does not work.',
    [
      'My plan changed suddenly, so I looked for another way...',
      'I tried a different method instead of pushing the same one...',
    ],
  ),
  GrowthType.adaptation: (
    'You are getting better at adjusting to new situations and recovering after setbacks.',
    [
      'After the mistake, I fixed it step by step and moved on...',
      'I adapted quickly when the schedule changed...',
    ],
  ),
  GrowthType.consistency: (
    'This is the area with the most room to grow. Small, regular steps usually help more than big efforts.',
    [
      'I started strong but lost momentum after a few days...',
      'Planning is easy for me, but following through is harder...',
    ],
  ),
  GrowthType.learning: (
    'Your recent reflections show that you often try to extract a lesson from difficult experiences.',
    [
      'I learned to verify more before making a decision...',
      'This situation taught me that patience is very important...',
    ],
  ),
};
