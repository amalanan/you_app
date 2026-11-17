// import 'package:flutter/material.dart' hide Text;
//
// import '../../../core/l10n/text.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../core/constants/app_sizes.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../core/helpers/extensions.dart';
// import '../../../core/routing/app_routes.dart';
// import '../../../core/widgets/app_button.dart';
// import '../../../core/widgets/app_text_field.dart';
// import '../../../core/widgets/flow_scaffold.dart';
// import '../logic/situation_flow_controller.dart';
//
// /// Step 5: what happened afterward + what did you learn.
// class SituationOutcomePage extends StatefulWidget {
//   const SituationOutcomePage({super.key, required this.flow});
//
//   final SituationFlowController flow;
//
//   @override
//   State<SituationOutcomePage> createState() => _SituationOutcomePageState();
// }
//
// class _SituationOutcomePageState extends State<SituationOutcomePage> {
//   late final _afterwards = TextEditingController(text: widget.flow.afterwards);
//   late final _lesson = TextEditingController(text: widget.flow.lesson);
//
//   @override
//   void dispose() {
//     _afterwards.dispose();
//     _lesson.dispose();
//     super.dispose();
//   }
//
//   bool _saving = false;
//
//   Future<void> _save() async {
//     setState(() => _saving = true);
//     final ok = await widget.flow.submit();
//     if (!mounted) return;
//     setState(() => _saving = false);
//     if (ok) {
//       context.push(AppRoutes.situationSaved, extra: widget.flow);
//     } else {
//       context.showSnack(widget.flow.error ?? AppStrings.unknownError);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final flow = widget.flow;
//     final label = context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600);
//
//     return FlowScaffold(
//       button: AppButton(
//         label: AppStrings.continueLabel,
//         isLoading: _saving,
//         onPressed: _save,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(AppStrings.whatHappenedAfterward, style: label),
//           const SizedBox(height: AppSizes.sm),
//           AppTextField(
//             controller: _afterwards,
//             hint: AppStrings.describeWhatNext,
//             minLines: 6,
//             maxLines: 8,
//             maxLength: 1000,
//             onChanged: flow.setAfterwards,
//           ),
//           const SizedBox(height: AppSizes.lg),
//           Text(AppStrings.whatDidYouLearn, style: label),
//           const SizedBox(height: AppSizes.sm),
//           AppTextField(
//             controller: _lesson,
//             hint: AppStrings.lessonHint,
//             minLines: 5,
//             maxLines: 7,
//             maxLength: 300,
//             onChanged: flow.setLesson,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart' hide Text;
import 'package:go_router/go_router.dart';

import '../../../core/l10n/text.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/flow_scaffold.dart';
import '../logic/situation_flow_controller.dart';
import '../logic/situation_text_checker.dart';

class SituationOutcomePage extends StatefulWidget {
  const SituationOutcomePage({super.key, required this.flow});

  final SituationFlowController flow;

  @override
  State<SituationOutcomePage> createState() =>
      _SituationOutcomePageState();
}

class _SituationOutcomePageState extends State<SituationOutcomePage> {
  late final _afterwards =
  TextEditingController(text: widget.flow.afterwards);

  late final _lesson =
  TextEditingController(text: widget.flow.lesson);

  final _textChecker = SituationTextChecker();

  late final Future<void> _checkerInitialization;

  String? _afterwardsError;
  String? _lessonError;

  bool _checkerAvailable = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _checkerInitialization = _initializeChecker();
  }

  Future<void> _initializeChecker() async {
    try {
      await _textChecker.initialize();
      _checkerAvailable = true;
    } catch (e) {
      debugPrint('Dictionary initialization failed: $e');
    }
  }

  Future<void> _save() async {
    await _checkerInitialization;

    final afterwards = _afterwards.text.trim();
    final lesson = _lesson.text.trim();

    // Both fields are optional. Validate only non-empty values.
    final afterwardsInvalid = afterwards.isNotEmpty &&
        _checkerAvailable &&
        !_textChecker.isMeaningful(afterwards);

    final lessonInvalid = lesson.isNotEmpty &&
        _checkerAvailable &&
        !_textChecker.isMeaningful(lesson);

    if (afterwardsInvalid || lessonInvalid) {
      setState(() {
        _afterwardsError =
        afterwardsInvalid ? AppStrings.situationInvalidText : null;
        _lessonError =
        lessonInvalid ? AppStrings.situationInvalidText : null;
      });
      return;
    }

    setState(() => _saving = true);

    final ok = await widget.flow.submit();

    if (!mounted) return;

    setState(() => _saving = false);

    if (ok) {
      context.push(AppRoutes.situationSaved, extra: widget.flow);
    } else {
      context.showSnack(
        widget.flow.error ?? AppStrings.unknownError,
      );
    }
  }

  @override
  void dispose() {
    _afterwards.dispose();
    _lesson.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flow = widget.flow;
    final label = context.text.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
    );

    return FlowScaffold(
      button: AppButton(
        label: AppStrings.continueLabel,
        isLoading: _saving,
        onPressed: _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.whatHappenedAfterward,
            style: label,
          ),
          const SizedBox(height: AppSizes.sm),
          AppTextField(
            controller: _afterwards,
            hint: AppStrings.describeWhatNext,
            minLines: 6,
            maxLines: 8,
            maxLength: 1000,
            onChanged: (value) {
              flow.setAfterwards(value);
              if (_afterwardsError != null) {
                setState(() => _afterwardsError = null);
              }
            },
          ),
          if (_afterwardsError != null) ...[
            const SizedBox(height: AppSizes.xs),
            Text(
              _afterwardsError!,
              style: context.text.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
          const SizedBox(height: AppSizes.lg),
          Text(
            AppStrings.whatDidYouLearn,
            style: label,
          ),
          const SizedBox(height: AppSizes.sm),
          AppTextField(
            controller: _lesson,
            hint: AppStrings.lessonHint,
            minLines: 5,
            maxLines: 7,
            maxLength: 300,
            onChanged: (value) {
              flow.setLesson(value);
              if (_lessonError != null) {
                setState(() => _lessonError = null);
              }
            },
          ),
          if (_lessonError != null) ...[
            const SizedBox(height: AppSizes.xs),
            Text(
              _lessonError!,
              style: context.text.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
