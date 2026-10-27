import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/storage/storage_keys.dart';
import '../../../core/widgets/app_chip.dart';
import '../../../core/widgets/sub_page.dart';

/// Reflection preferences. Saved on the device.
/// TODO: the design has no screen for this yet, adjust it to yours.
class ReflectionPreferencesPage extends StatefulWidget {
  const ReflectionPreferencesPage({super.key});

  @override
  State<ReflectionPreferencesPage> createState() =>
      _ReflectionPreferencesPageState();
}

class _ReflectionPreferencesPageState extends State<ReflectionPreferencesPage> {
  static const _times = [
    ('morning', AppStrings.timeMorning),
    ('evening', AppStrings.timeEvening),
    ('anytime', AppStrings.timeAnytime),
  ];

  final _storage = LocalStorage.instance;
  late String _time = _storage.getString(StorageKeys.reflectionTime) ?? 'anytime';
  late bool _tips = _storage.getBool(StorageKeys.reflectionTips);

  void _setTime(String value) {
    setState(() => _time = value);
    _storage.setString(StorageKeys.reflectionTime, value);
  }

  void _setTips(bool value) {
    setState(() => _tips = value);
    _storage.setBool(StorageKeys.reflectionTips, value);
  }

  @override
  Widget build(BuildContext context) {
    return SubPage(
      title: AppStrings.menuReflectionPrefs,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.prefTimeTitle, style: context.text.headlineMedium),
          const SizedBox(height: AppSizes.md),
          Wrap(
            spacing: AppSizes.sm,
            runSpacing: AppSizes.sm,
            children: [
              for (final (value, label) in _times)
                AppChip(
                  label: label,
                  tonal: true,
                  selected: _time == value,
                  onTap: () => _setTime(value),
                ),
            ],
          ),
          const SizedBox(height: AppSizes.xl),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.prefTipsTitle,
                      style: context.text.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppStrings.prefTipsBody,
                      style: context.text.bodySmall
                          ?.copyWith(color: context.mutedText),
                    ),
                  ],
                ),
              ),
              Switch(value: _tips, onChanged: _setTips),
            ],
          ),
        ],
      ),
    );
  }
}
