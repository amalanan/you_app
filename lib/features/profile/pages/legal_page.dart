import 'package:flutter/material.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/widgets/sub_page.dart';
import '../data/legal_content.dart';

/// Used for both Terms of Use and Privacy Policy.
class LegalPage extends StatelessWidget {
  const LegalPage({super.key, required this.title, required this.sections});

  final String title;
  final List<LegalSection> sections;

  @override
  Widget build(BuildContext context) {
    return SubPage(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            legalUpdated,
            style: context.text.bodySmall?.copyWith(color: context.mutedText),
          ),
          const SizedBox(height: 20),
          for (final s in sections) ...[
            Text(
              s.heading,
              style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              s.body,
              style: context.text.bodyMedium
                  ?.copyWith(color: context.mutedText, height: 1.6),
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}
