import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/sub_page.dart';
import '../data/legal_content.dart';

/// Help & Support: contact email (tap to copy) + FAQ.
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: supportEmail));
    if (context.mounted) context.showSnack(AppStrings.copied);
  }

  @override
  Widget build(BuildContext context) {
    return SubPage(
      title: AppStrings.menuHelp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            onTap: () => _copyEmail(context),
            child: Row(
              children: [
                Icon(Icons.mail_outline, color: context.mutedText),
                const SizedBox(width: AppSizes.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.contactUs,
                        style: context.text.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        supportEmail,
                        style: context.text.bodySmall
                            ?.copyWith(color: context.mutedText),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.copy, size: 18, color: context.mutedText),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Text(AppStrings.faqTitle, style: context.text.headlineMedium),
          const SizedBox(height: AppSizes.sm),
          Theme(
            // no lines around the expanded tiles
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Column(
              children: [
                for (final item in faqItems)
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: const EdgeInsets.only(bottom: AppSizes.md),
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      item.question,
                      style: context.text.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    children: [
                      Text(
                        item.answer,
                        style: context.text.bodySmall
                            ?.copyWith(color: context.mutedText, height: 1.5),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
