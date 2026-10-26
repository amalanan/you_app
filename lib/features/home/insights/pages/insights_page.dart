import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:you_app/core/helpers/extensions.dart';
import 'package:you_app/core/helpers/responsive.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/responsive_center.dart';
import '../data/mock_insights.dart';
import '../widgets/insight_card.dart';

/// Insights tab: 3 insight cards + a button to My Growth.
class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

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
              AppSizes.md,
              AppSizes.screenPadding,
              AppSizes.lg,
            ),
            children: [
              Text(
                AppStrings.insightsTitle,
                style: context.text.headlineLarge?.copyWith(fontSize: context.rs(26)),
              ),
              const SizedBox(height: AppSizes.lg),
              for (final item in mockInsights) ...[
                InsightCard(item: item),
                const SizedBox(height: AppSizes.md),
              ],
              const SizedBox(height: AppSizes.sm),
              AppButton(
                label: AppStrings.viewMyGrowth,
                onPressed: () => context.go(AppRoutes.growth),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
