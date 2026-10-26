import 'package:flutter/material.dart';
import 'package:you_app/core/helpers/extensions.dart';
import 'package:you_app/core/models/growth_type.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/models/growth_score.dart';

/// "Decision Making  72" + bar (My Growth list).
class GrowthRow extends StatelessWidget {
  const GrowthRow({super.key, required this.item, required this.onTap});

  final GrowthScore item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.type.label,
                    style: context.text.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${item.score}',
                  style: context.text.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: item.score / 100),
              duration: AppDurations.medium * 2,
              curve: Curves.easeOut,
              builder:
                  (_, value, __) => LinearProgressIndicator(
                    value: value,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                    color: AppColors.primary,
                    backgroundColor: context.borderColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
