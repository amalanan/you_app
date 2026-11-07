import 'dart:io' show SocketException;

import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/constants/app_strings.dart';
import '../../../core/errors/exceptions.dart';
import '../models/journey_data.dart';
import '../models/journey_entry.dart';
import 'journey_repository.dart';

/// One server call: get_journey() (005_journey.sql).
class SupabaseJourneyRepository implements JourneyRepository {
  @override
  Future<JourneyData> fetchJourney() async {
    try {
      final result = await sb.Supabase.instance.client.rpc('get_journey');
      final map = result as Map<String, dynamic>;
      final scenarios = map['scenarios'] as int;
      final situations = map['situations'] as int;

      return JourneyData(
        day: map['day'] as int,
        reflections: scenarios + situations,
        situations: situations,
        scenarios: scenarios,
        entries: [
          for (final e in (map['entries'] as List).cast<Map<String, dynamic>>())
            _entry(e),
        ],
      );
    } on SocketException {
      throw const NetworkException();
    } on sb.PostgrestException {
      throw const ServerException();
    }
  }

  static JourneyEntry _entry(Map<String, dynamic> e) {
    final isScenario = e['type'] == 'scenario';
    final daysAgo = e['days_ago'] as int;

    return JourneyEntry(
      // Today / Yesterday / Day 9 ...
      dayLabel: daysAgo == 0
          ? AppStrings.today
          : daysAgo == 1
              ? AppStrings.yesterday
              : AppStrings.dayNumber(e['day_number'] as int),
      text: isScenario
          ? AppStrings.journeyCompletedScenario
          : AppStrings.journeyAddedSituation,
      type: isScenario ? JourneyEntryType.scenario : JourneyEntryType.situation,
    );
  }
}
