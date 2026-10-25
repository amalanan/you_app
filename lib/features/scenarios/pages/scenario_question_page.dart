import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../logic/scenario_flow_controller.dart';
import '../widgets/option_tile.dart';
import '../../../core/widgets/flow_scaffold.dart';

/// Step 1: the situation + 4 answers.
class ScenarioQuestionPage extends StatelessWidget {
  const ScenarioQuestionPage({super.key, required this.flow});

  final ScenarioFlowController flow;

  @override
  Widget build(BuildContext context) {
    final scenario = flow.scenario;

    return ListenableBuilder(
      listenable: flow,
      builder: (context, _) => FlowScaffold(
        label: AppStrings.scenarioLabel,
        stepText: AppStrings.stepOf(1),
        button: AppButton(
          label: AppStrings.continueLabel,
          onPressed: flow.selectedIndex == null
              ? null
              : () => context.push(AppRoutes.scenarioConfidence, extra: flow),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scenario.situation,
              style: context.text.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500, height: 1.55),
            ),
            const SizedBox(height: AppSizes.lg),
            Text(
              scenario.question,
              style: context.text.headlineMedium,
            ),
            const SizedBox(height: AppSizes.md),
            for (var i = 0; i < scenario.options.length; i++) ...[
              OptionTile(
                letter: String.fromCharCode(65 + i), // A, B, C, D
                text: scenario.options[i].text,
                selected: flow.selectedIndex == i,
                onTap: () => flow.selectOption(i),
              ),
              const SizedBox(height: AppSizes.md),
            ],
          ],
        ),
      ),
    );
  }
}
