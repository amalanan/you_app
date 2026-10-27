import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../auth/data/auth_repository.dart';

/// Asks "Delete account?", deletes it, and goes back to Login.
/// Used by the Profile menu and by Privacy & Data.
Future<void> confirmAndDeleteAccount(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text(AppStrings.deleteAccountTitle),
      content: const Text(AppStrings.deleteAccountBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: TextButton.styleFrom(foregroundColor: AppColors.error),
          child: const Text(AppStrings.delete),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;

  try {
    await AuthRepository.instance.deleteAccount();
    if (context.mounted) context.go(AppRoutes.login);
  } catch (_) {
    if (context.mounted) context.showSnack(AppStrings.unknownError);
  }
}
