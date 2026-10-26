import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_durations.dart';
import '../constants/app_sizes.dart';
import '../helpers/extensions.dart';

/// Segmented control: "7 days | 30 days | 3 months".
class AppSegmented extends StatelessWidget {
  const AppSegmented({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusMd - 2);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: AppDurations.short,
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(
                    color: i == selectedIndex ? AppColors.primary : Colors.transparent,
                    borderRadius: radius,
                  ),
                  child: Center(
                    child: Text(
                      labels[i],
                      style: context.text.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: i == selectedIndex
                            ? AppColors.white
                            : context.colors.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
