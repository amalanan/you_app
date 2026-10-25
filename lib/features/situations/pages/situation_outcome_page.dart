import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/flow_scaffold.dart';
import '../logic/situation_flow_controller.dart';

/// Step 5: what happened afterward + what did you learn.
class SituationOutcomePage extends StatefulWidget {
  const SituationOutcomePage({super.key, required this.flow});

  final SituationFlowController flow;

  @override
  State<SituationOutcomePage> createState() => _SituationOutcomePageState();
}

class _SituationOutcomePageState extends State<SituationOutcomePage> {
  late final _afterwards = TextEditingController(text: widget.flow.afterwards);
  late final _lesson = TextEditingController(text: widget.flow.lesson);

  @override
  void dispose() {
    _afterwards.dispose();
    _lesson.dispose();
    super.dispose();
  }

  void _save() {
    // TODO: save the reflection (repository / database) before opening the result.
    context.push(AppRoutes.situationSaved, extra: widget.flow);
  }

  @override
  Widget build(BuildContext context) {
    final flow = widget.flow;
    final label = context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600);

    return FlowScaffold(
      button: AppButton(label: AppStrings.continueLabel, onPressed: _save),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.whatHappenedAfterward, style: label),
          const SizedBox(height: AppSizes.sm),
          AppTextField(
            controller: _afterwards,
            hint: AppStrings.describeWhatNext,
            minLines: 6,
            maxLines: 8,
            maxLength: 1000,
            onChanged: flow.setAfterwards,
          ),
          const SizedBox(height: AppSizes.lg),
          Text(AppStrings.whatDidYouLearn, style: label),
          const SizedBox(height: AppSizes.sm),
          AppTextField(
            controller: _lesson,
            hint: AppStrings.lessonHint,
            minLines: 5,
            maxLines: 7,
            maxLength: 300,
            onChanged: flow.setLesson,
          ),
        ],
      ),
    );
  }
}
