import 'dart:io' show SocketException;

import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/errors/exceptions.dart';
import '../../../core/l10n/app_locale.dart';
import '../../../core/models/growth_score.dart';
import '../../../core/models/growth_type.dart';
import '../models/growth_detail.dart';
import 'growth_repository.dart';
import 'mock_insights.dart';

/// Scores and charts are calculated by the server (004_growth.sql).
class SupabaseGrowthRepository implements GrowthRepository {
  sb.SupabaseClient get _client => sb.Supabase.instance.client;

  @override
  Future<List<GrowthScore>> fetchProfile() {
    return _guard(() async {
      final result = await _client.rpc('get_growth_profile');
      return [
        for (final row in (result as List))
          GrowthScore(
            GrowthType.values.byName((row as Map<String, dynamic>)['skill'] as String),
            row['score'] as int,
          ),
      ];
    });
  }

  @override
  Future<GrowthDetail> fetchDetail(GrowthType type, GrowthRange range) {
    return _guard(() async {
      final result = await _client.rpc(
        'get_growth_detail',
        params: {'p_skill': type.name, 'p_range': range.name},
      );
      final map = result as Map<String, dynamic>;
      final raw = (map['points'] as List).cast<Map<String, dynamic>>();

      return GrowthDetail(
        current: map['current'] as int,
        previous: map['previous'] as int,
        points: [
          for (var i = 0; i < raw.length; i++)
            GrowthPoint(
              _label(range, i, DateTime.parse(raw[i]['date'] as String)),
              raw[i]['value'] as int,
            ),
        ],
        meaning: growthMeaningFor(type),
        // her own recent lessons for this skill (can be empty)
        experiences: (map['experiences'] as List).cast<String>(),
      );
    });
  }

  /// 7 days -> the day number, 30 days -> W1..W5, 3 months -> the month name.
  static String _label(GrowthRange range, int index, DateTime date) {
    switch (range) {
      case GrowthRange.week:
        return '${date.day}';
      case GrowthRange.month:
        return 'W${index + 1}';
      case GrowthRange.quarter:
        final months = AppLocale.isArabic ? _monthsAr : _monthsEn;
        return months[date.month - 1];
    }
  }

  static const _monthsEn = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static const _monthsAr = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on SocketException {
      throw const NetworkException();
    } on sb.PostgrestException {
      throw const ServerException();
    }
  }
}
