import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  // ==================== Themes ====================

  static ThemeData get lightTheme =>
      _buildTheme(brightness: Brightness.light, colors: AppColors.light);

  static ThemeData get darkTheme =>
      _buildTheme(brightness: Brightness.dark, colors: AppColors.dark);

  // ==================== Build Theme ====================

  static ThemeData _buildTheme({
    required Brightness brightness,
    required AppColorScheme colors,
  }) {
    final bool isDark = brightness == Brightness.dark;

    OutlineInputBorder buildBorder(Color color) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        borderSide: BorderSide(color: color, width: 1),
      );
    }

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: brightness,

      // ==================== Actions ====================
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) {
          return Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: colors.icons,
          );
        },
      ),

      // ==================== List Tile ====================
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        dense: true,
        minVerticalPadding: 0,
        visualDensity: VisualDensity.compact,
      ),

      // ==================== Color Scheme ====================
      colorScheme: ColorScheme(
        brightness: brightness,

        // Primary
        primary: colors.primary,
        onPrimary: AppColors.white,
        primaryContainer: colors.primary40,
        onPrimaryContainer: isDark ? AppColors.white : AppColors.black,

        // Secondary
        secondary: colors.secondary,
        onSecondary: AppColors.white,
        secondaryContainer: colors.secondary40,
        onSecondaryContainer: isDark ? AppColors.white : AppColors.black,

        // Tertiary
        tertiary: colors.tertiary,
        onTertiary: AppColors.white,

        // Error
        error: colors.error,
        onError: AppColors.white,

        // Surface
        surface: colors.surface,
        onSurface: colors.titles,

        // Surface Variant
        surfaceContainerHighest: colors.greyFillButton,
        onSurfaceVariant: colors.text,

        // Borders
        outline: colors.border,
        outlineVariant: colors.border,

        // Effects
        shadow: isDark ? Colors.black : Colors.black.withValues(alpha: 0.1),

        scrim: Colors.black.withValues(alpha: 0.6),

        // Inverse
        inverseSurface: isDark ? AppColors.white : AppColors.black,

        onInverseSurface: isDark ? AppColors.black : AppColors.white,

        inversePrimary: isDark ? AppColors.primary : AppColors.primary,
      ),

      // ==================== General ====================
      scaffoldBackgroundColor: colors.background,

      // ==================== Components ====================
      appBarTheme: _buildAppbarTheme(colors),

      textTheme: _buildTextTheme(colors),

      inputDecorationTheme: _buildInputDecTheme(colors, buildBorder),

      elevatedButtonTheme: _buildElevatedButtonTheme(colors),

      textButtonTheme: _buildTextButtonTheme(colors),

      outlinedButtonTheme: _buildOutlinedButtonTheme(colors),

      cardTheme: _buildCardTheme(colors, isDark),

      iconTheme: IconThemeData(color: colors.icons, size: 24),

      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 1,
        space: 1,
      ),

      bottomNavigationBarTheme: _buildBottomNavbarTheme(colors),

      chipTheme: _buildChipTheme(colors),

      dialogTheme: _buildDialogTheme(colors),

      bottomSheetTheme: _buildBottomSheetTheme(colors),

      snackBarTheme: _buildSnackbarTheme(isDark, colors),
    );
  }

  // ==================== SnackBar ====================

  static SnackBarThemeData _buildSnackbarTheme(
    bool isDark,
    AppColorScheme colors,
  ) {
    return SnackBarThemeData(
      backgroundColor: isDark ? colors.greyFillButton : AppColors.black,

      contentTextStyle: AppTypography.body14Regular.copyWith(
        color: AppColors.white,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),

      behavior: SnackBarBehavior.floating,
    );
  }

  // ==================== Bottom Sheet ====================

  static BottomSheetThemeData _buildBottomSheetTheme(AppColorScheme colors) {
    return BottomSheetThemeData(
      backgroundColor: colors.surface,
      modalBackgroundColor: colors.surface,
      elevation: 0,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  // ==================== Dialog ====================

  static DialogThemeData _buildDialogTheme(AppColorScheme colors) {
    return DialogThemeData(
      backgroundColor: colors.surface,
      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),

      titleTextStyle: AppTypography.h2_20SemiBold.copyWith(
        color: colors.titles,
      ),

      contentTextStyle: AppTypography.body16Regular.copyWith(
        color: colors.text,
      ),
    );
  }

  // ==================== Chip ====================

  static ChipThemeData _buildChipTheme(AppColorScheme colors) {
    return ChipThemeData(
      backgroundColor: colors.neutralWithoutTransparent,

      selectedColor: colors.primary40,

      labelStyle: AppTypography.label12Regular.copyWith(color: colors.neutral),

      secondaryLabelStyle: AppTypography.body14Regular.copyWith(
        color: colors.text,
      ),

      labelPadding: EdgeInsets.zero,

      side: BorderSide.none,

      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingS,
        vertical: AppSizes.paddingXXS,
      ),

      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(AppSizes.paddingXS),
      ),
    );
  }

  // ==================== Bottom Navigation ====================

  static BottomNavigationBarThemeData _buildBottomNavbarTheme(
    AppColorScheme colors,
  ) {
    return BottomNavigationBarThemeData(
      backgroundColor: colors.surface,

      selectedItemColor: colors.primary,

      unselectedItemColor: colors.icons,

      selectedLabelStyle: AppTypography.label10Medium,

      unselectedLabelStyle: AppTypography.label10Regular,

      type: BottomNavigationBarType.fixed,

      elevation: 8,
    );
  }

  // ==================== Card ====================

  static CardThemeData _buildCardTheme(AppColorScheme colors, bool isDark) {
    return CardThemeData(
      // Important:
      // Do not use AppColors.white here because
      // it breaks the dark theme.
      color: colors.surface,

      elevation: 0,

      shadowColor: Colors.black.withValues(alpha: isDark ? 0.25 : 0.1),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      margin: const EdgeInsets.all(8),
    );
  }

  // ==================== Outlined Button ====================

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
    AppColorScheme colors,
  ) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.neutral,

        side: BorderSide(color: colors.neutral),

        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingL,
          vertical: AppSizes.paddingM,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),

        textStyle: AppTypography.buttonBig,
      ),
    );
  }

  // ==================== Text Button ====================

  static TextButtonThemeData _buildTextButtonTheme(AppColorScheme colors) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colors.hint,

        padding: EdgeInsets.zero,

        textStyle: AppTypography.buttonSmall,
      ),
    );
  }

  // ==================== Elevated Button ====================

  static ElevatedButtonThemeData _buildElevatedButtonTheme(
    AppColorScheme colors,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,

        foregroundColor: AppColors.white,

        elevation: 0,

        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingL,
          vertical: AppSizes.paddingM,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),

        textStyle: AppTypography.buttonBig,
      ),
    );
  }

  // ==================== Input Decoration ====================

  static InputDecorationTheme _buildInputDecTheme(
    AppColorScheme colors,
    OutlineInputBorder Function(Color color) buildBorder,
  ) {
    return InputDecorationTheme(
      filled: true,

      fillColor: colors.surface,

      hintStyle: AppTypography.body16Regular.copyWith(
        color: colors.placeholders,
      ),

      labelStyle: AppTypography.body14Regular.copyWith(color: colors.text),

      contentPadding: const EdgeInsets.all(AppSizes.paddingM),

      helperStyle: AppTypography.label12Regular.copyWith(color: colors.icons),

      border: buildBorder(colors.border),

      enabledBorder: buildBorder(colors.border),

      focusedBorder: buildBorder(colors.primary),

      errorBorder: buildBorder(colors.error),

      focusedErrorBorder: buildBorder(colors.error),
    );
  }

  // ==================== Text Theme ====================

  static TextTheme _buildTextTheme(AppColorScheme colors) {
    return TextTheme(
      displayLarge: AppTypography.h2_20SemiBold.copyWith(color: colors.titles),

      displayMedium: AppTypography.h2_20Medium.copyWith(color: colors.titles),

      displaySmall: AppTypography.h2_20Regular.copyWith(color: colors.titles),

      headlineLarge: AppTypography.h2_20SemiBold.copyWith(color: colors.titles),

      headlineMedium: AppTypography.h2_20Medium.copyWith(color: colors.titles),

      headlineSmall: AppTypography.h3_18Medium.copyWith(color: colors.titles),

      titleLarge: AppTypography.h3_18Medium.copyWith(color: colors.titles),

      titleMedium: AppTypography.h2_20Medium.copyWith(color: colors.titles),

      titleSmall: AppTypography.body16Medium.copyWith(color: colors.titles),

      bodyLarge: AppTypography.h3_18Regular.copyWith(color: colors.text),

      bodyMedium: AppTypography.body16Regular.copyWith(color: colors.text),

      bodySmall: AppTypography.body14Regular.copyWith(color: colors.text),

      labelLarge: AppTypography.label12Regular.copyWith(color: colors.hint),

      labelMedium: AppTypography.label10Regular.copyWith(color: colors.hint),
    );
  }

  // ==================== AppBar ====================

  static AppBarTheme _buildAppbarTheme(AppColorScheme colors) {
    return AppBarTheme(
      backgroundColor: colors.surface,

      foregroundColor: colors.titles,

      elevation: 0,

      centerTitle: true,

      titleTextStyle: AppTypography.h2_20Medium.copyWith(color: colors.titles),

      toolbarHeight: 80,

      iconTheme: IconThemeData(color: colors.icons),
    );
  }
}
