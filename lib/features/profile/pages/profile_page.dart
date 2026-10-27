import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/menu_tile.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../auth/data/auth_repository.dart';
import '../logic/delete_account.dart';

/// Profile tab: who you are + settings menu + log out.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // TODO: take the day from the real journey data.
  static const _day = 12;

  Future<void> _logOut(BuildContext context) async {
    await AuthRepository.instance.signOut();
    if (context.mounted) context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthRepository.instance;
    final name = auth.currentName ?? '';

    final items = <MenuTile>[
      MenuTile(
        icon: Icons.spa_outlined,
        label: AppStrings.myGrowth,
        onTap: () => context.go(AppRoutes.growth),
      ),
      MenuTile(
        icon: Icons.edit_note,
        label: AppStrings.menuReflectionPrefs,
        onTap: () => context.push(AppRoutes.profilePreferences),
      ),
      MenuTile(
        icon: Icons.notifications_none,
        label: AppStrings.menuNotifications,
        onTap: () => context.push(AppRoutes.profileNotifications),
      ),
      MenuTile(
        icon: Icons.palette_outlined,
        label: AppStrings.menuAppearance,
        onTap: () => context.push(AppRoutes.profileAppearance),
      ),
      MenuTile(
        icon: Icons.language,
        label: AppStrings.menuLanguage,
        onTap: () => context.push(AppRoutes.profileLanguage),
      ),
      MenuTile(
        icon: Icons.lock_outline,
        label: AppStrings.menuPrivacyData,
        onTap: () => context.push(AppRoutes.profilePrivacy),
      ),
      MenuTile(
        icon: Icons.help_outline,
        label: AppStrings.menuHelp,
        onTap: () => context.push(AppRoutes.profileHelp),
      ),
      MenuTile(
        icon: Icons.description_outlined,
        label: AppStrings.menuTerms,
        onTap: () => context.push(AppRoutes.profileTerms),
      ),
      MenuTile(
        icon: Icons.shield_outlined,
        label: AppStrings.menuPrivacyPolicy,
        onTap: () => context.push(AppRoutes.profilePrivacyPolicy),
      ),
      MenuTile(
        icon: Icons.info_outline,
        label: AppStrings.menuAbout,
        onTap: () => context.push(AppRoutes.profileAbout),
      ),
      MenuTile(
        icon: Icons.delete_outline,
        label: AppStrings.menuDeleteAccount,
        destructive: true,
        onTap: () => confirmAndDeleteAccount(context),
      ),
    ];

    final divider = Divider(height: 1, color: context.borderColor);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveCenter(
          maxWidth: 560,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.screenPadding,
              AppSizes.lg,
              AppSizes.screenPadding,
              AppSizes.lg,
            ),
            children: [
              Center(
                child: CircleAvatar(
                  radius: context.rs(44),
                  backgroundColor: AppColors.blush,
                  child: Text(
                    name.isEmpty ? '?' : name[0].toUpperCase(),
                    style: context.text.headlineLarge
                        ?.copyWith(fontSize: 32, color: AppColors.lightText),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.md),
              if (name.isNotEmpty)
                Center(child: Text(name, style: context.text.headlineLarge)),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  AppStrings.dayOfJourney(_day),
                  style: context.text.bodyMedium?.copyWith(color: context.mutedText),
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              for (var i = 0; i < items.length; i++) ...[
                items[i],
                if (i != items.length - 1) divider,
              ],
              const SizedBox(height: AppSizes.lg),
              AppCard(
                onTap: () => _logOut(context),
                child: Row(
                  children: [
                    const Icon(Icons.logout, size: 22),
                    const SizedBox(width: AppSizes.md),
                    Expanded(
                      child: Text(
                        AppStrings.logOut,
                        style: context.text.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Icon(Icons.chevron_right, color: context.mutedText),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
