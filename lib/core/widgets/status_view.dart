import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../helpers/extensions.dart';
import 'app_button.dart';

/// Centered icon + title + message + button.
/// Ready-made: [StatusView.success] and [StatusView.offline] (screens 26 / 27 of the design).
class StatusView extends StatelessWidget {
  const StatusView({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  factory StatusView.success({
    Key? key,
    String title = AppStrings.successTitle,
    String message = AppStrings.successBody,
    String actionLabel = AppStrings.continueLabel,
    required VoidCallback onAction,
  }) =>
      StatusView(
        key: key,
        icon: Icons.check_circle,
        iconColor: AppColors.primary,
        title: title,
        message: message,
        actionLabel: actionLabel,
        onAction: onAction,
      );

  factory StatusView.offline({Key? key, required VoidCallback onRetry}) =>
      StatusView(
        key: key,
        icon: Icons.wifi_off_rounded,
        iconColor: AppColors.secondary,
        title: AppStrings.offlineTitle,
        message: AppStrings.offlineBody,
        actionLabel: AppStrings.retry,
        onAction: onRetry,
      );

  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.screenPadding),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 72, color: iconColor),
              const SizedBox(height: AppSizes.lg),
              Text(title, style: context.text.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.sm),
              Text(
                message,
                textAlign: TextAlign.center,
                style: context.text.bodyMedium?.copyWith(color: context.mutedText),
              ),
              const SizedBox(height: AppSizes.xl),
              AppButton(label: actionLabel, onPressed: onAction),
            ],
          ),
        ),
      ),
    );
  }
}
