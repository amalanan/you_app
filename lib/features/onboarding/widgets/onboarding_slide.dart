import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../models/onboarding_item.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({super.key, required this.item});

  final OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    final texts = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: context.text.headlineLarge?.copyWith(
            fontSize: context.rs(30),
            height: 1.25,
          ),
        ),
        const SizedBox(height: AppSizes.md),
        Text(
          item.body,
          style: context.text.bodyLarge?.copyWith(
            color: context.mutedText,
            height: 1.6,
          ),
        ),
      ],
    );

    final image = Image.asset(
      item.image,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
      child: LayoutBuilder(
        builder: (context, c) {
          // Tablets and phones in landscape: text on one side, image on the other.
          if (c.maxWidth >= Breakpoints.tablet) {
            return Row(
              children: [
                Expanded(child: Center(child: texts)),
                const SizedBox(width: AppSizes.xl),
                Expanded(child: Center(child: image)),
              ],
            );
          }
          // Phones (portrait): text on top, image fills the rest.
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.lg),
              texts,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.lg),
                  child: Center(child: image),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
