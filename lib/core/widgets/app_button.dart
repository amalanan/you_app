import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.secondary = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  /// Purple button (design: "Next", "Create Account"). Default is green.
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    final color = secondary ? AppColors.secondary : AppColors.primary;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        // keep the brand color while loading instead of turning grey
        disabledBackgroundColor: color,
        disabledForegroundColor: AppColors.white,
      ),
      child: isLoading
          ? const SizedBox.square(
        dimension: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.2,
          color: AppColors.white,
        ),
      )
          : Text(label),
    );
  }
}
