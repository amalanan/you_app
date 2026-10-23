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

  static String? Function(String?) confirmPassword(String Function() original) =>
          (v) => v == original() ? null : AppStrings.passwordsDontMatch;
}
