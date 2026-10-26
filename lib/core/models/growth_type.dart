import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

/// The skills the app tracks (Home, scenario result, My Growth).
enum GrowthType {
  decisionMaking,
  learning,
  selfAwareness,
  flexibility,
  adaptation,
  consistency,
}

extension GrowthTypeX on GrowthType {
  String get label => switch (this) {
    GrowthType.decisionMaking => AppStrings.decisionMaking,
    GrowthType.learning => AppStrings.learning,
    GrowthType.selfAwareness => AppStrings.selfAwareness,
    GrowthType.flexibility => AppStrings.flexibility,
    GrowthType.adaptation => AppStrings.adaptation,
    GrowthType.consistency => AppStrings.consistency,
  };

  IconData get icon => switch (this) {
    GrowthType.decisionMaking => Icons.balance,
    GrowthType.learning => Icons.psychology_outlined,
    GrowthType.selfAwareness => Icons.self_improvement,
    GrowthType.flexibility => Icons.sync_alt,
    GrowthType.adaptation => Icons.autorenew,
    GrowthType.consistency => Icons.timeline,
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
