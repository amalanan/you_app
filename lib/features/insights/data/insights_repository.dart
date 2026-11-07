import '../models/growth_detail.dart';

/// Where the 3 insight cards come from.
abstract class InsightsRepository {
  /// Set once in main().
  static late InsightsRepository instance;

  /// Can be empty when there is not enough data yet.
  Future<List<InsightItem>> fetchInsights();
}
