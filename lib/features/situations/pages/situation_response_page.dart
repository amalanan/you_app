// // import 'package:flutter/material.dart' hide Text;
// //
// // import '../../../core/l10n/text.dart';
// // import 'package:go_router/go_router.dart';
// //
// // import '../../../core/constants/app_colors.dart';
// // import '../../../core/constants/app_sizes.dart';
// // import '../../../core/constants/app_strings.dart';
// // import '../../../core/helpers/extensions.dart';
// // import '../../../core/routing/app_routes.dart';
// // import '../../../core/widgets/app_button.dart';
// // import '../../../core/widgets/app_slider.dart';
// // import '../../../core/widgets/app_text_field.dart';
// // import '../../../core/widgets/flow_scaffold.dart';
// // import '../logic/situation_flow_controller.dart';
// //
// // /// Step 4: what did you do + how confident were you.
// // class SituationResponsePage extends StatefulWidget {
// //   const SituationResponsePage({super.key, required this.flow});
// //
// //   final SituationFlowController flow;
// //
// //   @override
// //   State<SituationResponsePage> createState() => _SituationResponsePageState();
// // }
// //
// // class _SituationResponsePageState extends State<SituationResponsePage> {
// //   late final _action = TextEditingController(text: widget.flow.action);
// //
// //   @override
// //   void dispose() {
// //     _action.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final flow = widget.flow;
// //
// //     return ListenableBuilder(
// //       listenable: flow,
// //       builder: (context, _) => FlowScaffold(
// //         button: AppButton(
// //           label: AppStrings.continueLabel,
// //           onPressed: () => context.push(AppRoutes.situationOutcome, extra: flow),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               AppStrings.whatDidYouDo,
// //               style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
// //             ),
// //             const SizedBox(height: AppSizes.sm),
// //             AppTextField(
// //               controller: _action,
// //               hint: AppStrings.describeWhatYouDid,
// //               minLines: 6,
// //               maxLines: 8,
// //               maxLength: 1000,
// //               onChanged: flow.setAction,
// //             ),
// //             const SizedBox(height: AppSizes.lg),
// //             Text(AppStrings.howConfidentResponse, style: context.text.headlineMedium),
// //             const SizedBox(height: AppSizes.md),
// //             Center(
// //               child: Text(
// //                 '${flow.confidence}',
// //                 style: context.text.headlineLarge?.copyWith(
// //                   fontSize: 28,
// //                   fontWeight: FontWeight.w500,
// //                   color: AppColors.primary,
// //                 ),
// //               ),
// //             ),
// //             AppSlider(value: flow.confidence, onChanged: flow.setConfidence),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart' hide Text;
// import 'package:go_router/go_router.dart';
//
// import '../../../core/l10n/text.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_sizes.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../core/helpers/extensions.dart';
// import '../../../core/routing/app_routes.dart';
// import '../../../core/widgets/app_button.dart';
// import '../../../core/widgets/app_slider.dart';
// import '../../../core/widgets/app_text_field.dart';
// import '../../../core/widgets/flow_scaffold.dart';
// import '../logic/situation_flow_controller.dart';
// import '../logic/situation_text_checker.dart';
//
// class SituationResponsePage extends StatefulWidget {
//   const SituationResponsePage({super.key, required this.flow});
//
//   final SituationFlowController flow;
//
//   @override
//   State<SituationResponsePage> createState() => _SituationResponsePageState();
// }
//
// class _SituationResponsePageState extends State<SituationResponsePage> {
//   late final _action = TextEditingController(text: widget.flow.action);
//
//   final _textChecker = SituationTextChecker();
//
//   late final Future<void> _checkerInitialization;
//
//   String? _errorMessage;
//   bool _checkerAvailable = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkerInitialization = _initializeChecker();
//   }
//
//   Future<void> _initializeChecker() async {
//     try {
//       await _textChecker.initialize();
//       _checkerAvailable = true;
//     } catch (e) {
//       debugPrint('Dictionary initialization failed: $e');
//     }
//   }
//
//   Future<void> _continue() async {
//     await _checkerInitialization;
//
//     final action = _action.text.trim();
//
//     // The action field is optional.
//     if (action.isNotEmpty &&
//         _checkerAvailable &&
//         !_textChecker.isMeaningful(action)) {
//       setState(() {
//         _errorMessage = AppStrings.situationInvalidText;
//       });
//       return;
//     }
//
//     if (!mounted) return;
//
//     context.push(AppRoutes.situationOutcome, extra: widget.flow);
//   }
//
//   @override
//   void dispose() {
//     _action.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final flow = widget.flow;
//
//     return ListenableBuilder(
//       listenable: flow,
//       builder:
//           (context, _) => FlowScaffold(
//             button: AppButton(
//               label: AppStrings.continueLabel,
//               onPressed: _continue,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   AppStrings.whatDidYouDo,
//                   style: context.text.bodyLarge?.copyWith(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: AppSizes.sm),
//                 AppTextField(
//                   controller: _action,
//                   hint: AppStrings.describeWhatYouDid,
//                   minLines: 6,
//                   maxLines: 8,
//                   maxLength: 1000,
//                   onChanged: (value) {
//                     flow.setAction(value);
//                     if (_errorMessage != null) {
//                       setState(() => _errorMessage = null);
//                     }
//                   },
//                 ),
//                 if (_errorMessage != null) ...[
//                   const SizedBox(height: AppSizes.xs),
//                   Text(
//                     _errorMessage!,
//                     style: context.text.bodySmall?.copyWith(
//                       color: Theme.of(context).colorScheme.error,
//                     ),
//                   ),
//                 ],
//                 const SizedBox(height: AppSizes.lg),
//                 Text(
//                   AppStrings.howConfidentResponse,
//                   style: context.text.headlineMedium,
//                 ),
//                 const SizedBox(height: AppSizes.md),
//                 Center(
//                   child: Text(
//                     '${flow.confidence}',
//                     style: context.text.headlineLarge?.copyWith(
//                       fontSize: 28,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                 ),
//                 AppSlider(
//                   value: flow.confidence,
//                   onChanged: flow.setConfidence,
//                 ),
//               ],
//             ),
//           ),
//     );
//   }
// }

import 'package:flutter/material.dart' hide Text;
import 'package:go_router/go_router.dart';

import '../../../core/l10n/text.dart';
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

class SituationResponsePage extends StatefulWidget {
  const SituationResponsePage({super.key, required this.flow});

  final SituationFlowController flow;

  @override
  State<SituationResponsePage> createState() =>
      _SituationResponsePageState();
}

class _SituationResponsePageState extends State<SituationResponsePage> {
  late final _action =
  TextEditingController(text: widget.flow.action);

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
          onPressed: () => context.push(
            AppRoutes.situationOutcome,
            extra: flow,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.whatDidYouDo,
              style: context.text.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
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
            Text(
              AppStrings.howConfidentResponse,
              style: context.text.headlineMedium,
            ),
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
            AppSlider(
              value: flow.confidence,
              onChanged: flow.setConfidence,
            ),
          ],
        ),
      ),
    );
  }
}
