import '../../../core/models/growth_score.dart';
import '../../../core/models/growth_type.dart';
import '../models/growth_detail.dart';

/// Where the growth numbers come from (mock now, Supabase when it is set up).
abstract class GrowthRepository {
  /// Set once in main().
  static late GrowthRepository instance;

  /// The score of every skill ("My Growth").
  Future<List<GrowthScore>> fetchProfile();

  /// One skill over time ("Learning": chart, previous score, her own lessons).
  Future<GrowthDetail> fetchDetail(GrowthType type, GrowthRange range);
}
