import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Secondary text color that adapts to light / dark.
  Color get mutedText =>
      isDark ? AppColors.darkMutedText : AppColors.lightMutedText;

  Color get borderColor =>
      isDark ? AppColors.darkBorder : AppColors.lightBorder;

  void showSnack(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
