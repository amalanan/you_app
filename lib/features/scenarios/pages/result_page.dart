import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/gain_row.dart';
import '../../../core/widgets/responsive_center.dart';
import '../logic/scenario_flow_controller.dart';
import '../widgets/mountain_illustration.dart';

/// Final screen: a small insight + the growth earned.
class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.flow});

  final ScenarioFlowController flow;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Back from here goes Home (the steps behind it are finished).
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(AppRoutes.home);
      },
      child: Scaffold(
        body: SafeArea(
          child: ResponsiveCenter(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSizes.screenPadding,
                      AppSizes.lg,
                      AppSizes.screenPadding,
                      AppSizes.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MountainIllustration(height: context.rs(130)),
                        const SizedBox(height: AppSizes.lg),
                        Text(
                          AppStrings.insightTitle,
                          style: context.text.headlineLarge
                              ?.copyWith(fontSize: context.rs(24), height: 1.3),
                        ),
                        const SizedBox(height: AppSizes.md),
                        Text(
                          flow.insight,
                          style: context.text.bodyLarge?.copyWith(
                            color: context.mutedText,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: AppSizes.lg),
                        Text(
                          AppStrings.growthFromScenario,
                          style: context.text.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSizes.md),
                        for (final gain in flow.gains) ...[
                          GainRow(gain: gain),
                          const SizedBox(height: AppSizes.md),
                        ],
                        const SizedBox(height: AppSizes.sm),
                        AppCard(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.spa_outlined, color: context.mutedText),
                              const SizedBox(width: AppSizes.md),
                              Expanded(
                                child: Text(
                                  AppStrings.oneResponseNote,
                                  style: context.text.bodySmall?.copyWith(
                                    color: context.mutedText,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.screenPadding,
                    AppSizes.sm,
                    AppSizes.screenPadding,
                    AppSizes.md,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        label: AppStrings.viewMyGrowth,
                        onPressed: () => context.go(AppRoutes.growth),
                      ),
                      TextButton(
                        onPressed: () => context.go(AppRoutes.home),
                        child: const Text(AppStrings.backToHome),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
