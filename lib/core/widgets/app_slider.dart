import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../helpers/extensions.dart';

/// 1-10 slider with the numbers under the track and two end labels.
/// Look comes from the slider theme in app_theme.dart.
class AppSlider extends StatelessWidget {
  const AppSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 10,
    this.minLabel,
    this.maxLabel,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final String? minLabel;
  final String? maxLabel;

  @override
  Widget build(BuildContext context) {
    final small = context.text.bodySmall?.copyWith(
      fontSize: 11,
      color: context.mutedText,
    );

    return Column(
      children: [
        Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          onChanged: (v) => onChanged(v.round()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [for (var i = min; i <= max; i++) Text('$i', style: small)],
          ),
        ),
        const SizedBox(height: AppSizes.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _EndLabel(number: min, label: minLabel, crossAxis: CrossAxisAlignment.start),
              _EndLabel(number: max, label: maxLabel, crossAxis: CrossAxisAlignment.end),
            ],
          ),
        ),
      ],
    );
  }
}

class _EndLabel extends StatelessWidget {
  const _EndLabel({required this.number, required this.crossAxis, this.label});

  final int number;
  final String? label;
  final CrossAxisAlignment crossAxis;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxis,
      children: [
        Text('$number', style: context.text.bodySmall),
        if (label != null)
          Text(
            label!,
            style: context.text.bodySmall?.copyWith(color: context.mutedText),
          ),
      ],
    );
  }
}
