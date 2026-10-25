import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/helpers/extensions.dart';
import '../models/situation_models.dart';

/// One square of the type grid (icon + label).
class SituationTypeTile extends StatelessWidget {
  const SituationTypeTile({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final SituationType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusMd);
    final fg = selected ? AppColors.white : context.colors.onSurface;

    return AnimatedContainer(
      duration: AppDurations.short,
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : context.cardColor,
        borderRadius: radius,
        border: Border.all(
          color: selected ? AppColors.primary : context.borderColor,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(type.icon, size: 28, color: fg),
              const SizedBox(height: 8),
              Text(
                type.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
