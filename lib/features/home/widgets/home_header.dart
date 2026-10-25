import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';

/// "Good morning, Amal 🌿" + avatar.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.name});

  final String name;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return AppStrings.goodMorning;
    if (hour < 17) return AppStrings.goodAfternoon;
    return AppStrings.goodEvening;
  }

  @override
  Widget build(BuildContext context) {
    final firstName = name.trim().split(' ').first;
    final title = firstName.isEmpty
        ? '$_greeting 🌿'
        : '$_greeting,\n$firstName 🌿';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: context.text.headlineLarge
                ?.copyWith(fontSize: context.rs(26), height: 1.3),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => context.go(AppRoutes.profile),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.blush,
            child: Text(
              firstName.isEmpty ? '?' : firstName[0].toUpperCase(),
              style: context.text.bodyLarge?.copyWith(
                color: AppColors.lightText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
