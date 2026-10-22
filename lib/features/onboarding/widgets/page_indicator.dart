import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/helpers/extensions.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: AppDurations.short,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: active ? AppColors.secondary : context.borderColor,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
