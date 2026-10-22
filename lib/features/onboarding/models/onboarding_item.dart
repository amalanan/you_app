import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';

class OnboardingItem {
  const OnboardingItem({
    required this.title,
    required this.body,
    required this.image,
  });

  final String title;
  final String body;
  final String image;
}

const onboardingItems = [
  OnboardingItem(
    title: AppStrings.onboarding1Title,
    body: AppStrings.onboarding1Body,
    image: AppAssets.onboarding1,
  ),
  OnboardingItem(
    title: AppStrings.onboarding2Title,
    body: AppStrings.onboarding2Body,
    image: AppAssets.onboarding2,
  ),
  OnboardingItem(
    title: AppStrings.onboarding3Title,
    body: AppStrings.onboarding3Body,
    image: AppAssets.onboarding3,
  ),
];
