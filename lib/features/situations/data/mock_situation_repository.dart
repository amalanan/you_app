import '../models/situation_models.dart';
import 'situation_insight.dart';
import 'situation_repository.dart';

/// Used while Supabase is not set up: nothing is saved, the rules run in the app.
class MockSituationRepository implements SituationRepository {
  @override
  Future<SituationInsight> submit({
    required String whatHappened,
    required SituationType type,
    required Set<Feeling> feelings,
    required String action,
    required int confidence,
    required String afterwards,
    required String lesson,
  }) async {
    return localInsight(
      type: type,
      feelings: feelings,
      confidence: confidence,
      afterwards: afterwards,
      lesson: lesson,
    );
  }
}
