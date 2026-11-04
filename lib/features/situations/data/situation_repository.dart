import '../models/situation_models.dart';
import 'situation_insight.dart';

/// Where situations are saved. Screens only use this class.
abstract class SituationRepository {
  /// Set once in main().
  static late SituationRepository instance;

  /// Saves the situation. The SERVER decides what we noticed and adds the points.
  Future<SituationInsight> submit({
    required String whatHappened,
    required SituationType type,
    required Set<Feeling> feelings,
    required String action,
    required int confidence,
    required String afterwards,
    required String lesson,
  });
}
