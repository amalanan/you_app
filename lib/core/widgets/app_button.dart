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
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: secondary
          ? ElevatedButton.styleFrom(backgroundColor: AppColors.secondary)
          : null,
      child: isLoading
          ? const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.white,
              ),
            )
          : Text(label),
    );
  }
}
