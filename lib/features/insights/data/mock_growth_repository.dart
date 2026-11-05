import '../../../core/models/growth_score.dart';
import '../../../core/models/growth_type.dart';
import '../models/growth_detail.dart';
import 'growth_repository.dart';
import 'mock_insights.dart';

class MockGrowthRepository implements GrowthRepository {
  @override
  Future<List<GrowthScore>> fetchProfile() async => mockGrowthProfile;

  @override
  Future<GrowthDetail> fetchDetail(GrowthType type, GrowthRange range) async =>
      growthDetailFor(type, range);
}
