import 'package:flutter/material.dart';
import 'package:you_app/core/helpers/extensions.dart';
import 'package:you_app/core/helpers/responsive.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/growth_type.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_segmented.dart';
import '../../../../core/widgets/sub_page.dart';
import '../data/mock_insights.dart';
import '../models/growth_detail.dart';
import '../widgets/growth_line_chart.dart';

/// One skill: range tabs, current / previous score, chart and notes.
class GrowthDetailPage extends StatefulWidget {
  const GrowthDetailPage({super.key, required this.type});

  final GrowthType type;

  @override
  State<GrowthDetailPage> createState() => _GrowthDetailPageState();
}

class _GrowthDetailPageState extends State<GrowthDetailPage> {
  GrowthRange _range = GrowthRange.week;

  @override
  Widget build(BuildContext context) {
    final detail = growthDetailFor(widget.type, _range);
    final change = detail.change;

    return SubPage(
      title: widget.type.label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSegmented(
            labels: [for (final r in GrowthRange.values) r.label],
            selectedIndex: _range.index,
            onChanged: (i) => setState(() => _range = GrowthRange.values[i]),
          ),
          const SizedBox(height: AppSizes.lg),
          Center(
            child: Column(
              children: [
                Text(
                  '${detail.current}',
                  style: context.text.displayLarge?.copyWith(
                    fontSize: context.rs(44),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
                Text(
                  AppStrings.currentScore,
                  style: context.text.bodySmall?.copyWith(color: context.mutedText),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Stat(value: '${detail.previous}', label: AppStrings.previousScore),
              _Stat(
                value: '${change >= 0 ? '+' : ''}$change',
                label: AppStrings.change,
                end: true,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          GrowthLineChart(points: detail.points),
          const SizedBox(height: AppSizes.xl),
          SizedBox(
            width: double.infinity,
            child: AppCard(
              padding: const EdgeInsets.all(AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.whatDoesItMean,
                    style: context.text.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    detail.meaning,
                    style: context.text.bodyMedium
                        ?.copyWith(color: context.mutedText, height: 1.6),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Text(
            AppStrings.fromRecentExperiences,
            style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSizes.md),
          for (final text in detail.experiences) ...[
            SizedBox(
              width: double.infinity,
              child: AppCard(
                // TODO: open the experience it comes from.
                onTap: () {},
                child: Row(
                  children: [
                    Expanded(
                      child: Text(text, style: context.text.bodySmall),
                    ),
                    Icon(Icons.chevron_right, color: context.mutedText),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.sm),
          ],
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, this.end = false});

  final String value;
  final String label;
  final bool end;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: end ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(value, style: context.text.headlineLarge),
        Text(
          label,
          style: context.text.bodySmall?.copyWith(color: context.mutedText),
        ),
      ],
    );
  }
}
