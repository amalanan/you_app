import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/storage/storage_keys.dart';
import '../../../core/widgets/menu_tile.dart';
import '../../../core/widgets/sub_page.dart';
import '../logic/delete_account.dart';

/// Privacy & Data: analytics switch, export (later) and delete account.
class PrivacyDataPage extends StatefulWidget {
  const PrivacyDataPage({super.key});

  @override
  State<PrivacyDataPage> createState() => _PrivacyDataPageState();
}

class _PrivacyDataPageState extends State<PrivacyDataPage> {
  final _storage = LocalStorage.instance;
  late bool _analytics = _storage.getBool(StorageKeys.analytics, defaultValue: false);

  void _setAnalytics(bool value) {
    setState(() => _analytics = value);
    _storage.setBool(StorageKeys.analytics, value);
    // TODO: turn real analytics on / off here.
  }

  @override
  Widget build(BuildContext context) {
    final divider = Divider(height: 1, color: context.borderColor);

    return SubPage(
      title: AppStrings.menuPrivacyData,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.privacyAnalytics,
                      style: context.text.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppStrings.privacyAnalyticsBody,
                      style: context.text.bodySmall
                          ?.copyWith(color: context.mutedText, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Switch(value: _analytics, onChanged: _setAnalytics),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          divider,
          MenuTile(
            icon: Icons.download_outlined,
            label: AppStrings.exportData,
            onTap: () => context.showSnack(AppStrings.comingSoon),
          ),
          divider,
          MenuTile(
            icon: Icons.delete_outline,
            label: AppStrings.menuDeleteAccount,
            destructive: true,
            onTap: () => confirmAndDeleteAccount(context),
          ),
        ],
      ),
    );
  }
}
