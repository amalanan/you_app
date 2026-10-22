import 'dart:math' as math;

import 'package:flutter/material.dart';

abstract final class Breakpoints {
  static const double tablet = 600;

  /// Screen width the Figma design was made at.
  static const double designWidth = 390;

  /// Content never gets wider than this on big screens.
  static const double maxContentWidth = 480;
}

extension ResponsiveX on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  bool get isTablet => screenWidth >= Breakpoints.tablet;
  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;

  /// Scales a value from the design (390 wide) to the current screen,
  /// limited between 320 and 480 so nothing gets tiny or huge.
  double rs(double value) {
    final w = math.min(math.max(screenWidth, 320.0), Breakpoints.maxContentWidth);
    return value * (w / Breakpoints.designWidth);
  }
}
