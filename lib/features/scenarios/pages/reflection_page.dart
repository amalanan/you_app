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
// import '../../../core/widgets/app_chip.dart';
// import '../../../core/widgets/app_text_field.dart';
// import '../data/mock_scenarios.dart';
// import '../logic/scenario_flow_controller.dart';
// import '../../../core/widgets/flow_scaffold.dart';
//
// /// Step 3: why did you choose this + what mattered most.
// class ReflectionPage extends StatefulWidget {
//   const ReflectionPage({super.key, required this.flow});
//
//   final ScenarioFlowController flow;
//
//   @override
//   State<ReflectionPage> createState() => _ReflectionPageState();
// }
//
// class _ReflectionPageState extends State<ReflectionPage> {
//   late final _reason = TextEditingController(text: widget.flow.reason);
//
//   @override
//   void dispose() {
//     _reason.dispose();
//     super.dispose();
//   }
//
//   Future<void> _complete() async {
//     final ok = await widget.flow.submit();
//     if (!mounted) return;
//     if (ok) {
//       context.push(AppRoutes.scenarioResult, extra: widget.flow);
//     } else {
//       context.showSnack(widget.flow.error ?? AppStrings.unknownError);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final flow = widget.flow;
//
//     return ListenableBuilder(
//       listenable: flow,
//       builder: (context, _) => FlowScaffold(
//         stepText: AppStrings.stepOf(3),
//         button: AppButton(
//           label: AppStrings.completeScenario,
//           secondary: true, // purple, as in the design
//           isLoading: flow.isSubmitting,
//           onPressed: _complete,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(AppStrings.whyChoose, style: context.text.headlineLarge),
//             const SizedBox(height: AppSizes.md),
//             AppTextField(
//               controller: _reason,
//               hint: AppStrings.reasonHint,
//               minLines: 6,
//               maxLines: 8,
//               maxLength: 500,
//               onChanged: flow.setReason,
//             ),
//             const SizedBox(height: AppSizes.lg),
//             Text(AppStrings.whatMattered, style: context.text.headlineMedium),
//             const SizedBox(height: AppSizes.md),
//             Wrap(
//               spacing: AppSizes.sm,
//               runSpacing: AppSizes.sm,
//               children: [
//                 for (final m in matterOptions)
//                   AppChip(
//                     label: m,
//                     selected: flow.matter == m,
//                     onTap: () => flow.toggleMatter(m),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';
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
import '../../situations/logic/situation_text_checker.dart';

/// Step 3: why did you choose this + what mattered most.
class ReflectionPage extends StatefulWidget {
  const ReflectionPage({super.key, required this.flow});

  final ScenarioFlowController flow;

  @override
  State<ReflectionPage> createState() => _ReflectionPageState();
}

class _ReflectionPageState extends State<ReflectionPage> {
  late final _reason = TextEditingController(text: widget.flow.reason);

  final _textChecker = SituationTextChecker();

  bool _checkerReady = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeChecker();
  }

  Future<void> _initializeChecker() async {
    try {
      await _textChecker.initialize();

      if (mounted) {
        setState(() => _checkerReady = true);
      }
    } catch (e) {
      debugPrint('Dictionary initialization failed: $e');

      if (mounted) {
        setState(() => _checkerReady = true);
      }
    }
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  void _onReasonChanged(String value) {
    widget.flow.setReason(value);

    if (_errorMessage != null) {
      setState(() => _errorMessage = null);
    }
  }

  Future<void> _complete() async {
    final reason = _reason.text.trim();

    // Reason is optional, but if entered, it must be meaningful.
    if (reason.isNotEmpty && !_textChecker.isMeaningful(reason)) {
      setState(() {
        _errorMessage = AppStrings.situationInvalidText;
      });
      return;
    }

    final ok = await widget.flow.submit();

    if (!mounted) return;

    if (ok) {
      context.push(AppRoutes.scenarioResult, extra: widget.flow);
    } else {
      context.showSnack(widget.flow.error ?? AppStrings.unknownError);
    }
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
          secondary: true,
          isLoading: flow.isSubmitting,
          onPressed: _checkerReady && !flow.isSubmitting
              ? _complete
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.whyChoose,
              style: context.text.headlineLarge,
            ),
            const SizedBox(height: AppSizes.md),
            AppTextField(
              controller: _reason,
              hint: AppStrings.reasonHint,
              minLines: 6,
              maxLines: 8,
              maxLength: 500,
              onChanged: _onReasonChanged,
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: AppSizes.sm),
              Text(
                _errorMessage!,
                style: context.text.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
            const SizedBox(height: AppSizes.lg),
            Text(
              AppStrings.whatMattered,
              style: context.text.headlineMedium,
            ),
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
