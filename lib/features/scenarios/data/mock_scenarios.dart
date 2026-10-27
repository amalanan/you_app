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

/// Scenario content. Later this can come from a backend instead of code.
const mockScenarios = <Scenario>[
  Scenario(
    id: 'difficult-choice',
    title: 'The Difficult Choice',
    summary: 'You have two opportunities, but choosing one means giving up the other.',
    situation:
    "You receive an opportunity that could significantly help your future, but you don't feel fully prepared.",
    category: ScenarioCategory.decisions,
    options: [
      ScenarioOption(
        text: 'Accept the opportunity immediately.',
        insight:
        'Your response suggests that you act quickly on chances you believe in, and that you trust yourself to learn along the way.',
        gains: [
          GrowthGain(GrowthType.decisionMaking, 1),
          GrowthGain(GrowthType.adaptation, 1),
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
        insight:
        'Your response suggests that you want to feel prepared before you commit. It can help to ask yourself what "ready" really means to you.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.consistency, 1),
        ],
      ),
      ScenarioOption(
        text: 'Ask someone I trust for advice.',
        insight:
        'Your response suggests that you value other perspectives and use the people around you to see your options more clearly.',
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
    situation:
    'A chance appears that could lead to something great. It also comes with a real possibility of failing, and the choice is yours.',
    category: ScenarioCategory.decisions,
    options: [
      ScenarioOption(
        text: 'Take the risk without overthinking it.',
        insight:
        'Your response suggests that you are drawn to possibility and are willing to move before everything is certain.',
        gains: [
          GrowthGain(GrowthType.flexibility, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'List what I could gain and what I could lose first.',
        insight:
        'Your response suggests that you like to see the full picture and weigh gains against losses before you commit.',
        gains: [
          GrowthGain(GrowthType.decisionMaking, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Try a smaller version of it first.',
        insight:
        'Your response suggests that you like to test an idea in small steps, which lets you learn before you risk too much.',
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.adaptation, 1),
        ],
      ),
      ScenarioOption(
        text: 'Let it pass and stay with what is safe.',
        insight:
        'Your response suggests that stability matters a lot to you right now. Noticing what you protect is useful in itself.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.consistency, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'things-go-wrong',
    title: 'When Things Go Wrong',
    summary: 'You made a mistake that affected the outcome.',
    situation:
    'You made a mistake that affected the outcome of something you care about, and other people have noticed.',
    category: ScenarioCategory.challenges,
    options: [
      ScenarioOption(
        text: 'Admit it openly and take responsibility.',
        insight:
        'Your response suggests that you face mistakes directly and value honesty, even when it feels uncomfortable.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.consistency, 1),
        ],
      ),
      ScenarioOption(
        text: 'Focus on fixing it before telling anyone.',
        insight:
        'Your response suggests that you move toward solutions and want to repair things quickly.',
        gains: [
          GrowthGain(GrowthType.adaptation, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Go over what happened to understand why.',
        insight:
        'Your response suggests that you look for the cause of a mistake so that you can learn from it.',
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Step back and give myself time before reacting.',
        insight:
        'Your response suggests that you give yourself space before responding, which can protect you from reacting in the heat of the moment.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.flexibility, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'asking-for-help',
    title: 'Asking for Help',
    summary: "You're struggling, but you're not sure if you should ask for help.",
    situation:
    "You're struggling with something and starting to fall behind, but you're not sure whether to ask for help or keep trying on your own.",
    category: ScenarioCategory.challenges,
    options: [
      ScenarioOption(
        text: 'Ask for help right away.',
        insight:
        'Your response suggests that you see asking for help as a strength and do not wait until things feel heavy.',
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.adaptation, 1),
        ],
      ),
      ScenarioOption(
        text: 'Try a bit longer on my own first.',
        insight:
        'Your response suggests that you like to give your own effort a fair chance before involving others.',
        gains: [
          GrowthGain(GrowthType.consistency, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: "Ask, but only someone I'm comfortable with.",
        insight:
        'Your response suggests that you value trust and choose carefully who you open up to.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.learning, 1),
        ],
      ),
      ScenarioOption(
        text: 'Keep it to myself and push through.',
        insight:
        'Your response suggests that you tend to carry things alone. That can be a strength, and it can also be worth asking how much it costs you.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.flexibility, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'sudden-change',
    title: 'A Sudden Change',
    summary: 'Your plans change suddenly and you need to adapt.',
    situation:
    'Your plans change suddenly, and something you were counting on is no longer possible. You need to adjust quickly.',
    category: ScenarioCategory.change,
    options: [
      ScenarioOption(
        text: 'Make a new plan right away.',
        insight:
        'Your response suggests that you adapt by turning quickly to action and building a new path.',
        gains: [
          GrowthGain(GrowthType.adaptation, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Take a moment to feel how I feel about it first.',
        insight:
        'Your response suggests that you give your feelings room before you act, which helps you understand what you really want.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.flexibility, 1),
        ],
      ),
      ScenarioOption(
        text: 'Look for what this change might make possible.',
        insight:
        'Your response suggests that you look for opportunity inside change and stay open to a different path.',
        gains: [
          GrowthGain(GrowthType.flexibility, 2),
          GrowthGain(GrowthType.learning, 1),
        ],
      ),
      ScenarioOption(
        text: "Ask others how they're handling it.",
        insight:
        "Your response suggests that you use other people's perspective to find your footing when things shift.",
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.adaptation, 1),
        ],
      ),
    ],
  ),
];
