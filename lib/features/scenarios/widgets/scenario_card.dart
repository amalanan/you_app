import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../models/scenario.dart';

/// One row of the scenario list.
class ScenarioCard extends StatelessWidget {
  const ScenarioCard({super.key, required this.scenario, required this.onTap});

  final Scenario scenario;
  final VoidCallback onTap;

  IconData get _icon => switch (scenario.category) {
        ScenarioCategory.decisions => Icons.alt_route,
        ScenarioCategory.challenges => Icons.terrain,
        ScenarioCategory.change => Icons.autorenew,
      };

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusLg);

    return Material(
      color: context.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: context.borderColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: Icon(_icon, color: AppColors.secondary, size: 30),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scenario.title,
                      style: context.text.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      scenario.summary,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.bodySmall
                          ?.copyWith(color: context.mutedText, height: 1.4),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 13, color: context.mutedText),
                        const SizedBox(width: 4),
                        Text(
                          AppStrings.minutes(scenario.minutes),
                          style: context.text.bodySmall?.copyWith(
                            fontSize: 11,
                            color: context.mutedText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: context.mutedText),
            ],
          ),
        ),
      ),
    );
  }
}
