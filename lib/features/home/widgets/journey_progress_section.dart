import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/widgets/icon_box.dart';
import '../models/home_data.dart';

/// "Your journey" + Day 12 + row of progress dots.
class JourneyProgressSection extends StatelessWidget {
  const JourneyProgressSection({super.key, required this.journey});

  final JourneyProgress journey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.yourJourney,
          style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSizes.sm),
        Row(
          children: [
            const IconBox(icon: Icons.terrain, color: AppColors.secondary),
            const SizedBox(width: AppSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.dayNumber(journey.day),
                    style: context.text.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(journey.totalSteps, (i) {
                      final done = i < journey.completedSteps;
                      return Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: done ? AppColors.secondary : context.borderColor,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
