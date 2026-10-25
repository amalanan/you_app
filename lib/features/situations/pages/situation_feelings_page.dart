import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_chip.dart';
import '../../../core/widgets/flow_scaffold.dart';
import '../logic/situation_flow_controller.dart';
import '../models/situation_models.dart';

/// Step 3: "Let's reflect on it." - pick one or more feelings.
class SituationFeelingsPage extends StatelessWidget {
  const SituationFeelingsPage({super.key, required this.flow});

  final SituationFlowController flow;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: flow,
      builder: (context, _) => FlowScaffold(
        button: AppButton(
          label: AppStrings.continueLabel,
          onPressed: flow.hasFeelings
              ? () => context.push(AppRoutes.situationResponse, extra: flow)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.reflectOnIt,
              style: context.text.headlineLarge?.copyWith(fontSize: context.rs(26)),
            ),
            const SizedBox(height: AppSizes.xl),
            Text(AppStrings.whatDidYouFeel, style: context.text.headlineMedium),
            const SizedBox(height: 4),
            Text(
              AppStrings.selectAllThatApply,
              style: context.text.bodySmall?.copyWith(color: context.mutedText),
            ),
            const SizedBox(height: AppSizes.md),
            Wrap(
              spacing: AppSizes.sm,
              runSpacing: AppSizes.sm,
              children: [
                for (final f in Feeling.values)
                  AppChip(
                    label: f.label,
                    tonal: true,
                    selected: flow.feelings.contains(f),
                    onTap: () => flow.toggleFeeling(f),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
