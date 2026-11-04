import 'package:flutter/foundation.dart';

import '../../../core/errors/error_handler.dart';
import '../../../core/helpers/data_events.dart';
import '../data/situation_insight.dart';
import '../data/situation_repository.dart';
import '../models/situation_models.dart';

/// Answers of ONE "Add situation" run. Created by the first page and passed
/// to the next ones as `extra`.
class SituationFlowController extends ChangeNotifier {
  String _whatHappened = '';
  SituationType? _type;
  final Set<Feeling> _feelings = {};
  String _action = '';
  int _confidence = 5;
  String _afterwards = '';
  String _lesson = '';
  SituationInsight? _insight;
  bool _isSubmitting = false;
  String? _error;
  bool _disposed = false;

  String get whatHappened => _whatHappened;
  SituationType? get type => _type;
  Set<Feeling> get feelings => Set.unmodifiable(_feelings);
  String get action => _action;
  int get confidence => _confidence;
  String get afterwards => _afterwards;
  String get lesson => _lesson;
  SituationInsight? get insight => _insight;
  bool get isSubmitting => _isSubmitting;
  String? get error => _error;

  bool get hasWhatHappened => _whatHappened.trim().isNotEmpty;
  bool get hasType => _type != null;
  bool get hasFeelings => _feelings.isNotEmpty;

  /// Only notifies when the text becomes empty / non-empty (enables Continue).
  void setWhatHappened(String value) {
    final before = hasWhatHappened;
    _whatHappened = value;
    if (before != hasWhatHappened) notifyListeners();
  }

  void selectType(SituationType value) {
    _type = value;
    notifyListeners();
  }

  void toggleFeeling(Feeling value) {
    if (!_feelings.remove(value)) _feelings.add(value);
    notifyListeners();
  }

  void setAction(String value) => _action = value;

  void setConfidence(int value) {
    _confidence = value;
    notifyListeners();
  }

  void setAfterwards(String value) => _afterwards = value;

  void setLesson(String value) => _lesson = value;

  /// Saves the situation on the server (it adds the points and decides what we
  /// noticed). Returns true when it worked; otherwise read [error].
  Future<bool> submit() async {
    if (_insight != null) return true; // already saved
    final type = _type;
    if (type == null || !hasWhatHappened || _isSubmitting) return false;

    _isSubmitting = true;
    _error = null;
    _notify();
    try {
      _insight = await SituationRepository.instance.submit(
        whatHappened: _whatHappened.trim(),
        type: type,
        feelings: feelings,
        action: _action.trim(),
        confidence: _confidence,
        afterwards: _afterwards.trim(),
        lesson: _lesson.trim(),
      );
      _isSubmitting = false;
      _notify();
      DataEvents.instance.changed(); // Home reloads its scores
      return true;
    } catch (e) {
      _error = ErrorHandler.handle(e).message;
      _isSubmitting = false;
      _notify();
      return false;
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
