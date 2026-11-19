import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';

/// Entry point to My Reflections, shown on the Journey tab under the stats.
class MyReflectionsTile extends StatelessWidget {
  const MyReflectionsTile({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusMd);
    final rtl = Directionality.of(context) == TextDirection.rtl;

    return Material(
      color: context.cardColor,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Row(
            children: [
              const Icon(Icons.auto_stories_outlined, color: AppColors.secondary),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Text(
                  AppStrings.myReflections,
                  style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Icon(
                rtl ? Icons.chevron_left : Icons.chevron_right,
                color: context.mutedText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}