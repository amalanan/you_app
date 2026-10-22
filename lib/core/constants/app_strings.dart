/// Plain strings for now. Move to l10n (ARB) when you add Arabic/English switching.
abstract final class AppStrings {
  static const appName = 'YOU';
  static const tagline = 'Your Growth Journey';

  // Common actions
  static const next = 'Next';
  static const skip = 'Skip';
  static const startJourney = 'Start My Journey';

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

  // Validation
  static const fieldRequired = 'This field is required';
  static const invalidEmail = 'Enter a valid email';
  static const shortPassword = 'Password must be at least 8 characters';
  static const passwordsDontMatch = 'Passwords do not match';

  // Errors
  static const networkError = 'No internet connection';
  static const serverError = 'Something went wrong on our side';
  static const unknownError = 'Unexpected error, please try again';
}
