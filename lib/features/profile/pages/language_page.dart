import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/l10n/app_locale.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/sub_page.dart';

/// Choose the language, then Save. The whole app switches at once
/// (texts + right-to-left for Arabic).
class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  static var _languages = [
    (AppLocale.system, AppStrings.languageSystem),
    ('en', 'English'),
    ('ar', 'العربية'),
  ];

  late String _selected = AppLocale.savedChoice;

  Future<void> _save() async {
    final code = _selected;
    context.pop(); // back to Profile first, then the whole app changes language
    await AppLocale.instance.setLanguage(code);
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
