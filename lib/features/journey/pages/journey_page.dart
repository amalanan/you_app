import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/errors/failures.dart';
import '../../../core/helpers/data_events.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../core/widgets/status_view.dart';
import '../data/journey_repository.dart';
import '../models/journey_data.dart';
import '../widgets/journey_timeline.dart';
import '../widgets/stat_card.dart';

/// Journey tab: day counter, 3 stats and the activity timeline.
class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  JourneyData? _data;
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

  // Something was saved (a scenario or a situation): refresh quietly.
  void _onDataChanged() => _load(silent: true);

  /// [silent] = keep showing the old numbers while the new ones load.
  Future<void> _load({bool silent = false}) async {
    if (!silent) {
      setState(() {
        _loading = true;
        _failure = null;
      });
    }
    try {
      final data = await JourneyRepository.instance.fetchJourney();
      if (!mounted) return;
      setState(() {
        _data = data;
        _failure = null;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        if (_data == null) _failure = ErrorHandler.handle(e);
      });
    }
  }

  Widget _body(JourneyData? data) {
    if (data == null) {
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
          AppSizes.lg,
          AppSizes.screenPadding,
          AppSizes.lg,
        ),
        children: [
          Center(
            child: Text(
              AppStrings.dayNumber(data.day),
              style: context.text.headlineLarge?.copyWith(fontSize: context.rs(28)),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              AppStrings.daysOfReflection(data.day),
              style: context.text.bodyMedium?.copyWith(color: context.mutedText),
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Row(
            children: [
              Expanded(
                child: StatCard(label: AppStrings.statReflections, value: data.reflections),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: StatCard(label: AppStrings.statSituations, value: data.situations),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: StatCard(label: AppStrings.statScenarios, value: data.scenarios),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.xl),
          if (data.entries.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.xl),
              child: Column(
                children: [
                  const Icon(Icons.spa_outlined, size: 56, color: AppColors.secondary),
                  const SizedBox(height: AppSizes.md),
                  Text(AppStrings.journeyEmptyTitle, style: context.text.headlineMedium),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    AppStrings.journeyEmptyBody,
                    textAlign: TextAlign.center,
                    style: context.text.bodyMedium?.copyWith(color: context.mutedText),
                  ),
                ],
              ),
            )
          else
            JourneyTimeline(entries: data.entries),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveCenter(maxWidth: 560, child: _body(_data)),
      ),
    );
  }
}
