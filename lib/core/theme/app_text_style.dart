import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static const fontFamily = 'Poppins';

  static TextTheme build(TextTheme base, Color color) {
    final t = base.apply(
      fontFamily: fontFamily,
      bodyColor: color,
      displayColor: color,
    );

    return t.copyWith(
      displayLarge: t.displayLarge?.copyWith(
        fontSize: 56,
        fontWeight: FontWeight.w300,
        letterSpacing: 2,
        height: 1.1,
      ),
      headlineLarge:
      t.headlineLarge?.copyWith(fontSize: 24, fontWeight: FontWeight.w700),
      headlineMedium:
      t.headlineMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: t.bodyLarge?.copyWith(fontSize: 16),
      bodyMedium: t.bodyMedium?.copyWith(fontSize: 14),
      bodySmall: t.bodySmall?.copyWith(fontSize: 12),
      labelLarge:
      t.labelLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
