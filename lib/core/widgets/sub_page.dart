import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import 'responsive_center.dart';

/// Simple page with an AppBar (title + back arrow) and scrollable content.
class SubPage extends StatelessWidget {
  const SubPage({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: 560,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.screenPadding,
              AppSizes.sm,
              AppSizes.screenPadding,
              AppSizes.lg,
            ),
            child: SizedBox(width: double.infinity, child: child),
          ),
        ),
      ),
    );
  }
}
