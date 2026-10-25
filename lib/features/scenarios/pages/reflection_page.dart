import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_chip.dart';
import '../../../core/widgets/app_text_field.dart';
import '../data/mock_scenarios.dart';
import '../logic/scenario_flow_controller.dart';
import '../../../core/widgets/flow_scaffold.dart';

/// Step 3: why did you choose this + what mattered most.
class ReflectionPage extends StatefulWidget {
  const ReflectionPage({super.key, required this.flow});

  final ScenarioFlowController flow;

  @override
  State<ReflectionPage> createState() => _ReflectionPageState();
}

class _ReflectionPageState extends State<ReflectionPage> {
  late final _reason = TextEditingController(text: widget.flow.reason);

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flow = widget.flow;

    return ListenableBuilder(
      listenable: flow,
      builder: (context, _) => FlowScaffold(
        stepText: AppStrings.stepOf(3),
        button: AppButton(
          label: AppStrings.completeScenario,
          secondary: true, // purple, as in the design
          onPressed: () => context.push(AppRoutes.scenarioResult, extra: flow),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.whyChoose, style: context.text.headlineLarge),
            const SizedBox(height: AppSizes.md),
            AppTextField(
              controller: _reason,
              hint: AppStrings.reasonHint,
              minLines: 6,
              maxLines: 8,
              maxLength: 500,
              onChanged: flow.setReason,
            ),
            const SizedBox(height: AppSizes.lg),
            Text(AppStrings.whatMattered, style: context.text.headlineMedium),
            const SizedBox(height: AppSizes.md),
            Wrap(
              spacing: AppSizes.sm,
              runSpacing: AppSizes.sm,
              children: [
                for (final m in matterOptions)
                  AppChip(
                    label: m,
                    selected: flow.matter == m,
                    onTap: () => flow.toggleMatter(m),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
