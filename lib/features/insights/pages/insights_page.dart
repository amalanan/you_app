import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/errors/failures.dart';
import '../../../core/helpers/data_events.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../core/widgets/status_view.dart';
import '../data/insights_repository.dart';
import '../models/growth_detail.dart';
import '../widgets/insight_card.dart';

/// Insights tab: up to 3 insight cards + a button to My Growth.
class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  List<InsightItem>? _items;
  Failure? _failure;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    DataEvents.instance.addListener(_onDataChanged);
    _load();
  }

  @override
  void dispose() {
    DataEvents.instance.removeListener(_onDataChanged);
    super.dispose();
  }

  // Something was saved: refresh quietly.
  void _onDataChanged() => _load(silent: true);

  Future<void> _load({bool silent = false}) async {
    if (!silent) {
      setState(() {
        _loading = true;
        _failure = null;
      });
    }
    try {
      final items = await InsightsRepository.instance.fetchInsights();
      if (!mounted) return;
      setState(() {
        _items = items;
        _failure = null;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        if (_items == null) _failure = ErrorHandler.handle(e);
      });
    }
  }

  Widget _body(List<InsightItem>? items) {
    if (items == null) {
      if (_loading) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        );
      }
      final failure = _failure;
      return failure is NetworkFailure
          ? StatusView.offline(onRetry: _load)
          : StatusView.error(message: failure?.message ?? '', onRetry: _load);
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => _load(silent: true),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.screenPadding,
          AppSizes.md,
          AppSizes.screenPadding,
          AppSizes.lg,
        ),
        children: [
          Text(
            AppStrings.insightsTitle,
            style: context.text.headlineLarge?.copyWith(fontSize: context.rs(26)),
          ),
          const SizedBox(height: AppSizes.lg),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.xl),
              child: Column(
                children: [
                  const Icon(Icons.insights, size: 56, color: AppColors.secondary),
                  const SizedBox(height: AppSizes.md),
                  Text(AppStrings.insightsEmptyTitle, style: context.text.headlineMedium),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    AppStrings.insightsEmptyBody,
                    textAlign: TextAlign.center,
                    style: context.text.bodyMedium?.copyWith(color: context.mutedText),
                  ),
                ],
              ),
            )
          else
            for (final item in items) ...[
              InsightCard(item: item),
              const SizedBox(height: AppSizes.md),
            ],
          const SizedBox(height: AppSizes.sm),
          AppButton(
            label: AppStrings.viewMyGrowth,
            onPressed: () => context.go(AppRoutes.growth),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveCenter(maxWidth: 560, child: _body(_items)),
      ),
    );
  }
}
