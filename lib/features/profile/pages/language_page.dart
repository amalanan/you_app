import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/storage/storage_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/sub_page.dart';

/// Choose the language, then Save.
/// For now only the choice is saved. TODO: apply it with l10n (ARB files) so
/// the app text and direction really change.
class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  static const _languages = [
    ('en', 'English'),
    ('ar', 'العربية'),
  ];

  late String _selected =
      LocalStorage.instance.getString(StorageKeys.language) ?? 'en';

  Future<void> _save() async {
    await LocalStorage.instance.setString(StorageKeys.language, _selected);
    if (!mounted) return;
    context.showSnack(AppStrings.languageSaved);
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return SubPage(
      title: AppStrings.menuLanguage,
      child: Column(
        children: [
          for (final (code, name) in _languages) ...[
            InkWell(
              onTap: () => setState(() => _selected = code),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: context.text.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    if (_selected == code)
                      const Icon(Icons.check, color: AppColors.primary),
                  ],
                ),
              ),
            ),
            Divider(height: 1, color: context.borderColor),
          ],
          const SizedBox(height: AppSizes.xl),
          AppButton(label: AppStrings.save, onPressed: _save),
        ],
      ),
    );
  }
}
