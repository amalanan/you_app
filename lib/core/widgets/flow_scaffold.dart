import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_sizes.dart';
import '../helpers/extensions.dart';
import 'responsive_center.dart';

/// Shared layout of the multi-step flows (scenario, add situation):
/// back arrow (+ optional "1 of 3") on top,
/// scrollable content, and the main button pinned at the bottom.
class FlowScaffold extends StatelessWidget {
  const FlowScaffold({
    super.key,
    this.stepText,
    required this.child,
    required this.button,
    this.label,
  });

  final String? stepText;
  final String? label;
  final Widget child;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: ResponsiveCenter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.sm,
                    AppSizes.sm,
                    AppSizes.screenPadding,
                    0,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      if (label != null)
                        Text(
                          label!,
                          style: context.text.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                      const Spacer(),
                      if (stepText != null)
                        Text(
                          stepText!,
                          style: context.text.bodySmall
                              ?.copyWith(color: context.mutedText),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSizes.screenPadding,
                      AppSizes.md,
                      AppSizes.screenPadding,
                      AppSizes.md,
                    ),
                    child: SizedBox(width: double.infinity, child: child),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.screenPadding,
                    AppSizes.sm,
                    AppSizes.screenPadding,
                    AppSizes.lg,
                  ),
                  child: button,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
