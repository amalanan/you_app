import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/helpers/extensions.dart';
import '../models/journey_entry.dart';

/// Vertical timeline: purple dot + line on the side, day + what you did.
class JourneyTimeline extends StatelessWidget {
  const JourneyTimeline({super.key, required this.entries});

  final List<JourneyEntry> entries;

  IconData _icon(JourneyEntryType type) => switch (type) {
        JourneyEntryType.situation => Icons.add,
        JourneyEntryType.scenario => Icons.check,
        JourneyEntryType.reflection => Icons.edit,
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < entries.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 24,
                  child: Column(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _icon(entries[i].type),
                          size: 13,
                          color: AppColors.white,
                        ),
                      ),
                      if (i != entries.length - 1)
                        Expanded(
                          child: Container(width: 1.5, color: context.borderColor),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppSizes.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entries[i].dayLabel,
                          style: context.text.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          entries[i].text,
                          style: context.text.bodyMedium
                              ?.copyWith(color: context.mutedText),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
