import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../auth/data/auth_repository.dart';

/// Placeholder: shows who is signed in + a sign out button.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthRepository.instance;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hi ${auth.currentName ?? ''}'.trim(),
                    style: context.text.headlineLarge,
                  ),
                  if (auth.currentEmail != null) ...[
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      auth.currentEmail!,
                      style: context.text.bodyMedium
                          ?.copyWith(color: context.mutedText),
                    ),
                  ],
                  const SizedBox(height: AppSizes.lg),
                  AppButton(
                    label: AppStrings.signOut,
                    secondary: true,
                    onPressed: () async {
                      await auth.signOut();
                      if (context.mounted) context.go(AppRoutes.login);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
