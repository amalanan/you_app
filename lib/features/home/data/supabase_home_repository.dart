import 'dart:io' show SocketException;
import 'dart:math' as math;

import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/errors/exceptions.dart';
import '../../../core/l10n/app_locale.dart';
import '../../../core/models/growth_score.dart';
import '../../../core/models/growth_type.dart';
import '../models/home_data.dart';
import 'home_repository.dart';

/// Everything Home needs comes from ONE server call: get_home_summary().
class SupabaseHomeRepository implements HomeRepository {
  /// The 3 skills shown on Home, in this order (as in the design).
  static const _homeSkills = [
    GrowthType.decisionMaking,
    GrowthType.learning,
    GrowthType.selfAwareness,
  ];

  @override
  Future<HomeData> fetchHome() async {
    try {
      final result = await sb.Supabase.instance.client.rpc('get_home_summary');
      final map = result as Map<String, dynamic>;

      final scores = <String, int>{
        for (final s in (map['scores'] as List))
          (s as Map<String, dynamic>)['skill'] as String: s['score'] as int,
      };

      final today = map['today'] as Map<String, dynamic>?;

      return HomeData(
        journey: JourneyProgress(
          day: map['day'] as int,
          completedSteps: math.min(map['active_days'] as int, 14),
        ),
        scenario: today == null
            ? null
            : TodayScenario(
          id: today['id'] as String,
          text: _text(today['situation']),
          minutes: today['minutes'] as int,
        ),
        growth: [
          for (final skill in _homeSkills)
            GrowthScore(skill, scores[skill.name] ?? GrowthScore.startScore),
        ],
      );
    } on SocketException {
      throw const NetworkException();
    } on sb.PostgrestException {
      throw const ServerException();
    }
  }

  /// Texts are stored as {"en": "...", "ar": "..."}.
  static String _text(dynamic json) {
    final map = json as Map<String, dynamic>;
    final lang = AppLocale.isArabic ? 'ar' : 'en';
    return (map[lang] ?? map['en'] ?? '') as String;
  }
}
