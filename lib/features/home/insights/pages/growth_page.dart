import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:you_app/core/helpers/extensions.dart';
import 'package:you_app/core/models/growth_type.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/sub_page.dart';
import '../data/mock_insights.dart';
import '../widgets/growth_row.dart';


/// "My Growth": every skill with its score, strongest and weakest side.
class GrowthPage extends StatelessWidget {
  const GrowthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sorted = [...mockGrowthProfile]..sort((a, b) => b.score.compareTo(a.score));
    final strongest = sorted.first.type;
    final weakest = sorted.last.type;

    return SubPage(
      title: AppStrings.myGrowth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.growthSubtitle,
            style: context.text.bodyMedium?.copyWith(color: context.mutedText),
          ),
          const SizedBox(height: AppSizes.lg),
          for (final item in mockGrowthProfile)
            GrowthRow(
              item: item,
              onTap: () => context.go(AppRoutes.growthDetail(item.type.name)),
            ),
          const SizedBox(height: AppSizes.lg),
          _SideCard(title: AppStrings.strongestSide, value: strongest.label),
          const SizedBox(height: AppSizes.md),
          _SideCard(title: AppStrings.worthExploring, value: weakest.label),
        ],
      ),
    );
  }
}

class _SideCard extends StatelessWidget {
  const _SideCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppCard(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.md,
          horizontal: AppSizes.lg,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: context.text.bodySmall?.copyWith(color: context.mutedText),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: context.text.headlineMedium?.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
