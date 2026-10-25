import 'package:flutter/foundation.dart';

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

  String get whatHappened => _whatHappened;
  SituationType? get type => _type;
  Set<Feeling> get feelings => Set.unmodifiable(_feelings);
  String get action => _action;
  int get confidence => _confidence;
  String get afterwards => _afterwards;
  String get lesson => _lesson;

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
}
