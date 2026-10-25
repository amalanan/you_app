import '../../../core/models/growth_gain.dart';
import '../../../core/models/growth_type.dart';
import '../models/scenario.dart';

/// Reflection chips ("What mattered most to you?").
const matterOptions = [
  'Growth',
  'Security',
  'Freedom',
  'Stability',
  'Money',
  'Avoiding Failure',
  'Other',
];

// TODO: write the real content. Only "The Difficult Choice" follows the design;
// the answers marked "placeholder" are temporary so every scenario can be opened.
const _placeholderInsight = '[Placeholder] Write the insight for this answer.';

List<ScenarioOption> _placeholderOptions() => const [
      ScenarioOption(
        text: 'Option A (placeholder)',
        insight: _placeholderInsight,
        gains: [GrowthGain(GrowthType.decisionMaking, 1)],
      ),
      ScenarioOption(
        text: 'Option B (placeholder)',
        insight: _placeholderInsight,
        gains: [
          GrowthGain(GrowthType.decisionMaking, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Option C (placeholder)',
        insight: _placeholderInsight,
        gains: [GrowthGain(GrowthType.selfAwareness, 2)],
      ),
      ScenarioOption(
        text: 'Option D (placeholder)',
        insight: _placeholderInsight,
        gains: [GrowthGain(GrowthType.learning, 2)],
      ),
    ];

final mockScenarios = <Scenario>[
  const Scenario(
    id: 'difficult-choice',
    title: 'The Difficult Choice',
    summary: 'You have two opportunities, but choosing one means giving up the other.',
    situation:
        "You receive an opportunity that could significantly help your future, but you don't feel fully prepared.",
    category: ScenarioCategory.decisions,
    options: [
      ScenarioOption(
        text: 'Accept the opportunity immediately.',
        insight: _placeholderInsight,
        gains: [
          GrowthGain(GrowthType.decisionMaking, 1),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Gather more information before deciding.',
        insight:
            'Your response suggests that you prefer gathering information before making important decisions.',
        gains: [
          GrowthGain(GrowthType.decisionMaking, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
          GrowthGain(GrowthType.learning, 1),
        ],
      ),
      ScenarioOption(
        text: 'Wait until I feel completely ready.',
        insight: _placeholderInsight,
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.learning, 1),
        ],
      ),
      ScenarioOption(
        text: 'Ask someone I trust for advice.',
        insight: _placeholderInsight,
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'taking-a-risk',
    title: 'Taking a Risk',
    summary: 'You can take a risk that could lead to something great, but it might also fail.',
    situation: 'You can take a risk that could lead to something great, but it might also fail.',
    category: ScenarioCategory.decisions,
    options: _placeholderOptions(),
  ),
  Scenario(
    id: 'things-go-wrong',
    title: 'When Things Go Wrong',
    summary: 'You made a mistake that affected the outcome.',
    situation: 'You made a mistake that affected the outcome.',
    category: ScenarioCategory.challenges,
    options: _placeholderOptions(),
  ),
  Scenario(
    id: 'asking-for-help',
    title: 'Asking for Help',
    summary: "You're struggling, but you're not sure if you should ask for help.",
    situation: "You're struggling, but you're not sure if you should ask for help.",
    category: ScenarioCategory.challenges,
    options: _placeholderOptions(),
  ),
  Scenario(
    id: 'sudden-change',
    title: 'A Sudden Change', // TODO: placeholder, not in the design
    summary: 'Your plans change suddenly and you need to adapt.',
    situation: 'Your plans change suddenly and you need to adapt.',
    category: ScenarioCategory.change,
    options: _placeholderOptions(),
  ),
];
