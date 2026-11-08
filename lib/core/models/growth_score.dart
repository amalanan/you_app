import 'growth_type.dart';

/// A skill and its current score (0 - 100).
class GrowthScore {
  const GrowthScore(this.type, this.score);

  /// Where every skill starts, before any activity.
  /// Keep it equal to the "50" in the score formula of the database (schema.sql).
  static const startScore = 50;

  final GrowthType type;
  final int score;

  /// false until this skill has earned its first points: the screens then show
  /// "—" and an empty bar instead of a score that means nothing yet.
  bool get hasData => score > startScore;
}
