import 'package:flutter/foundation.dart';

import '../../../core/models/growth_gain.dart';
import '../models/scenario.dart';

/// Answers of ONE run through a scenario (question -> confidence -> reflection).
/// It is created when a scenario is opened and passed to every step as `extra`.
class ScenarioFlowController extends ChangeNotifier {
  ScenarioFlowController(this.scenario);

  final Scenario scenario;

  int? _selectedIndex;
  int _confidence = 5;
  String _reason = '';
  String? _matter;

  int? get selectedIndex => _selectedIndex;
  int get confidence => _confidence;
  String get reason => _reason;
  String? get matter => _matter;

  ScenarioOption? get selectedOption =>
      _selectedIndex == null ? null : scenario.options[_selectedIndex!];

  String get insight => selectedOption?.insight ?? '';

  List<GrowthGain> get gains {
    final list = [...?selectedOption?.gains]
      ..removeWhere((g) => g.points <= 0)
      ..sort((a, b) => b.points.compareTo(a.points));
    return list;
  }

  void selectOption(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setConfidence(int value) {
    _confidence = value;
    notifyListeners();
  }

  // No notifyListeners: the text field already shows what was typed.
  void setReason(String value) => _reason = value;

  /// Tap the same chip again to un-select it.
  void toggleMatter(String value) {
    _matter = _matter == value ? null : value;
    notifyListeners();
  }
}
