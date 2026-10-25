import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../auth/data/auth_repository.dart';

/// Minimal for now: who you are + sign out.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthRepository.instance;
    final name = auth.currentName ?? '';

    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.screenPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.blush,
                  child: Text(
                    name.isEmpty ? '?' : name[0].toUpperCase(),
                    style: context.text.headlineLarge
                        ?.copyWith(color: AppColors.lightText),
                  ),
                ),
                const SizedBox(height: AppSizes.md),
                if (name.isNotEmpty)
                  Text(name, style: context.text.headlineLarge),
                if (auth.currentEmail != null)
                  Text(
                    auth.currentEmail!,
                    style: context.text.bodyMedium
                        ?.copyWith(color: context.mutedText),
                  ),
                const SizedBox(height: AppSizes.xl),
                AppButton(
                  label: AppStrings.signOut,
                  secondary: true,
                  onPressed: () async {
                    await auth.signOut();
                    if (context.mounted) context.go(AppRoutes.login);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
