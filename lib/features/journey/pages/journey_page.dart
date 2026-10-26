import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/widgets/responsive_center.dart';
import '../data/mock_journey.dart';
import '../widgets/journey_timeline.dart';
import '../widgets/stat_card.dart';

/// Journey tab: day counter, 3 stats and the activity timeline.
class JourneyPage extends StatelessWidget {
  const JourneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveCenter(
          maxWidth: 560,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.screenPadding,
              AppSizes.lg,
              AppSizes.screenPadding,
              AppSizes.lg,
            ),
            children: [
              Center(
                child: Text(
                  AppStrings.dayNumber(mockDay),
                  style: context.text.headlineLarge
                      ?.copyWith(fontSize: context.rs(28)),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  AppStrings.daysOfReflection(mockDay),
                  style: context.text.bodyMedium?.copyWith(color: context.mutedText),
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              const Row(
                children: [
                  Expanded(
                    child: StatCard(label: AppStrings.statReflections, value: mockReflections),
                  ),
                  SizedBox(width: AppSizes.md),
                  Expanded(
                    child: StatCard(label: AppStrings.statSituations, value: mockSituations),
                  ),
                  SizedBox(width: AppSizes.md),
                  Expanded(
                    child: StatCard(label: AppStrings.statScenarios, value: mockScenarios),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.xl),
              const JourneyTimeline(entries: mockJourney),
            ],
          ),
        ),
      ),
    );
  }
}
