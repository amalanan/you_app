import '../constants/app_strings.dart';

abstract final class Validators {
  static String? required(String? v) =>
      (v == null || v.trim().isEmpty) ? AppStrings.fieldRequired : null;

  static String? email(String? v) {
    if (required(v) != null) return AppStrings.fieldRequired;
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v!.trim());
    return ok ? null : AppStrings.invalidEmail;
  }

  static String? password(String? v) {
    if (required(v) != null) return AppStrings.fieldRequired;
    return v!.length >= 8 ? null : AppStrings.shortPassword;
  }

  static String? Function(String?) confirmPassword(
    String Function() original,
  ) => (v) => v == original() ? null : AppStrings.passwordsDontMatch;

  static String? situationDescription(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return AppStrings.fieldRequired;
    }

    final compact = text.replaceAll(RegExp(r'\s+'), '');

    // Numbers only
    if (RegExp(r'^[0-9٠-٩]+$').hasMatch(compact)) {
      return AppStrings.situationNumbersOnly;
    }

    // Repeated characters: aaaaaaaa
    if (RegExp(r'^(.)\1{5,}$').hasMatch(compact)) {
      return AppStrings.situationInvalidText;
    }

    // Long English text without vowels: JFJHFKJFKLF
    if (RegExp(r'^[a-zA-Z]{8,}$').hasMatch(compact) &&
        !RegExp(r'[aeiouAEIOU]').hasMatch(compact)) {
      return AppStrings.situationInvalidText;
    }
    // Suspicious English keyboard-like text
    if (RegExp(r'^[a-zA-Z]{10,}$').hasMatch(compact)) {
      final hasVowels = RegExp(r'[aeiouAEIOU]').hasMatch(compact);
      final uniqueLetters = compact.toLowerCase().split('').toSet().length;
      final vowelCount = RegExp(r'[aeiouAEIOU]').allMatches(compact).length;

      if (!hasVowels || uniqueLetters <= 4 || vowelCount == 0) {
        return AppStrings.situationInvalidText;
      }
    }
    return null;
  }
}
