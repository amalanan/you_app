/// Plain strings for now. Move to l10n (ARB) when you add Arabic/English switching.
abstract final class AppStrings {
  static const appName = 'YOU';
  static const tagline = 'Your Growth Journey';

  // Common actions
  static const next = 'Next';
  static const skip = 'Skip';
  static const startJourney = 'Start My Journey';
  static const or = 'or';
  static const signOut = 'Sign out';

  // Onboarding
  static const onboarding1Title = 'Meet yourself\ndifferently.';
  static const onboarding1Body =
      'Understand how you think, decide, adapt, and grow through the situations you experience.';
  static const onboarding2Title = 'Explore\nyour reactions.';
  static const onboarding2Body =
      'Respond to realistic scenarios and discover patterns in the way you approach challenges.';
  static const onboarding3Title = 'See how\nyou change.';
  static const onboarding3Body =
      'Reflect on your experiences and watch your personal growth evolve over time.';

  // Auth: shared fields
  static const email = 'Email';
  static const emailHint = 'you@example.com';
  static const password = 'Password';
  static const passwordHint = '••••••••';

  // Auth: login
  static const welcomeBack = 'Welcome back 👋';
  static const continueJourney = 'Continue your journey';
  static const forgotPassword = 'Forgot Password?';
  static const logIn = 'Log In';
  static const continueWithGoogle = 'Continue with Google';
  static const noAccount = "Don't have an account? ";
  static const createOne = 'Create one';
  static const enterEmailFirst = 'Enter your email first';
  static const resetLinkSent = 'Password reset link sent to your email';

  // Auth: sign up
  static const startYourJourney = 'Start your journey';
  static const createYourAccount = 'Create your account';
  static const name = 'Name';
  static const nameHint = 'Your name';
  static const confirmPassword = 'Confirm Password';
  static const agreeTo = 'I agree to the ';
  static const termsAndPrivacy = 'Terms & Privacy Policy';
  static const mustAgree = 'Please accept the terms to continue';
  static const createAccount = 'Create Account';
  static const haveAccount = 'Already have an account? ';
  static const logInLink = 'Log in';

  // Navigation
  static const navHome = 'Home';
  static const navJourney = 'Journey';
  static const navAdd = 'Add';
  static const navInsights = 'Insights';
  static const navProfile = 'Profile';
  static const comingSoon = 'Coming soon';

  // Home
  static const goodMorning = 'Good morning';
  static const goodAfternoon = 'Good afternoon';
  static const goodEvening = 'Good evening';
  static const yourJourney = 'Your journey';
  static String dayNumber(int n) => 'Day $n';
  static const todaysScenario = "TODAY'S SCENARIO";
  static String minutes(int n) => '$n min';
  static const exploreScenario = 'Explore Scenario';
  static const yourGrowth = 'YOUR GROWTH';
  static const seeProgress = 'See progress';
  static const decisionMaking = 'Decision Making';
  static const learning = 'Learning';
  static const selfAwareness = 'Self-Awareness';
  static const somethingHappened = 'Something happened today?';
  static const captureMoment = 'Capture a moment and reflect on it.';
  static const addSituation = 'Add Situation';

  // Scenarios
  static const exploreScenarios = 'Explore Scenarios';
  static const searchScenarios = 'Search scenarios';
  static const noScenariosFound = 'No scenarios found';
  static const filterAll = 'All';
  static const filterDecisions = 'Decisions';
  static const filterChallenges = 'Challenges';
  static const filterChange = 'Change';
  static const scenarioLabel = 'SCENARIO';
  static String stepOf(int step) => '$step of 3';
  static const whatWouldYouDo = 'What would you most likely do?';
  static const continueLabel = 'Continue';
  static const howConfident = 'How confident are you in your choice?';
  static const notConfident = 'Not confident';
  static const veryConfident = 'Very confident';
  static const whyChoose = 'Why did you choose this?';
  static const reasonHint = 'Tell us what was going through your mind...';
  static const whatMattered = 'What mattered most to you?';
  static const matterGrowth = 'Growth';
  static const matterSecurity = 'Security';
  static const matterFreedom = 'Freedom';
  static const matterStability = 'Stability';
  static const matterMoney = 'Money';
  static const matterAvoidingFailure = 'Avoiding Failure';
  static const matterOther = 'Other';
  static const completeScenario = 'Complete Scenario';
  static const insightTitle = 'A little insight about your response';
  static const growthFromScenario = 'Your growth from this scenario';
  static const oneResponseNote =
      "One response doesn't define you. Your profile becomes clearer through patterns over time.";
  static const viewMyGrowth = 'View My Growth';
  static const backToHome = 'Back to Home';

  // Situations (Add My Situation flow)
  static const other = 'Other';
  static const situationTitle = 'Something happened?';
  static const situationSubtitle = 'Tell us about a moment you want to understand better.';
  static const whatHappened = 'What happened?';
  static const describeWhatHappened = 'Describe what happened...';
  static const situationTypeTitle = 'What kind of situation was this?';
  static const typeDecision = 'Decision';
  static const typeChallenge = 'Challenge';
  static const typeWork = 'Work';
  static const typeStudy = 'Study';
  static const typeRelationship = 'Relationship';
  static const typePersonal = 'Personal';
  static const typeUnexpected = 'Unexpected';
  static const reflectOnIt = "Let's reflect on it.";
  static const whatDidYouFeel = 'What did you feel?';
  static const selectAllThatApply = 'Select all that apply';
  static const feelExcited = 'Excited';
  static const feelNervous = 'Nervous';
  static const feelConfident = 'Confident';
  static const feelConfused = 'Confused';
  static const feelFrustrated = 'Frustrated';
  static const feelDisappointed = 'Disappointed';
  static const feelHopeful = 'Hopeful';
  static const feelOverwhelmed = 'Overwhelmed';
  static const feelCalm = 'Calm';
  static const whatDidYouDo = 'What did you do?';
  static const describeWhatYouDid = 'Describe what you did...';
  static const howConfidentResponse = 'How confident were you about your response?';
  static const whatHappenedAfterward = 'What happened afterward?';
  static const describeWhatNext = 'Describe what happened next...';
  static const whatDidYouLearn = 'What did you learn?';
  static const lessonHint = 'What is the main lesson you learned from this?';
  static const reflectionSaved = 'Reflection saved.';
  static const whatWeNoticed = 'What we noticed';
  static const growthFromReflection = 'Your growth from this reflection';

  // Validation
  static const fieldRequired = 'This field is required';
  static const invalidEmail = 'Enter a valid email';
  static const shortPassword = 'Password must be at least 8 characters';
  static const passwordsDontMatch = 'Passwords do not match';

  // Errors
  static const networkError = 'No internet connection';
  static const serverError = 'Something went wrong on our side';
  static const unknownError = 'Unexpected error, please try again';
  static const wrongCredentials = 'Incorrect email or password';
  static const emailInUse = 'This email is already registered';
  static const userDisabled = 'This account has been disabled';
  static const googleUnavailable = 'Google sign-in is not available yet';
  static const tooManyRequests = 'Too many attempts, try again later';
}
