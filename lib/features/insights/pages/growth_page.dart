import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/errors/failures.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/models/growth_score.dart';
import '../../../core/models/growth_type.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/status_view.dart';
import '../../../core/widgets/sub_page.dart';
import '../data/growth_repository.dart';
import '../widgets/growth_row.dart';

/// "My Growth": every skill with its score, strongest and weakest side.
class GrowthPage extends StatefulWidget {
  const GrowthPage({super.key});

  @override
  State<GrowthPage> createState() => _GrowthPageState();
}

class _GrowthPageState extends State<GrowthPage> {
  List<GrowthScore>? _scores;
  Failure? _failure;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _failure = null;
    });
    try {
      final scores = await GrowthRepository.instance.fetchProfile();
      if (!mounted) return;
      setState(() {
        _scores = scores;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _failure = ErrorHandler.handle(e);
        _loading = false;
      });
    }
  }

  Widget _content(List<GrowthScore> scores) {
    final sorted = [...scores]..sort((a, b) => b.score.compareTo(a.score));
    final strongest = sorted.first.type;
    final weakest = sorted.last.type;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.growthSubtitle,
          style: context.text.bodyMedium?.copyWith(color: context.mutedText),
        ),
        const SizedBox(height: AppSizes.lg),
        for (final item in scores)
          GrowthRow(
            item: item,
            onTap: () => context.go(AppRoutes.growthDetail(item.type.name)),
          ),
        const SizedBox(height: AppSizes.lg),
        _SideCard(title: AppStrings.strongestSide, value: strongest.label),
        const SizedBox(height: AppSizes.md),
        _SideCard(title: AppStrings.worthExploring, value: weakest.label),
      ],
    );
  }

  Widget _body() {
    final scores = _scores;
    if (scores != null && scores.isNotEmpty) return _content(scores);

    final failure = _failure;
    return SizedBox(
      height: 360,
      child: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : failure is NetworkFailure
          ? StatusView.offline(onRetry: _load)
          : StatusView.error(message: failure?.message ?? '', onRetry: _load),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SubPage(title: AppStrings.myGrowth, child: _body());
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
