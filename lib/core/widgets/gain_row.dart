import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../helpers/extensions.dart';
import '../models/growth_type.dart';
import 'icon_box.dart';
import '../models/growth_gain.dart';

/// "Decision Making  +2" on the result screen.
class GainRow extends StatelessWidget {
  const GainRow({super.key, required this.gain});

  final GrowthGain gain;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconBox(icon: gain.type.icon, color: gain.type.iconColor),
        const SizedBox(width: AppSizes.md),
        Expanded(
          child: Text(
            gain.type.label,
            style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary),
          ),
          child: Text(
            '+${gain.points}',
            style: context.text.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
