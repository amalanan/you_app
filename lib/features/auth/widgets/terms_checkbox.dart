import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';

class TermsCheckbox extends StatelessWidget {
  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.showError = false,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    final style = context.text.bodySmall?.copyWith(color: context.mutedText);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: value,
                onChanged: (v) => onChanged(v ?? false),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: style,
                  children: [
                    const TextSpan(text: AppStrings.agreeTo),
                    // TODO: open the real Terms / Privacy pages (TapGestureRecognizer).
                    TextSpan(
                      text: AppStrings.termsAndPrivacy,
                      style: style?.copyWith(
                        color: AppColors.secondary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              AppStrings.mustAgree,
              style: context.text.bodySmall?.copyWith(color: AppColors.error),
            ),
          ),
      ],
    );
  }
}
