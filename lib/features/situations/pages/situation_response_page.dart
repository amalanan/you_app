import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_slider.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/flow_scaffold.dart';
import '../logic/situation_flow_controller.dart';

/// Step 4: what did you do + how confident were you.
class SituationResponsePage extends StatefulWidget {
  const SituationResponsePage({super.key, required this.flow});

  final SituationFlowController flow;

  @override
  State<SituationResponsePage> createState() => _SituationResponsePageState();
}

class _SituationResponsePageState extends State<SituationResponsePage> {
  late final _action = TextEditingController(text: widget.flow.action);

  @override
  void dispose() {
    _action.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flow = widget.flow;

    return ListenableBuilder(
      listenable: flow,
      builder: (context, _) => FlowScaffold(
        button: AppButton(
          label: AppStrings.continueLabel,
          onPressed: () => context.push(AppRoutes.situationOutcome, extra: flow),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.whatDidYouDo,
              style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSizes.sm),
            AppTextField(
              controller: _action,
              hint: AppStrings.describeWhatYouDid,
              minLines: 6,
              maxLines: 8,
              maxLength: 1000,
              onChanged: flow.setAction,
            ),
            const SizedBox(height: AppSizes.lg),
            Text(AppStrings.howConfidentResponse, style: context.text.headlineMedium),
            const SizedBox(height: AppSizes.md),
            Center(
              child: Text(
                '${flow.confidence}',
                style: context.text.headlineLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
            AppSlider(value: flow.confidence, onChanged: flow.setConfidence),
          ],
        ),
      ),
    );
  }
}
