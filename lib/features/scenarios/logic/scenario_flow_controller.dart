import 'package:flutter/foundation.dart';

import '../../../core/models/growth_gain.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/helpers/data_events.dart';
import '../data/scenario_repository.dart';
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
  ScenarioResult? _result;
  bool _isSubmitting = false;
  String? _error;

  int? get selectedIndex => _selectedIndex;
  int get confidence => _confidence;
  String get reason => _reason;
  String? get matter => _matter;
  bool get isSubmitting => _isSubmitting;
  String? get error => _error;

  ScenarioOption? get selectedOption =>
      _selectedIndex == null ? null : scenario.options[_selectedIndex!];

  /// The server's answer if it was saved, otherwise the text of the option.
  String get insight => _result?.insight ?? selectedOption?.insight ?? '';

  List<GrowthGain> get gains {
    final source = _result?.gains ?? selectedOption?.gains ?? const <GrowthGain>[];
    final list = [...source]
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

  /// Saves the answer on the server (points are added THERE) and keeps what it returns.
  /// Returns true when it worked; otherwise read [error].
  Future<bool> submit() async {
    if (_result != null) return true; // already saved
    final index = _selectedIndex;
    if (index == null || _isSubmitting) return false;

    _isSubmitting = true;
    _error = null;
    notifyListeners();
    try {
      final reason = _reason.trim();
      _result = await ScenarioRepository.instance.submitResponse(
        scenario: scenario,
        optionIndex: index,
        confidence: _confidence,
        reason: reason.isEmpty ? null : reason,
        matter: _matter,
      );
      _isSubmitting = false;
      notifyListeners();
      DataEvents.instance.changed(); // Home reloads its scores
      return true;
    } catch (e) {
      _error = ErrorHandler.handle(e).message;
      _isSubmitting = false;
      notifyListeners();
      return false;
    }
  }

  /// Tap the same chip again to un-select it.
  void toggleMatter(String value) {
    _matter = _matter == value ? null : value;
    notifyListeners();
  }
}
