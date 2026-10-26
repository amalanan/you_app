import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/sub_page.dart';

/// Light / Dark / System.
class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  static const _options = [
    (ThemeMode.system, AppStrings.themeSystem),
    (ThemeMode.light, AppStrings.themeLight),
    (ThemeMode.dark, AppStrings.themeDark),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController.instance;

    return SubPage(
      title: AppStrings.menuAppearance,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: controller,
        builder: (context, mode, _) => Column(
          children: [
            for (final (value, label) in _options) ...[
              InkWell(
                onTap: () => controller.setMode(value),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          style: context.text.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      if (mode == value)
                        const Icon(Icons.check, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
              Divider(height: 1, color: context.borderColor),
            ],
          ],
        ),
      ),
    );
  }
}
