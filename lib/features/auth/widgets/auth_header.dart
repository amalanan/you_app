import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';

/// Back arrow (only if there is a page to go back to) + title + subtitle.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 56,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: context.canPop()
                ? IconButton(
                    onPressed: () => context.pop(),
                    padding: EdgeInsets.zero,
                    alignment: AlignmentDirectional.centerStart,
                    icon: const Icon(Icons.arrow_back),
                  )
                : null,
          ),
        ),
        SizedBox(height: context.rs(AppSizes.sm)),
        Text(
          title,
          style: context.text.headlineLarge?.copyWith(fontSize: context.rs(28)),
        ),
        const SizedBox(height: AppSizes.xs),
        Text(
          subtitle,
          style: context.text.bodyMedium?.copyWith(color: context.mutedText),
        ),
      ],
    );
  }
}
