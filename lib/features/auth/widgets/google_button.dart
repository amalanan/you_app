import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_outlined_button.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.onPressed, this.isLoading = false});

  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppOutlinedButton(
      label: AppStrings.continueWithGoogle,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: Image.asset(AppAssets.google, width: 22, height: 22),
    );
  }
}
