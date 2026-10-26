import 'package:flutter/material.dart';
import 'package:you_app/core/helpers/extensions.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../models/growth_detail.dart';

/// One card of the Insights tab (lavender / grey / pink).
class InsightCard extends StatelessWidget {
  const InsightCard({super.key, required this.item});

  final InsightItem item;

  Color _background(BuildContext context) => switch (item.kind) {
        InsightKind.improvement => AppColors.logoPurple.withAlpha(36),
        InsightKind.pattern => context.cardColor,
        InsightKind.explore => AppColors.blush.withAlpha(70),
      };

  IconData get _icon => switch (item.kind) {
        InsightKind.improvement => Icons.trending_up,
        InsightKind.pattern => Icons.insights,
        InsightKind.explore => Icons.explore_outlined,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: _background(context),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: context.text.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSizes.sm),
                Text(
                  item.body,
                  style: context.text.bodyMedium
                      ?.copyWith(color: context.mutedText, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.md),
          Icon(_icon, size: 34, color: AppColors.secondary),
        ],
      ),
    );
  }
}
