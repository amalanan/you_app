import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../helpers/extensions.dart';
import '../helpers/responsive.dart';

/// A tab icon: either a Material [icon] (+ optional [selectedIcon]) or a PNG [asset].
/// PNG assets are tinted with the tab color, so one file works for every state.
class AppBottomNavItem {
  const AppBottomNavItem({
    required this.label,
    this.icon,
    this.selectedIcon,
    this.asset,
  }) : assert(icon != null || asset != null);

  final String label;
  final IconData? icon;
  final IconData? selectedIcon;
  final String? asset;
}

/// Bottom bar with a raised round "Add" button in the middle.
/// [items] are the 4 tabs: the first two sit left of the button, the last two right.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.onAddTap,
  }) : assert(items.length == 4);

  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAddTap;

  Widget _tab(int i) => Expanded(
        child: _NavTab(
          item: items[i],
          selected: i == currentIndex,
          onTap: () => onTap(i),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: context.borderColor)),
        ),
        child: SafeArea(
          top: false,
          // heightFactor: 1 -> the bar is only as tall as its content
          // (without it, Center fills the whole screen height).
          child: Center(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.maxContentWidth + 120,
              ),
              child: SizedBox(
                height: AppSizes.bottomNavHeight,
                child: Row(
                  children: [
                    _tab(0),
                    _tab(1),
                    Expanded(child: _AddTab(onTap: onAddTap)),
                    _tab(2),
                    _tab(3),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({required this.item, required this.selected, required this.onTap});

  final AppBottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : context.mutedText;

    final Widget icon = item.asset != null
        ? Image.asset(
            item.asset!,
            width: 24,
            height: 24,
            color: color,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          )
        : Icon(
            selected ? (item.selectedIcon ?? item.icon) : item.icon,
            color: color,
            size: 26,
          );

    return InkResponse(
      onTap: onTap,
      radius: 36,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.square(dimension: 26, child: Center(child: icon)),
              const SizedBox(height: 2),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.bodySmall?.copyWith(
                  fontSize: 11,
                  height: 1.2,
                  color: color,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddTab extends StatelessWidget {
  const _AddTab({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: AppColors.primary,
              shape: const CircleBorder(),
              elevation: 3,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onTap,
                child: const SizedBox.square(
                  dimension: 48,
                  child: Icon(Icons.add, color: AppColors.white, size: 28),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              AppStrings.navAdd,
              style: context.text.bodySmall?.copyWith(
                fontSize: 11,
                height: 1.2,
                color: context.mutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
