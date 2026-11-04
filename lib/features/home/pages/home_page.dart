import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/errors/failures.dart';
import '../../../core/helpers/data_events.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../core/widgets/status_view.dart';
import '../../auth/data/auth_repository.dart';
import '../data/home_repository.dart';
import '../models/home_data.dart';
import '../widgets/add_situation_card.dart';
import '../widgets/growth_section.dart';
import '../widgets/home_header.dart';
import '../widgets/journey_progress_section.dart';
import '../widgets/today_scenario_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeData? _data;
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

  // Something was saved (e.g. a scenario): refresh quietly.
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
      final data = await HomeRepository.instance.fetchHome();
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

  Widget _body(HomeData? data) {
    if (data == null) {
      if (_loading) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        );
      }
      final failure = _failure;
      return failure is NetworkFailure
          ? StatusView.offline(onRetry: _load)
          : StatusView.error(
        message: failure?.message ?? '',
        onRetry: _load,
      );
    }

    final name = AuthRepository.instance.currentName ?? '';
    final scenario = data.scenario;

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
          HomeHeader(name: name),
          const SizedBox(height: AppSizes.lg),
          JourneyProgressSection(journey: data.journey),
          const SizedBox(height: AppSizes.lg),
          if (scenario != null) ...[
            TodayScenarioCard(
              scenario: scenario,
              // the button opens today's scenario; the card itself opens the list
              onStart: () => context.push(
                AppRoutes.scenarios,
                extra: scenario.id.isEmpty ? null : scenario.id,
              ),
            ),
            const SizedBox(height: AppSizes.xl),
          ],
          GrowthSection(growth: data.growth),
          const SizedBox(height: AppSizes.sm),
          const AddSituationCard(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false, // the bottom nav handles the bottom inset
        child: ResponsiveCenter(maxWidth: 560, child: _body(_data)),
      ),
    );
  }
}
