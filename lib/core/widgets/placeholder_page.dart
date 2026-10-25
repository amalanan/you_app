import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../helpers/extensions.dart';

/// Temporary screen for pages that are not built yet.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          AppStrings.comingSoon,
          style: context.text.bodyMedium?.copyWith(color: context.mutedText),
        ),
      ),
    );
  }
}
