import 'dart:io' show SocketException;

import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/constants/app_strings.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/l10n/app_locale.dart';
import '../../../core/models/growth_gain.dart';
import '../../../core/models/growth_type.dart';
import '../models/scenario.dart';
import 'scenario_repository.dart';

/// Scenarios live in the database (tables scenarios + scenario_options) and the
/// answer is saved by the server function submit_scenario_response.
class SupabaseScenarioRepository implements ScenarioRepository {
  sb.SupabaseClient get _client => sb.Supabase.instance.client;

  @override
  Future<List<Scenario>> fetchScenarios() {
    return _guard(() async {
      final rows = await _client
          .from('scenarios')
          .select(
            'id, category, minutes, sort_order, title, summary, situation, question, '
            'scenario_options(id, position, text, insight, gains)',
          )
          .eq('is_active', true)
          .order('sort_order');

      return [for (final row in rows) _scenario(row)];
    });
  }

  @override
  Future<ScenarioResult> submitResponse({
    required Scenario scenario,
    required int optionIndex,
    required int confidence,
    String? reason,
    String? matter,
  }) {
    return _guard(() async {
      final result = await _client.rpc(
        'submit_scenario_response',
        params: {
          'p_scenario_id': scenario.id,
          'p_option_id': scenario.options[optionIndex].id,
          'p_confidence': confidence,
          'p_reason': reason,
          'p_matter': matter,
        },
      );
      final map = result as Map<String, dynamic>;
      return ScenarioResult(
        insight: _text(map['insight']),
        gains: _gains(map['gains']),
      );
    });
  }

  // ---- reading the database rows ----

  /// Texts are stored as {"en": "...", "ar": "..."}: pick the app language.
  static String _text(dynamic json) {
    final map = json as Map<String, dynamic>;
    final lang = AppLocale.isArabic ? 'ar' : 'en';
    return (map[lang] ?? map['en'] ?? '') as String;
  }

  static List<GrowthGain> _gains(dynamic json) => [
        for (final g in (json as List))
          GrowthGain(
            GrowthType.values.byName((g as Map<String, dynamic>)['skill'] as String),
            g['points'] as int,
          ),
      ];

  static Scenario _scenario(Map<String, dynamic> row) {
    final options = [
      ...(row['scenario_options'] as List).cast<Map<String, dynamic>>(),
    ]..sort((a, b) => (a['position'] as int).compareTo(b['position'] as int));

    final question = row['question'];

    return Scenario(
      id: row['id'] as String,
      title: _text(row['title']),
      summary: _text(row['summary']),
      situation: _text(row['situation']),
      question: question == null ? AppStrings.whatWouldYouDo : _text(question),
      category: ScenarioCategory.values.byName(row['category'] as String),
      minutes: row['minutes'] as int,
      options: [
        for (final o in options)
          ScenarioOption(
            id: o['id'] as String,
            text: _text(o['text']),
            insight: _text(o['insight']),
            gains: _gains(o['gains']),
          ),
      ],
    );
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on SocketException {
      throw const NetworkException();
    } on sb.PostgrestException {
      throw const ServerException(); // shows the friendly "something went wrong"
    }
  }
}
