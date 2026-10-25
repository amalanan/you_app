import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../models/home_data.dart';

class TodayScenarioCard extends StatelessWidget {
  const TodayScenarioCard({super.key, required this.scenario});

  final TodayScenario scenario;

  @override
  Widget build(BuildContext context) {
    void open() => context.push(AppRoutes.scenarios);

    return AppCard(
      padding: const EdgeInsets.all(AppSizes.lg),
      onTap: open,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.todaysScenario,
                  style: context.text.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: context.mutedText),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            scenario.text,
            style: context.text.bodyLarge?.copyWith(height: 1.55),
          ),
          const SizedBox(height: AppSizes.sm),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: context.mutedText),
              const SizedBox(width: 6),
              Text(
                AppStrings.minutes(scenario.minutes),
                style: context.text.bodySmall?.copyWith(color: context.mutedText),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: FractionallySizedBox(
              widthFactor: 0.78,
              child: AppButton(
                label: AppStrings.exploreScenario,
                secondary: true,
                trailingIcon: Icons.arrow_forward,
                onPressed: open,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
