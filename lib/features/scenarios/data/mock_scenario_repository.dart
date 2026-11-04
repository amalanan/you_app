import '../models/scenario.dart';
import 'mock_scenarios.dart';
import 'scenario_repository.dart';

/// Used while Supabase is not set up: the scenarios are in the app and the
/// answer is "saved" nowhere.
class MockScenarioRepository implements ScenarioRepository {
  @override
  Future<List<Scenario>> fetchScenarios() async => mockScenarios;

  @override
  Future<ScenarioResult> submitResponse({
    required Scenario scenario,
    required int optionIndex,
    required int confidence,
    String? reason,
    String? matter,
  }) async {
    final option = scenario.options[optionIndex];
    return ScenarioResult(insight: option.insight, gains: option.gains);
  }
}
