import 'dart:io' show SocketException;

import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/constants/app_strings.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/l10n/app_locale.dart';
import '../../../core/models/growth_type.dart';
import '../models/growth_detail.dart';
import 'insights_repository.dart';

/// The server finds the FACTS (get_insights, 006_insights.sql);
/// here they become sentences in English or Arabic.
class SupabaseInsightsRepository implements InsightsRepository {
  @override
  Future<List<InsightItem>> fetchInsights() async {
    try {
      final result = await sb.Supabase.instance.client.rpc('get_insights');
      final map = result as Map<String, dynamic>;

      final improvement = map['improvement'] as Map<String, dynamic>?;
      final pattern = map['pattern'] as Map<String, dynamic>?;
      final explore = map['explore'] as Map<String, dynamic>?;

      return [
        if (improvement != null)
          InsightItem(
            kind: InsightKind.improvement,
            title: AppStrings.insightImprovementTitle,
            body: AppStrings.insightImprovement(_skill(improvement['skill'])),
          ),
        if (pattern != null)
          InsightItem(
            kind: InsightKind.pattern,
            title: AppStrings.insightPatternTitle,
            body: pattern['kind'] == 'matter'
                ? AppStrings.insightPatternMatter(tr(pattern['value'] as String))
                : AppStrings.insightPatternFeeling(
                    tr(_feelingLabel(pattern['value'] as String)),
                  ),
          ),
        if (explore != null)
          InsightItem(
            kind: InsightKind.explore,
            title: AppStrings.insightExploreTitle,
            body: AppStrings.insightExplore(_skill(explore['skill'])),
          ),
      ];
    } on SocketException {
      throw const NetworkException();
    } on sb.PostgrestException {
      throw const ServerException();
    }
  }

  /// 'learning' -> "Learning" / "التعلّم"
  static String _skill(dynamic code) =>
      tr(GrowthType.values.byName(code as String).label);

  static String _feelingLabel(String code) => switch (code) {
        'excited' => AppStrings.feelExcited,
        'nervous' => AppStrings.feelNervous,
        'confident' => AppStrings.feelConfident,
        'confused' => AppStrings.feelConfused,
        'frustrated' => AppStrings.feelFrustrated,
        'disappointed' => AppStrings.feelDisappointed,
        'hopeful' => AppStrings.feelHopeful,
        'overwhelmed' => AppStrings.feelOverwhelmed,
        'calm' => AppStrings.feelCalm,
        _ => code,
      };
}
