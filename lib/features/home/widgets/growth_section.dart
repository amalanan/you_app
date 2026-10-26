import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/models/growth_score.dart';
import '../../../core/models/growth_type.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/icon_box.dart';
import '../models/home_data.dart';

/// "YOUR GROWTH" + one row per skill.
class GrowthSection extends StatelessWidget {
  const GrowthSection({super.key, required this.growth});

  final List<GrowthScore> growth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.yourGrowth,
                style: context.text.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.insights),
              style: TextButton.styleFrom(
                foregroundColor: context.mutedText,
                visualDensity: VisualDensity.compact,
              ),
              child: Text(
                AppStrings.seeProgress,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.sm),
        for (final item in growth) ...[
          _GrowthRow(item: item),
          const SizedBox(height: AppSizes.md),
        ],
      ],
    );
  }
}

class _GrowthRow extends StatelessWidget {
  const _GrowthRow({required this.item});

  final GrowthScore item;

  @override
  Widget build(BuildContext context) {
    final type = item.type;

    return Row(
      children: [
        IconBox(icon: type.icon, color: type.iconColor),
        const SizedBox(width: AppSizes.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type.label,
                style: context.text.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: item.score / 100),
                duration: AppDurations.medium * 2,
                curve: Curves.easeOut,
                builder: (_, value, __) => LinearProgressIndicator(
                  value: value,
                  minHeight: 5,
                  borderRadius: BorderRadius.circular(3),
                  color: type.barColor,
                  backgroundColor: context.borderColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSizes.md),
        SizedBox(
          width: 36,
          child: Text(
            '${item.score}',
            textAlign: TextAlign.end,
            style: context.text.headlineMedium?.copyWith(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
