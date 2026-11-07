import '../models/growth_detail.dart';
import 'insights_repository.dart';
import 'mock_insights.dart';

class MockInsightsRepository implements InsightsRepository {
  @override
  Future<List<InsightItem>> fetchInsights() async => mockInsights;
}
