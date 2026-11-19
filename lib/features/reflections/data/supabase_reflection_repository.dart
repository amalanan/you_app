import 'dart:io' show SocketException;

import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/errors/exceptions.dart';
import '../models/reflection_entry.dart';
import 'reflection_repository.dart';

/// Reads the reflection_entries view. The view only returns the signed-in user's rows.
class SupabaseReflectionRepository implements ReflectionRepository {
  @override
  Future<List<ReflectionEntry>> getEntries({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final rows = await sb.Supabase.instance.client
          .from('reflection_entries')
          .select()
          .order('created_at', ascending: false)
          .order('id', ascending: false) // keeps pages stable when two rows tie
          .range(offset, offset + limit - 1);

      return [for (final row in rows) ReflectionEntry.fromMap(row)];
    } on SocketException {
      throw const NetworkException();
    } on sb.PostgrestException {
      throw const ServerException();
    }
  }
}