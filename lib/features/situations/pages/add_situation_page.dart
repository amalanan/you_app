import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/flow_scaffold.dart';
import '../logic/situation_flow_controller.dart';

/// Step 1: "Something happened?" (creates the flow controller).
class AddSituationPage extends StatefulWidget {
  const AddSituationPage({super.key});

  @override
  State<AddSituationPage> createState() => _AddSituationPageState();
}

class _AddSituationPageState extends State<AddSituationPage> {
  final _flow = SituationFlowController();
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    _flow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _flow,
      builder: (context, _) => FlowScaffold(
        button: AppButton(
          label: AppStrings.continueLabel,
          onPressed: _flow.hasWhatHappened
              ? () => context.push(AppRoutes.situationType, extra: _flow)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.situationTitle,
              style: context.text.headlineLarge?.copyWith(fontSize: context.rs(28)),
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              AppStrings.situationSubtitle,
              style: context.text.bodyMedium?.copyWith(color: context.mutedText),
            ),
            const SizedBox(height: AppSizes.xl),
            Text(
              AppStrings.whatHappened,
              style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSizes.sm),
            AppTextField(
              controller: _text,
              hint: AppStrings.describeWhatHappened,
              minLines: 8,
              maxLines: 10,
              maxLength: 1000,
              onChanged: _flow.setWhatHappened,
            ),
          ],
        ),
      ),
    );
  }
}
