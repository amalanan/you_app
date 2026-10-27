import 'package:flutter/material.dart';

import '../helpers/responsive.dart';

/// Centers [child] horizontally (top aligned) and limits its width on tablets / landscape.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = Breakpoints.maxContentWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    // topCenter, NOT center: a short page (like a settings page) must start at
    // the top instead of floating in the middle of the screen.
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
