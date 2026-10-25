import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';

/// Small rounded square with a softly tinted background.
class IconBox extends StatelessWidget {
  const IconBox({super.key, required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.iconBox,
      height: AppSizes.iconBox,
      decoration: BoxDecoration(
        color: color.withAlpha(38),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }
}
