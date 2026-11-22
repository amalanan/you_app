// import 'package:flutter/material.dart' hide Text;
//
// import '../../../core/l10n/text.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../core/constants/app_sizes.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../core/helpers/extensions.dart';
// import '../../../core/helpers/responsive.dart';
// import '../../../core/routing/app_routes.dart';
// import '../../../core/widgets/app_button.dart';
// import '../../../core/widgets/app_text_field.dart';
// import '../../../core/widgets/flow_scaffold.dart';
// import '../logic/situation_flow_controller.dart';
//
// /// Step 1: "Something happened?" (creates the flow controller).
// class AddSituationPage extends StatefulWidget {
//   const AddSituationPage({super.key});
//
//   @override
//   State<AddSituationPage> createState() => _AddSituationPageState();
// }
//
// class _AddSituationPageState extends State<AddSituationPage> {
//   final _flow = SituationFlowController();
//   final _text = TextEditingController();
//
//   @override
//   void dispose() {
//     _text.dispose();
//     _flow.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//       listenable: _flow,
//       builder: (context, _) => FlowScaffold(
//         button: AppButton(
//           label: AppStrings.continueLabel,
//           onPressed: _flow.hasWhatHappened
//               ? () => context.push(AppRoutes.situationType, extra: _flow)
//               : null,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppStrings.situationTitle,
//               style: context.text.headlineLarge?.copyWith(fontSize: context.rs(28)),
//             ),
//             const SizedBox(height: AppSizes.sm),
//             Text(
//               AppStrings.situationSubtitle,
//               style: context.text.bodyMedium?.copyWith(color: context.mutedText),
//             ),
//             const SizedBox(height: AppSizes.xl),
//             Text(
//               AppStrings.whatHappened,
//               style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: AppSizes.sm),
//             AppTextField(
//               controller: _text,
//               hint: AppStrings.describeWhatHappened,
//               minLines: 8,
//               maxLines: 10,
//               maxLength: 1000,
//               onChanged: _flow.setWhatHappened,
//             ),
//           ],
//         ),
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
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/flow_scaffold.dart';
import '../../../core/helpers/validators.dart';
import '../logic/situation_flow_controller.dart';
import '../logic/situation_text_checker.dart';

// Step 1: "Something happened?" (creates the flow controller).
class AddSituationPage extends StatefulWidget {
  const AddSituationPage({super.key});

  @override
  State<AddSituationPage> createState() => _AddSituationPageState();
}

class _AddSituationPageState extends State<AddSituationPage> {
  final _flow = SituationFlowController();
  final _text = TextEditingController();
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
    }
  }

  void _continue() {
    // Basic validation
    final basicError = Validators.situationDescription(_text.text);

    if (basicError != null) {
      setState(() => _errorMessage = basicError);
      return;
    }

    // Offline dictionary validation
    if (!_textChecker.isMeaningful(_text.text)) {
      setState(() {
        _errorMessage = AppStrings.situationInvalidText;
      });
      return;
    }

    context.push(AppRoutes.situationType, extra: _flow);
  }

  void _onTextChanged(String value) {
    _flow.setWhatHappened(value);

    if (_errorMessage != null) {
      setState(() => _errorMessage = null);
    }
  }

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
      builder:
          (context, _) => FlowScaffold(
            button: AppButton(
              label: AppStrings.continueLabel,
              onPressed:
                  _flow.hasWhatHappened && _checkerReady ? _continue : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.situationTitle,
                  style: context.text.headlineLarge?.copyWith(
                    fontSize: context.rs(28),
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                Text(
                  AppStrings.situationSubtitle,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.mutedText,
                  ),
                ),
                const SizedBox(height: AppSizes.xl),
                Text(
                  AppStrings.whatHappened,
                  style: context.text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                AppTextField(
                  controller: _text,
                  hint: AppStrings.describeWhatHappened,
                  minLines: 8,
                  maxLines: 10,
                  maxLength: 1000,
                  onChanged: _onTextChanged,
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    _errorMessage!,
                    style: context.text.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
    );
  }
}
