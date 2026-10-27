class LegalSection {
  const LegalSection(this.heading, this.body);

  final String heading;
  final String body;
}

class FaqItem {
  const FaqItem(this.question, this.answer);

  final String question;
  final String answer;
}

const legalUpdated = 'Last updated: October 2026';

// TODO: your real support email.
const supportEmail = 'support@example.com';

// NOTE: written as a solid starting point. Before you publish the app, have a
// lawyer read it and add your company name and the law that applies to you.

const termsSections = [
  LegalSection(
    '1. About YOU',
    'YOU is a personal-growth app. It helps you understand yourself through realistic scenarios and through reflections you write about moments in your own life.\n\n'
        'By creating an account or using YOU, you agree to these Terms of Use. If you do not agree, please do not use the app.',
  ),
  LegalSection(
    '2. YOU is not professional care',
    'YOU is not a medical, psychological, or therapeutic service, and it does not give diagnoses or treatment. The insights you see are meant to support your self-awareness, nothing more.\n\n'
        'If you are struggling, feel unsafe, or are in crisis, please contact a qualified professional or your local emergency services right away.',
  ),
  LegalSection(
    '3. Your account',
    'You must be at least 16 years old to use YOU, or older if the law in your country requires it.\n\n'
        'Give us accurate information when you sign up and keep your password private. You are responsible for what happens under your account. If you think someone else has used it, tell us as soon as possible.',
  ),
  LegalSection(
    '4. Your content',
    'What you write in YOU (your situations, answers, reflections and ratings) belongs to you.\n\n'
        'You allow us to store and process it only to run the app for you, for example to save it and to generate the insights and growth scores that only you can see.',
  ),
  LegalSection(
    '5. Insights and scores',
    'Insights, growth scores and patterns are generated from the answers you give. They are simple reflections of those answers. They are not tests, measurements, or promises about who you are or what will happen.\n\n'
        'One response never defines you. Your picture becomes clearer through patterns over time.',
  ),
  LegalSection(
    '6. Using the app fairly',
    'Please do not:\n'
        '• use YOU for anything unlawful,\n'
        '• try to break, copy, or reverse-engineer the app,\n'
        '• access another person\'s account,\n'
        '• interfere with the app or its security.',
  ),
  LegalSection(
    '7. Changes to YOU and to these terms',
    'We may improve, change, or remove features over time. We may also update these terms. When the changes are important, we will let you know in the app.\n\n'
        'If you keep using YOU after a change, it means you accept the new terms.',
  ),
  LegalSection(
    '8. Ending your account',
    'You can stop using YOU at any time. You can delete your account and your data from Profile > Delete Account.\n\n'
        'We may suspend or close an account that seriously or repeatedly breaks these terms.',
  ),
  LegalSection(
    '9. Our responsibility',
    'We work hard to keep YOU useful and reliable, but the app is provided "as is", without promises that it will always be available or free of errors.\n\n'
        'To the extent the law allows, we are not responsible for indirect or accidental losses that come from using the app. Nothing here limits rights you have by law that cannot be limited.',
  ),
  LegalSection(
    '10. Contact',
    'Questions about these terms? Reach us from Profile > Help & Support > Contact Us.',
  ),
];

const privacyPolicySections = [
  LegalSection(
    '1. Our promise',
    'YOU asks you to write about personal moments, so we treat your information with care. This policy explains what we collect, why, and the choices you have.\n\n'
        'In short: we collect only what the app needs, we do not sell your data, and your reflections are never used for advertising.',
  ),
  LegalSection(
    '2. What we collect',
    '• Account details: your name and email address.\n'
        '• What you create: situations, scenario answers, reflections, confidence ratings, and the growth scores and insights made from them.\n'
        '• Your settings: theme, language, and notification choices.\n'
        '• Basic technical information (such as device type, app version, and crash reports) only if you turn on "Share anonymous usage data" in Profile > Privacy & Data.',
  ),
  LegalSection(
    '3. How we use it',
    '• To create your account and keep you signed in.\n'
        '• To save your reflections and show you your journey, insights and growth.\n'
        '• To send reminders you have turned on.\n'
        '• To keep the app secure and fix problems.\n'
        '• To improve YOU, using anonymous usage data, and only if you allowed it.',
  ),
  LegalSection(
    '4. Who can see your reflections',
    'Only you. Your situations, answers and reflections are not shown to other users, and the team does not read them as part of running the app.',
  ),
  LegalSection(
    '5. Sharing',
    'We do not sell or rent your personal information.\n\n'
        'We may use trusted service providers, for example for hosting, sign-in, or crash reporting. They may only use your information to provide their service to us.\n\n'
        'We may also share information when the law requires it.',
  ),
  LegalSection(
    '6. Where your data is kept',
    'Depending on the version of the app, your data is kept on your device and on secure servers that we use to run YOU. If your data is processed in another country, we take reasonable steps to protect it.',
  ),
  LegalSection(
    '7. How long we keep it',
    'We keep your information while your account is active. When you delete your account, your data is removed. Copies in backups are erased within a reasonable period after that.',
  ),
  LegalSection(
    '8. Your choices and rights',
    '• See and update your details in the app.\n'
        '• Turn notifications and anonymous usage data on or off at any time.\n'
        '• Delete your account and data from Profile > Delete Account.\n'
        '• Ask us for a copy of your data, or ask any privacy question, from Help & Support.\n\n'
        'Depending on where you live, you may have more rights by law, and we will respect them.',
  ),
  LegalSection(
    '9. Security',
    'We use reasonable technical and organisational measures to protect your information. No app can be perfectly secure, so please use a strong password and keep it private.',
  ),
  LegalSection(
    '10. Children',
    'YOU is not made for people under 16. If you think a child has given us their information, please contact us and we will delete it.',
  ),
  LegalSection(
    '11. Changes to this policy',
    'If we change this policy in an important way, we will tell you in the app before the change takes effect.',
  ),
  LegalSection(
    '12. Contact',
    'For any privacy question, go to Profile > Help & Support > Contact Us.',
  ),
];

const faqItems = [
  FaqItem(
    'What is YOU?',
    'YOU is a personal-growth app. You explore realistic scenarios and reflect on real moments from your life, and over time the app shows you patterns in how you think, decide and grow.',
  ),
  FaqItem(
    'Is YOU a replacement for therapy?',
    'No. YOU supports self-reflection, but it is not medical or psychological care. If you are struggling or in crisis, please speak with a qualified professional or your local emergency services.',
  ),
  FaqItem(
    "What's the difference between a scenario and a situation?",
    'A scenario is an imagined moment that the app gives you, and you choose how you would respond. A situation is something that really happened to you, which you describe and reflect on yourself.',
  ),
  FaqItem(
    'How is my growth calculated?',
    'Each scenario and reflection adds small points to areas like decision making, learning and self-awareness, based on your answers. These scores are gentle indicators, not tests, and they become more meaningful as you add more.',
  ),
  FaqItem(
    'Who can see what I write?',
    'Only you. Your reflections are not shared with other users. You can read the details in the Privacy Policy.',
  ),
  FaqItem(
    'How do I change my reminders?',
    'Go to Profile > Notifications and switch each reminder on or off.',
  ),
  FaqItem(
    'How do I use dark mode?',
    'Go to Profile > Appearance and choose Light, Dark, or System to follow your phone.',
  ),
  FaqItem(
    'How do I delete my account and data?',
    'Go to Profile > Delete Account and confirm. Your account and data are removed.',
  ),
  FaqItem(
    'I found a problem or have an idea. Who do I tell?',
    'We would love to hear it. Open Profile > Help & Support and use Contact Us.',
  ),
];
