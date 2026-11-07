import '../models/journey_data.dart';
import 'journey_repository.dart';
import 'mock_journey.dart';

class MockJourneyRepository implements JourneyRepository {
  @override
  Future<JourneyData> fetchJourney() async => const JourneyData(
        day: mockDay,
        reflections: mockReflections,
        situations: mockSituations,
        scenarios: mockScenarios,
        entries: mockJourney,
      );
}
