import '../models/home_data.dart';

/// Where the Home numbers come from (mock now, Supabase when it is set up).
abstract class HomeRepository {
  /// Set once in main().
  static late HomeRepository instance;

  Future<HomeData> fetchHome();
}
