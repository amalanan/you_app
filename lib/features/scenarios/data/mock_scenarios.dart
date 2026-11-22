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
    summary:
        'You have two opportunities, but choosing one means giving up the other.',
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
    summary:
        'You can take a risk that could lead to something great, but it might also fail.',
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
    summary:
        "You're struggling, but you're not sure if you should ask for help.",
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

  Scenario(
    id: 'dealing-with-criticism',
    title: 'Dealing with Criticism',
    summary: 'Someone gives you feedback that is difficult to hear.',
    situation:
        'Someone you respect criticizes something you worked hard on. Their words hurt, and you are not sure whether their feedback is fair.',
    category: ScenarioCategory.challenges,
    options: [
      ScenarioOption(
        text: 'Listen carefully and consider what I can learn.',
        insight:
            'Your response suggests that you are open to learning, even when feedback feels uncomfortable.',
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Explain my perspective and defend my work.',
        insight:
            'Your response suggests that you value standing up for your ideas and making sure your perspective is understood.',
        gains: [
          GrowthGain(GrowthType.decisionMaking, 1),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Take some time before responding.',
        insight:
            'Your response suggests that you prefer to process difficult feedback before deciding how to respond.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.flexibility, 1),
        ],
      ),
      ScenarioOption(
        text: 'Ignore it and move on.',
        insight:
            'Your response suggests that you try not to let other people’s opinions affect your direction. It may be worth considering whether any part of the feedback could still be useful.',
        gains: [
          GrowthGain(GrowthType.consistency, 1),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'setting-boundaries',
    title: 'Setting Boundaries',
    summary: 'Someone asks for more of your time than you can give.',
    situation:
        'A person close to you keeps asking for your help. You care about them, but their requests are starting to affect your own responsibilities and personal time.',
    category: ScenarioCategory.challenges,
    options: [
      ScenarioOption(
        text: 'Say no and explain my limits honestly.',
        insight:
            'Your response suggests that you recognize the importance of protecting your time while communicating honestly.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Agree because I do not want to disappoint them.',
        insight:
            'Your response suggests that maintaining relationships matters to you. It may be useful to notice when pleasing others comes at the expense of your own needs.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.learning, 1),
        ],
      ),
      ScenarioOption(
        text: 'Offer help, but suggest a different time.',
        insight:
            'Your response suggests that you look for balanced solutions that respect both your needs and other people’s expectations.',
        gains: [
          GrowthGain(GrowthType.flexibility, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Avoid answering and hope they understand.',
        insight:
            'Your response suggests that you may prefer avoiding uncomfortable conversations. Understanding what makes direct communication difficult could help you build confidence.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.learning, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'feeling-left-behind',
    title: 'Feeling Left Behind',
    summary: 'People around you seem to be moving forward faster.',
    situation:
        'You see people your age achieving goals, getting opportunities, and making progress. Meanwhile, you feel that your own life is moving more slowly than you expected.',
    category: ScenarioCategory.challenges,
    options: [
      ScenarioOption(
        text: 'Focus on my own progress and next steps.',
        insight:
            'Your response suggests that you try to measure progress by your own journey rather than someone else’s timeline.',
        gains: [
          GrowthGain(GrowthType.consistency, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Use their achievements as motivation.',
        insight:
            'Your response suggests that you can turn comparison into motivation and use other people’s experiences as inspiration.',
        gains: [
          GrowthGain(GrowthType.flexibility, 1),
          GrowthGain(GrowthType.consistency, 2),
        ],
      ),
      ScenarioOption(
        text: 'Question whether I am making the right choices.',
        insight:
            'Your response suggests that you reflect on your direction when you notice a gap between your expectations and reality.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Step away from comparisons for a while.',
        insight:
            'Your response suggests that you recognize when external pressure affects your perspective and choose to create some distance.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.flexibility, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'conflicting-opinions',
    title: 'Conflicting Opinions',
    summary: 'You disagree with someone whose opinion matters to you.',
    situation:
        'You are discussing an important decision with someone close to you. They strongly disagree with your point of view, and the conversation is becoming uncomfortable.',
    category: ScenarioCategory.decisions,
    options: [
      ScenarioOption(
        text: 'Explain my opinion calmly.',
        insight:
            'Your response suggests that you value expressing your thoughts clearly while keeping the conversation respectful.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 1),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Try to understand why they see things differently.',
        insight:
            'Your response suggests that you are willing to consider perspectives beyond your own and learn through disagreement.',
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.flexibility, 1),
        ],
      ),
      ScenarioOption(
        text: 'Agree to avoid creating tension.',
        insight:
            'Your response suggests that harmony in relationships matters to you. It may be worth asking whether you sometimes hide your real opinion to keep the peace.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.consistency, 1),
        ],
      ),
      ScenarioOption(
        text: 'Pause the conversation until we are calmer.',
        insight:
            'Your response suggests that you recognize the value of timing and emotional space when handling disagreements.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.adaptation, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'uncertain-future',
    title: 'An Uncertain Future',
    summary: 'You need to make plans without knowing what comes next.',
    situation:
        'You are at a point where several things in your life are uncertain. You want to plan your future, but you cannot predict which opportunities or challenges will appear.',
    category: ScenarioCategory.change,
    options: [
      ScenarioOption(
        text: 'Create a flexible plan and adjust when needed.',
        insight:
            'Your response suggests that you prefer having direction without needing every detail to be certain.',
        gains: [
          GrowthGain(GrowthType.adaptation, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Focus only on what I can control today.',
        insight:
            'Your response suggests that you find stability by focusing your energy on actions within your control.',
        gains: [
          GrowthGain(GrowthType.consistency, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Research every possible outcome before acting.',
        insight:
            'Your response suggests that preparation helps you feel more secure when facing uncertainty. It may help to notice when preparation turns into overthinking.',
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Wait until things become clearer.',
        insight:
            'Your response suggests that you prefer making decisions with a clearer picture. Consider whether waiting is giving you useful information or delaying a step you could take now.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.flexibility, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'missed-opportunity',
    title: 'A Missed Opportunity',
    summary: 'You realize that you let an important opportunity pass.',
    situation:
        'You recently had a chance to do something meaningful, but you hesitated and the opportunity is now gone. You keep thinking about what might have happened if you had acted differently.',
    category: ScenarioCategory.challenges,
    options: [
      ScenarioOption(
        text: 'Reflect on what stopped me and learn from it.',
        insight:
            'Your response suggests that you use past experiences to understand your decisions and prepare for future opportunities.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.learning, 2),
        ],
      ),
      ScenarioOption(
        text: 'Look for another opportunity and move forward.',
        insight:
            'Your response suggests that you focus on possibilities ahead rather than allowing one missed chance to define your direction.',
        gains: [
          GrowthGain(GrowthType.flexibility, 2),
          GrowthGain(GrowthType.consistency, 1),
        ],
      ),
      ScenarioOption(
        text: 'Ask someone what they would have done.',
        insight:
            'Your response suggests that you value outside perspectives when trying to understand a difficult experience.',
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Keep thinking about what I should have done.',
        insight:
            'Your response suggests that the experience still matters to you. It may help to turn those thoughts into one practical lesson for next time.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.learning, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'teamwork-disagreement',
    title: 'Working as a Team',
    summary: 'Your team disagrees about how to complete a task.',
    situation:
        'You are working on a shared project. You have an idea that you believe will work well, but the rest of the team prefers a different approach.',
    category: ScenarioCategory.decisions,
    options: [
      ScenarioOption(
        text: 'Present my idea and explain its benefits.',
        insight:
            'Your response suggests that you are comfortable taking initiative and communicating the reasoning behind your ideas.',
        gains: [
          GrowthGain(GrowthType.decisionMaking, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Listen to the team and consider their approach.',
        insight:
            'Your response suggests that you value collaboration and are willing to learn from different ways of thinking.',
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.flexibility, 1),
        ],
      ),
      ScenarioOption(
        text: 'Suggest combining the strongest parts of both ideas.',
        insight:
            'Your response suggests that you look for practical compromises instead of treating disagreements as all-or-nothing choices.',
        gains: [
          GrowthGain(GrowthType.flexibility, 2),
          GrowthGain(GrowthType.adaptation, 1),
        ],
      ),
      ScenarioOption(
        text: 'Let the team decide without sharing my opinion.',
        insight:
            'Your response suggests that you may prefer avoiding disagreement. It could be useful to explore what makes sharing your perspective difficult.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.consistency, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'too-many-priorities',
    title: 'Too Many Priorities',
    summary: 'Several important responsibilities need your attention.',
    situation:
        'You have deadlines, personal responsibilities, and goals you want to work on. Everything feels important, but you cannot give all of them your attention at the same time.',
    category: ScenarioCategory.challenges,
    options: [
      ScenarioOption(
        text: 'Choose the most important task and start there.',
        insight:
            'Your response suggests that you prioritize action and understand that progress often begins with choosing one clear direction.',
        gains: [
          GrowthGain(GrowthType.decisionMaking, 2),
          GrowthGain(GrowthType.consistency, 1),
        ],
      ),
      ScenarioOption(
        text: 'Make a schedule for everything.',
        insight:
            'Your response suggests that structure helps you manage responsibilities and feel more in control of your time.',
        gains: [
          GrowthGain(GrowthType.consistency, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Ask for help or delegate where possible.',
        insight:
            'Your response suggests that you recognize when sharing responsibilities can lead to better results.',
        gains: [
          GrowthGain(GrowthType.adaptation, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Take a break and rethink my priorities.',
        insight:
            'Your response suggests that you understand the importance of stepping back before making decisions under pressure.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.flexibility, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'starting-again',
    title: 'Starting Again',
    summary: 'You need to restart something after losing progress.',
    situation:
        'You have been working toward a personal goal for weeks, but an unexpected event interrupted your routine. You now feel far behind and are unsure how to begin again.',
    category: ScenarioCategory.change,
    options: [
      ScenarioOption(
        text: 'Start with a small step today.',
        insight:
            'Your response suggests that you believe progress can be rebuilt through manageable actions rather than waiting for perfect conditions.',
        gains: [
          GrowthGain(GrowthType.consistency, 2),
          GrowthGain(GrowthType.adaptation, 1),
        ],
      ),
      ScenarioOption(
        text: 'Review my old plan and improve it.',
        insight:
            'Your response suggests that you use previous experiences to adjust your approach and make your next attempt more effective.',
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
      ScenarioOption(
        text: 'Give myself time before trying again.',
        insight:
            'Your response suggests that you recognize the need to recover before committing to a new effort.',
        gains: [
          GrowthGain(GrowthType.selfAwareness, 2),
          GrowthGain(GrowthType.flexibility, 1),
        ],
      ),
      ScenarioOption(
        text: 'Set a new and more realistic goal.',
        insight:
            'Your response suggests that you are willing to adjust your expectations to create a more sustainable path forward.',
        gains: [
          GrowthGain(GrowthType.adaptation, 2),
          GrowthGain(GrowthType.decisionMaking, 1),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'unexpected-responsibility',
    title: 'An Unexpected Responsibility',
    summary: 'You are asked to take responsibility for something new.',
    situation:
        'Someone offers you a responsibility that could help you develop new skills. However, you already have commitments, and accepting it may make your daily life more demanding.',
    category: ScenarioCategory.decisions,
    options: [
      ScenarioOption(
        text: 'Accept it as a chance to grow.',
        insight:
            'Your response suggests that you are motivated by learning through experience and are willing to challenge yourself.',
        gains: [
          GrowthGain(GrowthType.learning, 2),
          GrowthGain(GrowthType.adaptation, 1),
        ],
      ),
      ScenarioOption(
        text: 'Check my current commitments before deciding.',
        insight:
            'Your response suggests that you consider your capacity and responsibilities before taking on something new.',
        gains: [
          GrowthGain(GrowthType.decisionMaking, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
      ScenarioOption(
        text: 'Ask whether the responsibility can be shared.',
        insight:
            'Your response suggests that you look for ways to make new challenges manageable through cooperation.',
        gains: [
          GrowthGain(GrowthType.flexibility, 2),
          GrowthGain(GrowthType.adaptation, 1),
        ],
      ),
      ScenarioOption(
        text: 'Decline because I need to focus on my current goals.',
        insight:
            'Your response suggests that you value focus and recognize that saying no can sometimes protect your long-term priorities.',
        gains: [
          GrowthGain(GrowthType.consistency, 2),
          GrowthGain(GrowthType.selfAwareness, 1),
        ],
      ),
    ],
  ),
];
