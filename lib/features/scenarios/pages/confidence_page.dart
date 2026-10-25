import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_slider.dart';
import '../logic/scenario_flow_controller.dart';
import '../../../core/widgets/flow_scaffold.dart';

/// Step 2: "How confident are you in your choice?"
class ConfidencePage extends StatelessWidget {
  const ConfidencePage({super.key, required this.flow});

  final ScenarioFlowController flow;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: flow,
      builder: (context, _) => FlowScaffold(
        stepText: AppStrings.stepOf(2),
        button: AppButton(
          label: AppStrings.continueLabel,
          onPressed: () => context.push(AppRoutes.scenarioReflection, extra: flow),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.howConfident,
              style: context.text.headlineLarge
                  ?.copyWith(fontSize: context.rs(26), height: 1.3),
            ),
            const SizedBox(height: AppSizes.xxl),
            Center(
              child: Text(
                '${flow.confidence}',
                style: context.text.displayLarge?.copyWith(
                  fontSize: context.rs(60),
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.lg),
            AppSlider(
              value: flow.confidence,
              onChanged: flow.setConfidence,
              minLabel: AppStrings.notConfident,
              maxLabel: AppStrings.veryConfident,
            ),
          ],
        ),
      ),
    );
  }
}
