import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/helpers/extensions.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.md, horizontal: 8),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Column(
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.text.bodySmall
                ?.copyWith(fontSize: 11, color: context.mutedText),
          ),
          const SizedBox(height: 6),
          Text('$value', style: context.text.headlineLarge),
        ],
      ),
    );
  }
}
