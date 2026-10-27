import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/menu_tile.dart';
import '../../../core/widgets/sub_page.dart';

/// About: logo, tagline, version and links.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // TODO: read it from the app (package_info_plus) instead of typing it.
  static const _version = '1.0.0';

  @override
  Widget build(BuildContext context) {
    final divider = Divider(height: 1, color: context.borderColor);

    return SubPage(
      title: AppStrings.menuAbout,
      child: Column(
        children: [
          const SizedBox(height: AppSizes.md),
          Image.asset(AppAssets.logo, width: 84),
          const SizedBox(height: AppSizes.sm),
          Text(
            AppStrings.appName,
            style: context.text.displayLarge?.copyWith(fontSize: 40),
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            AppStrings.aboutTagline,
            textAlign: TextAlign.center,
            style: context.text.bodyMedium?.copyWith(color: context.mutedText),
          ),
          const SizedBox(height: 4),
          Text(
            AppStrings.versionLabel(_version),
            style: context.text.bodySmall?.copyWith(color: context.mutedText),
          ),
          const SizedBox(height: AppSizes.xl),
          divider,
          MenuTile(
            icon: Icons.shield_outlined,
            label: AppStrings.menuPrivacyPolicy,
            onTap: () => context.push(AppRoutes.profilePrivacyPolicy),
          ),
          divider,
          MenuTile(
            icon: Icons.description_outlined,
            label: AppStrings.menuTerms,
            onTap: () => context.push(AppRoutes.profileTerms),
          ),
          divider,
          MenuTile(
            icon: Icons.mail_outline,
            label: AppStrings.contactUs,
            onTap: () => context.push(AppRoutes.profileHelp),
          ),
        ],
      ),
    );
  }
}
