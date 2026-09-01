import 'package:flutter/material.dart';

/// YOU App Design System Colors
class AppColors {
  AppColors._();

  // ==================== Basic Colors ====================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF101010);

  static const Color placeholders = Color(0xFFB8B8B8);
  static const Color border = Color(0xFFE0E1DF);

  static const Color icons = Color(0xFF656665);
  static const Color text = Color(0xFF414442);
  static const Color titles = Color(0xFF202321);
  static const Color hint = Color(0xFF858785);

  static const Color greyFillButton = Color(0xFFF1F2F0);

  // ==================== YOU App Main Palette ====================

  /// Primary - YOU Green
  static const Color primary = Color(0xFF518D70);

  static const Color primary40 = Color(0x66518D70);
  static const Color primary20 = Color(0x33518D70);
  static const Color primary10 = Color(0x1A518D70);
  static const Color primary5 = Color(0x0D518D70);

  /// Secondary - YOU Lavender Gray
  static const Color secondary = Color(0xFF7E7E92);

  static const Color secondary40 = Color(0x667E7E92);
  static const Color secondary20 = Color(0x337E7E92);
  static const Color secondary10 = Color(0x1A7E7E92);
  static const Color secondary5 = Color(0x0D7E7E92);

  /// Tertiary - YOU Mauve
  static const Color tertiary = Color(0xFFAA97A6);

  static const Color tertiary40 = Color(0x66AA97A6);
  static const Color tertiary20 = Color(0x33AA97A6);
  static const Color tertiary10 = Color(0x1AAA97A6);
  static const Color tertiary5 = Color(0x0DAA97A6);

  /// Neutral
  static const Color neutral = Color(0xFF656665);

  static const Color neutral40 = Color(0x66656665);
  static const Color neutral20 = Color(0x33656665);
  static const Color neutral10 = Color(0x1A656665);
  static const Color neutral5 = Color(0x0D656665);

  static const Color neutralWithoutTransparent = Color(0xFFD9DAD8);

  // ==================== Semantic / Status Colors ====================

  /// Success → Primary Green
  static const Color success = Color(0xFF518D70);
  static const Color success20 = Color(0x33518D70);
  static const Color success10 = Color(0x1A518D70);

  /// Warning
  static const Color warning = Color(0xFFD6A84F);
  static const Color warning20 = Color(0x33D6A84F);
  static const Color warning10 = Color(0x1AD6A84F);

  /// Error
  /// Based on the red used for destructive actions in the design.
  static const Color error = Color(0xFFC62828);
  static const Color error20 = Color(0x33C62828);
  static const Color error10 = Color(0x1AC62828);

  // ==================== Light Theme ====================

  static AppColorScheme light = AppColorScheme(
    background: Color(0xFFF4F4F2),
    surface: Color(0xFFFAFAF8),

    titles: titles,
    text: text,
    hint: hint,
    placeholders: placeholders,
    border: border,
    icons: icons,
    greyFillButton: greyFillButton,

    // Primary
    primary: primary,
    primary40: primary40,
    primary20: primary20,
    primary10: primary10,
    primary5: primary5,

    // Secondary
    secondary: secondary,
    secondary40: secondary40,
    secondary20: secondary20,
    secondary10: secondary10,
    secondary5: secondary5,

    // Tertiary
    tertiary: tertiary,
    tertiary40: tertiary40,
    tertiary20: tertiary20,
    tertiary10: tertiary10,
    tertiary5: tertiary5,

    // Success
    success: success,
    success20: success20,
    success10: success10,

    // Warning
    warning: warning,
    warning20: warning20,
    warning10: warning10,

    // Error
    error: error,
    error20: error20,
    error10: error10,

    // Neutral
    neutral: neutral,
    neutral40: neutral40,
    neutral20: neutral20,
    neutral10: neutral10,
    neutral5: neutral5,
    neutralWithoutTransparent: neutralWithoutTransparent,
  );

  // ==================== Dark Theme ====================

  static AppColorScheme dark = AppColorScheme(
    background: Color(0xFF171918),
    surface: Color(0xFF222523),

    titles: Color(0xFFF1F2EF),
    text: Color(0xFFD0D2CF),
    hint: Color(0xFF9EA19E),
    placeholders: Color(0xFF777A77),
    border: Color(0xFF3B3E3B),
    icons: Color(0xFFB8BBB8),
    greyFillButton: Color(0xFF2C302D),

    // Primary
    primary: Color(0xFF6FA98A),
    primary40: Color(0x666FA98A),
    primary20: Color(0x336FA98A),
    primary10: Color(0x1A6FA98A),
    primary5: Color(0x0D6FA98A),

    // Secondary
    secondary: Color(0xFF9696AA),
    secondary40: Color(0x669696AA),
    secondary20: Color(0x339696AA),
    secondary10: Color(0x1A9696AA),
    secondary5: Color(0x0D9696AA),

    // Tertiary
    tertiary: Color(0xFFBDAAB9),
    tertiary40: Color(0x66BDAAB9),
    tertiary20: Color(0x33BDAAB9),
    tertiary10: Color(0x1ABDAAB9),
    tertiary5: Color(0x0DBDAAB9),

    // Success
    success: Color(0xFF6FA98A),
    success20: Color(0x336FA98A),
    success10: Color(0x1A6FA98A),

    // Warning
    warning: Color(0xFFE0B968),
    warning20: Color(0x33E0B968),
    warning10: Color(0x1AE0B968),

    // Error
    error: Color(0xFFEF5350),
    error20: Color(0x33EF5350),
    error10: Color(0x1AEF5350),

    // Neutral
    neutral: Color(0xFFA5A8A5),
    neutral40: Color(0x66A5A8A5),
    neutral20: Color(0x33A5A8A5),
    neutral10: Color(0x1AA5A8A5),
    neutral5: Color(0x0DA5A8A5),
    neutralWithoutTransparent: Color(0xFF3A3D3A),
  );
}


/// Theme-aware color scheme for YOU App
class AppColorScheme {
  final Color background;
  final Color surface;

  final Color titles;
  final Color text;
  final Color hint;
  final Color placeholders;
  final Color border;
  final Color icons;
  final Color greyFillButton;

  // ==================== Primary ====================

  final Color primary;
  final Color primary40;
  final Color primary20;
  final Color primary10;
  final Color primary5;

  // ==================== Secondary ====================

  final Color secondary;
  final Color secondary40;
  final Color secondary20;
  final Color secondary10;
  final Color secondary5;

  // ==================== Tertiary ====================

  final Color tertiary;
  final Color tertiary40;
  final Color tertiary20;
  final Color tertiary10;
  final Color tertiary5;

  // ==================== Status Colors ====================

  final Color success;
  final Color success20;
  final Color success10;

  final Color warning;
  final Color warning20;
  final Color warning10;

  final Color error;
  final Color error20;
  final Color error10;

  // ==================== Neutral ====================

  final Color neutral;
  final Color neutral40;
  final Color neutral20;
  final Color neutral10;
  final Color neutral5;
  final Color neutralWithoutTransparent;

  AppColorScheme({
    required this.background,
    required this.surface,

    required this.titles,
    required this.text,
    required this.hint,
    required this.placeholders,
    required this.border,
    required this.icons,
    required this.greyFillButton,

    required this.primary,
    required this.primary40,
    required this.primary20,
    required this.primary10,
    required this.primary5,

    required this.secondary,
    required this.secondary40,
    required this.secondary20,
    required this.secondary10,
    required this.secondary5,

    required this.tertiary,
    required this.tertiary40,
    required this.tertiary20,
    required this.tertiary10,
    required this.tertiary5,

    required this.success,
    required this.success20,
    required this.success10,

    required this.warning,
    required this.warning20,
    required this.warning10,

    required this.error,
    required this.error20,
    required this.error10,

    required this.neutral,
    required this.neutral40,
    required this.neutral20,
    required this.neutral10,
    required this.neutral5,
    required this.neutralWithoutTransparent,
  });
}


/// Extension to access YOU colors through BuildContext.
///
/// Example:
/// context.colors.primary
/// context.colors.secondary
/// context.colors.tertiary
/// context.colors.titles
/// context.colors.text
extension AppColorsExtension on BuildContext {
  AppColorScheme get colors {
    final brightness = Theme.of(this).brightness;

    return brightness == Brightness.light
        ? AppColors.light
        : AppColors.dark;
  }
}