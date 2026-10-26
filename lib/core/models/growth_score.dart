import 'growth_type.dart';

/// A skill and its current score (0 - 100).
class GrowthScore {
  const GrowthScore(this.type, this.score);

  final GrowthType type;
  final int score;
}
