
import '../../../../core/constants/app_strings.dart';

enum GrowthRange { week, month, quarter }

extension GrowthRangeX on GrowthRange {
  String get label => switch (this) {
        GrowthRange.week => AppStrings.range7,
        GrowthRange.month => AppStrings.range30,
        GrowthRange.quarter => AppStrings.range3m,
      };
}

class GrowthPoint {
  const GrowthPoint(this.label, this.value);

  final String label;
  final int value;
}

class GrowthDetail {
  const GrowthDetail({
    required this.current,
    required this.previous,
    required this.points,
    required this.meaning,
    required this.experiences,
  });

  final int current;
  final int previous;
  final List<GrowthPoint> points;
  final String meaning;
  final List<String> experiences;

  int get change => current - previous;
}

enum InsightKind { improvement, pattern, explore }

class InsightItem {
  const InsightItem({required this.kind, required this.title, required this.body});

  final InsightKind kind;
  final String title;
  final String body;
}
