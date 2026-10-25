import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../auth/data/auth_repository.dart';
import '../data/mock_home_data.dart';
import '../widgets/add_situation_card.dart';
import '../widgets/growth_section.dart';
import '../widgets/home_header.dart';
import '../widgets/journey_progress_section.dart';
import '../widgets/today_scenario_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace mockHomeData with real data.
    const data = mockHomeData;
    final name = AuthRepository.instance.currentName ?? '';

    return Scaffold(
      body: SafeArea(
        bottom: false, // the bottom nav handles the bottom inset
        child: ResponsiveCenter(
          maxWidth: 560,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.screenPadding,
              AppSizes.md,
              AppSizes.screenPadding,
              AppSizes.lg,
            ),
            children: [
              HomeHeader(name: name),
              const SizedBox(height: AppSizes.lg),
              JourneyProgressSection(journey: data.journey),
              const SizedBox(height: AppSizes.lg),
              TodayScenarioCard(scenario: data.scenario),
              const SizedBox(height: AppSizes.xl),
              GrowthSection(growth: data.growth),
              const SizedBox(height: AppSizes.sm),
              const AddSituationCard(),
            ],
          ),
        ),
      ),
    );
  }
}
