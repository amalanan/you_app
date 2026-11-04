import '../models/home_data.dart';
import 'home_repository.dart';
import 'mock_home_data.dart';

class MockHomeRepository implements HomeRepository {
  @override
  Future<HomeData> fetchHome() async => mockHomeData;
}
