import 'package:flutter/material.dart';

/// Palette taken from the YOU design file.
abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF518D70); // green
  static const secondary = Color(0xFF7E7E92); // muted purple-grey
  static const accent = Color(0xFFA497A6);
  static const blush = Color(0xFFD6B7CF);
  static const mint = Color(0xFFC4CBC5);
  static const grey = Color(0xFF656665);
  static const logoPurple = Color(0xFF9B8FE0);
  static const white = Color(0xFFFFFFFF);

  // Light mode
  static const lightBackground = Color(0xFFFAFAF9);
  static const lightSurface = white;
  static const lightText = Color(0xFF2B2B2B);
  static const lightBorder = Color(0xFFE3E6E4);
  static const lightMutedText = Color(0xFF656665);
  static const lightHint = Color(0xFFB4B8B5);

  // Dark mode
  static const darkBackground = Color(0xFF2B2C2D);
  static const darkSurface = Color(0xFF363738);
  static const darkText = Color(0xFFF2F2F2);
  static const darkBorder = Color(0xFF4A4B4C);
  static const darkMutedText = Color(0xFFB5B6B6);
  static const darkHint = Color(0xFF8A8B8C);

  // Status
  static const error = Color(0xFFD64545);
  static const success = primary;
}
