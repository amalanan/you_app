
import '../../situations/models/situation_models.dart';

enum ReflectionKind { situation, scenario }

/// A text stored in the database as {"ar": "...", "en": "..."}.
class LocalizedValue {
  const LocalizedValue(this._values);

  final Map<String, String> _values;

  /// Returns null when [json] is not a map or holds no text.
  static LocalizedValue? fromJson(Object? json) {
    if (json is! Map) return null;
    final values = <String, String>{};
    json.forEach((key, value) {
      if (key is String && value is String && value.trim().isNotEmpty) {
        values[key] = value;
      }
    });
    return values.isEmpty ? null : LocalizedValue(values);
  }

  /// The requested language, then English, then Arabic, then anything else.
  String resolve(String languageCode) =>
      _values[languageCode] ??
          _values['en'] ??
          _values['ar'] ??
          _values.values.first;
}

/// One row of the reflection_entries view: a situation or a scenario answer.
/// Fields that do not apply to a kind are null (or empty for [feelings]).
class ReflectionEntry {
  const ReflectionEntry({
    required this.kind,
    required this.id,
    required this.createdAt,
    this.confidence,
    this.whatHappened,
    this.type,
    this.feelings = const [],
    this.action,
    this.afterwards,
    this.lesson,
    this.reason,
    this.matter,
    this.scenarioId,
    this.optionId,
    this.scenarioTitle,
    this.prompt,
    this.chosenOption,
    this.insight,
  });

  final ReflectionKind kind;
  final String id;
  final DateTime createdAt;
  final int? confidence;

  // Situation (written by the user)
  final String? whatHappened;
  final SituationType? type;
  final List<Feeling> feelings;
  final String? action;
  final String? afterwards;
  final String? lesson;

  // Scenario answer
  final String? reason; // written by the user
  final String? matter;
  final String? scenarioId;
  final String? optionId;
  final LocalizedValue? scenarioTitle;
  final LocalizedValue? prompt;
  final LocalizedValue? chosenOption;
  final LocalizedValue? insight;

  bool get isSituation => kind == ReflectionKind.situation;
  bool get isScenario => kind == ReflectionKind.scenario;

  factory ReflectionEntry.fromMap(Map<String, dynamic> map) {
    return ReflectionEntry(
      kind: map['kind'] == 'scenario'
          ? ReflectionKind.scenario
          : ReflectionKind.situation,
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String).toLocal(),
      confidence: (map['confidence'] as num?)?.toInt(),
      whatHappened: _text(map['what_happened']),
      type: _typeFrom(map['type']),
      feelings: _feelingsFrom(map['feelings']),
      action: _text(map['action']),
      afterwards: _text(map['afterwards']),
      lesson: _text(map['lesson']),
      reason: _text(map['reason']),
      matter: _text(map['matter']),
      scenarioId: map['scenario_id'] as String?,
      optionId: map['option_id'] as String?,
      scenarioTitle: LocalizedValue.fromJson(map['scenario_title']),
      prompt: LocalizedValue.fromJson(map['prompt']),
      chosenOption: LocalizedValue.fromJson(map['chosen_option']),
      insight: LocalizedValue.fromJson(map['insight']),
    );
  }

  /// Keeps the user's text exactly as stored; blank becomes null.
  static String? _text(Object? value) =>
      value is String && value.trim().isNotEmpty ? value : null;

  static SituationType? _typeFrom(Object? value) {
    if (value is! String) return null;
    for (final t in SituationType.values) {
      if (t.name == value) return t;
    }
    return SituationType.other;
  }

  static List<Feeling> _feelingsFrom(Object? value) {
    final result = <Feeling>[];
    if (value is List) {
      for (final item in value) {
        for (final f in Feeling.values) {
          if (f.name == item) {
            result.add(f);
            break;
          }
        }
      }
    }
    return result;
  }
}