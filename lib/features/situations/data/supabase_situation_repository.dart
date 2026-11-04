import 'dart:io' show SocketException;

import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/errors/exceptions.dart';
import '../../../core/models/growth_gain.dart';
import '../../../core/models/growth_type.dart';
import '../models/situation_models.dart';
import 'situation_insight.dart';
import 'situation_repository.dart';

/// Saves through the server function submit_situation (003_situations.sql).
class SupabaseSituationRepository implements SituationRepository {
  @override
  Future<SituationInsight> submit({
    required String whatHappened,
    required SituationType type,
    required Set<Feeling> feelings,
    required String action,
    required int confidence,
    required String afterwards,
    required String lesson,
  }) async {
    try {
      final result = await sb.Supabase.instance.client.rpc(
        'submit_situation',
        params: {
          'p_what_happened': whatHappened,
          'p_type': type.name,
          'p_feelings': [for (final f in feelings) f.name],
          'p_action': action.isEmpty ? null : action,
          'p_confidence': confidence,
          'p_afterwards': afterwards.isEmpty ? null : afterwards,
          'p_lesson': lesson.isEmpty ? null : lesson,
        },
      );
      final map = result as Map<String, dynamic>;

      return SituationInsight.fromCodes(
        (map['notices'] as List).cast<String>(),
        [
          for (final g in (map['gains'] as List))
            GrowthGain(
              GrowthType.values.byName((g as Map<String, dynamic>)['skill'] as String),
              g['points'] as int,
            ),
        ],
      );
    } on SocketException {
      throw const NetworkException();
    } on sb.PostgrestException {
      throw const ServerException();
    }
  }
}
