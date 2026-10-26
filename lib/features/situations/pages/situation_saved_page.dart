import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/gain_row.dart';
import '../../../core/widgets/responsive_center.dart';
import '../data/situation_insight.dart';
import '../logic/situation_flow_controller.dart';
import '../widgets/plant_illustration.dart';

/// Final step: "Reflection saved." + what we noticed + growth earned.
class SituationSavedPage extends StatelessWidget {
  const SituationSavedPage({super.key, required this.flow});

  final SituationFlowController flow;

  @override
  Widget build(BuildContext context) {
    final insight = buildInsight(flow);

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
                      AppSizes.xl,
                      AppSizes.screenPadding,
                      AppSizes.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlantIllustration(height: context.rs(120)),
                        const SizedBox(height: AppSizes.lg),
                        Text(
                          AppStrings.reflectionSaved,
                          style: context.text.headlineLarge
                              ?.copyWith(fontSize: context.rs(24)),
                        ),
                        const SizedBox(height: AppSizes.lg),
                        Text(
                          AppStrings.whatWeNoticed,
                          style: context.text.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSizes.sm),
                        for (final line in insight.notices) ...[
                          Text(
                            line,
                            style: context.text.bodyMedium
                                ?.copyWith(color: context.mutedText, height: 1.6),
                          ),
                          const SizedBox(height: AppSizes.sm),
                        ],
                        const SizedBox(height: AppSizes.md),
                        Text(
                          AppStrings.growthFromReflection,
                          style: context.text.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSizes.md),
                        for (final gain in insight.gains) ...[
                          GainRow(gain: gain),
                          const SizedBox(height: AppSizes.md),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.screenPadding,
                    AppSizes.sm,
                    AppSizes.screenPadding,
                    AppSizes.lg,
                  ),
                  child: AppButton(
                    label: AppStrings.viewMyGrowth,
                    onPressed: () => context.go(AppRoutes.growth),
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
