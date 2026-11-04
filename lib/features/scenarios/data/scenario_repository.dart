import '../models/scenario.dart';

/// Where scenarios come from and where answers go.
/// Screens only use this class, so the source can change (mock / Supabase).
abstract class ScenarioRepository {
  /// Set once in main().
  static late ScenarioRepository instance;

  Future<List<Scenario>> fetchScenarios();

  /// Saves the answer. The SERVER adds the points and returns the insight.
  Future<ScenarioResult> submitResponse({
    required Scenario scenario,
    required int optionIndex,
    required int confidence,
    String? reason,
    String? matter,
  });
}
