import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../helpers/extensions.dart';

/// Pill chip: green when selected, outlined when not.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.tonal = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  /// Grey filled look (feelings) instead of white outlined (filters).
  final bool tonal;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary
          : (tonal ? context.cardColor : context.colors.surface),
      shape: StadiumBorder(
        side: BorderSide(
          color: selected
              ? AppColors.primary
              : (tonal ? Colors.transparent : context.borderColor),
        ),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          child: Text(
            label,
            style: context.text.bodySmall?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: selected ? AppColors.white : context.colors.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
