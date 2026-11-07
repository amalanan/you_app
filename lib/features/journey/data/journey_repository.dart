import '../models/journey_data.dart';

/// Where the Journey numbers and activity come from.
abstract class JourneyRepository {
  /// Set once in main().
  static late JourneyRepository instance;

  Future<JourneyData> fetchJourney();
}
