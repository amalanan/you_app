import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_chip.dart';
import '../../../core/widgets/responsive_center.dart';
import '../data/mock_scenarios.dart';
import '../logic/scenario_flow_controller.dart';
import '../models/scenario.dart';
import '../widgets/scenario_card.dart';

class ScenariosPage extends StatefulWidget {
  const ScenariosPage({super.key});

  @override
  State<ScenariosPage> createState() => _ScenariosPageState();
}

class _ScenariosPageState extends State<ScenariosPage> {
  ScenarioCategory? _filter; // null = All
  bool _searching = false;
  String _query = '';

  List<Scenario> get _visible => mockScenarios.where((s) {
        final matchesFilter = _filter == null || s.category == _filter;
        final q = _query.trim().toLowerCase();
        final matchesQuery = q.isEmpty ||
            s.title.toLowerCase().contains(q) ||
            s.summary.toLowerCase().contains(q);
        return matchesFilter && matchesQuery;
      }).toList();

  void _open(Scenario scenario) {
    context.push(
      AppRoutes.scenarioQuestion,
      extra: ScenarioFlowController(scenario),
    );
  }

  void _toggleSearch() {
    setState(() {
      _searching = !_searching;
      if (!_searching) _query = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = _visible;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveCenter(
          maxWidth: 560,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.screenPadding,
                  AppSizes.md,
                  AppSizes.sm,
                  AppSizes.sm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _searching
                          ? TextField(
                              autofocus: true,
                              onChanged: (v) => setState(() => _query = v),
                              decoration: const InputDecoration(
                                hintText: AppStrings.searchScenarios,
                              ),
                            )
                          : Text(
                              AppStrings.exploreScenarios,
                              style: context.text.headlineLarge
                                  ?.copyWith(fontSize: context.rs(24)),
                            ),
                    ),
                    IconButton(
                      onPressed: _toggleSearch,
                      icon: Icon(_searching ? Icons.close : Icons.search),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                child: Row(
                  children: [
                    AppChip(
                      label: AppStrings.filterAll,
                      selected: _filter == null,
                      onTap: () => setState(() => _filter = null),
                    ),
                    for (final c in ScenarioCategory.values) ...[
                      const SizedBox(width: AppSizes.sm),
                      AppChip(
                        label: c.label,
                        selected: _filter == c,
                        onTap: () => setState(() => _filter = c),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.md),
              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          AppStrings.noScenariosFound,
                          style: context.text.bodyMedium
                              ?.copyWith(color: context.mutedText),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          AppSizes.screenPadding,
                          0,
                          AppSizes.screenPadding,
                          AppSizes.lg,
                        ),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: AppSizes.md),
                        itemBuilder: (_, i) => ScenarioCard(
                          scenario: items[i],
                          onTap: () => _open(items[i]),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
