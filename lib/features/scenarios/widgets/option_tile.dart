import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/helpers/extensions.dart';

/// One answer: "A  Accept the opportunity immediately."
class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.letter,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String letter;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusMd);

    return AnimatedContainer(
      duration: AppDurations.short,
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary.withAlpha(22)
            : context.colors.surface,
        borderRadius: radius,
        border: Border.all(
          color: selected ? AppColors.primary : context.borderColor,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: 18,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                    letter,
                    style: context.text.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: selected ? AppColors.primary : context.mutedText,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                Expanded(child: Text(text, style: context.text.bodyMedium)),
                if (selected) ...[
                  const SizedBox(width: AppSizes.sm),
                  const Icon(Icons.check_circle, color: AppColors.primary),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
