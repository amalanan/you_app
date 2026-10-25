import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

/// The skills the app tracks. Used by Home and by the scenario result.
enum GrowthType { decisionMaking, learning, selfAwareness }

extension GrowthTypeX on GrowthType {
  String get label => switch (this) {
        GrowthType.decisionMaking => AppStrings.decisionMaking,
        GrowthType.learning => AppStrings.learning,
        GrowthType.selfAwareness => AppStrings.selfAwareness,
      };

  IconData get icon => switch (this) {
        GrowthType.decisionMaking => Icons.balance,
        GrowthType.learning => Icons.psychology_outlined,
        GrowthType.selfAwareness => Icons.self_improvement,
      };

  Color get iconColor => switch (this) {
        GrowthType.selfAwareness => AppColors.primary,
        _ => AppColors.secondary,
      };

  Color get barColor => switch (this) {
        GrowthType.selfAwareness => AppColors.warm,
        _ => AppColors.secondary,
      };
}
