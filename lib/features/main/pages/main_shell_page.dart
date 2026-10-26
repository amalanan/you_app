import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_bottom_nav.dart';

/// Holds the bottom navigation bar around the 4 tabs.
class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _items = [
    AppBottomNavItem(asset: AppAssets.navHome, label: AppStrings.navHome),
    AppBottomNavItem(
      icon: Icons.edit_calendar_outlined,
      selectedIcon: Icons.edit_calendar,
      label: AppStrings.navJourney,
    ),
    AppBottomNavItem(
      icon: Icons.bar_chart_outlined,
      selectedIcon: Icons.bar_chart_rounded,
      label: AppStrings.navInsights,
    ),
    AppBottomNavItem(asset: AppAssets.navProfile, label: AppStrings.navProfile),
  ];

  @override
  Widget build(BuildContext context) {
    final index = navigationShell.currentIndex;

    return PopScope(
      // Back on another tab returns to Home first, then exits.
      canPop: index == 0 || context.canPop(),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) navigationShell.goBranch(0);
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: AppBottomNav(
          items: _items,
          currentIndex: index,
          // tapping the current tab again goes back to that tab's first page
          onTap: (i) => navigationShell.goBranch(i, initialLocation: i == index),
          onAddTap: () => context.push(AppRoutes.addSituation),
        ),
      ),
    );
  }
}
