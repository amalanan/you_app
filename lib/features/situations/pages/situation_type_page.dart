import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/flow_scaffold.dart';
import '../logic/situation_flow_controller.dart';
import '../models/situation_models.dart';
import '../widgets/situation_type_tile.dart';

/// Step 2: "What kind of situation was this?"
class SituationTypePage extends StatelessWidget {
  const SituationTypePage({super.key, required this.flow});

  final SituationFlowController flow;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: flow,
      builder: (context, _) => FlowScaffold(
        button: AppButton(
          label: AppStrings.continueLabel,
          onPressed: flow.hasType
              ? () => context.push(AppRoutes.situationFeelings, extra: flow)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.situationTypeTitle,
              style: context.text.headlineLarge
                  ?.copyWith(fontSize: context.rs(26), height: 1.3),
            ),
            const SizedBox(height: AppSizes.lg),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSizes.md,
              crossAxisSpacing: AppSizes.md,
              childAspectRatio: 1.05,
              children: [
                for (final t in SituationType.values)
                  SituationTypeTile(
                    type: t,
                    selected: flow.type == t,
                    onTap: () => flow.selectType(t),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
