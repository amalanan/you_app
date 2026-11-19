import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';

import '../lib/core/errors/exceptions.dart';
import '../lib/core/helpers/data_events.dart';
import '../lib/features/reflections/data/reflection_repository.dart';
import '../lib/features/reflections/logic/reflections_controller.dart';
import '../lib/features/reflections/models/reflection_entry.dart';

ReflectionEntry entry(int i) => ReflectionEntry(
  kind: ReflectionKind.situation,
  id: 'id$i',
  createdAt: DateTime(2026, 1, 1).add(Duration(minutes: i)),
);

class FakeRepo implements ReflectionRepository {
  FakeRepo(int count) : all = List.generate(count, entry);
  final List<ReflectionEntry> all;
  Object? error;
  int calls = 0;

  @override
  Future<List<ReflectionEntry>> getEntries({int limit = 20, int offset = 0}) async {
    calls++;
    if (error != null) throw error!;
    if (offset >= all.length) return [];
    return all.sublist(offset, math.min(offset + limit, all.length));
  }
}

void main() {
  late FakeRepo repo;

  ReflectionsController make(int count) {
    repo = FakeRepo(count);
    ReflectionRepository.instance = repo;
    final c = ReflectionsController();
    addTearDown(c.dispose);
    return c;
  }

  test('loads 20, then more pages until the end', () async {
    final c = make(45);
    await c.load();
    expect(c.entries.length, 20);
    expect(c.hasMore, isTrue);
    await c.loadMore();
    expect(c.entries.length, 40);
    await c.loadMore();
    expect(c.entries.length, 45);
    expect(c.hasMore, isFalse);
  });

  test('empty result is empty, not an error', () async {
    final c = make(0);
    await c.load();
    expect(c.isEmpty, isTrue);
    expect(c.failure, isNull);
    expect(c.isLoading, isFalse);
  });

  test('an error is exposed and the spinner stops', () async {
    final c = make(5);
    repo.error = const NetworkException();
    await c.load();
    expect(c.failure, isNotNull);
    expect(c.entries, isEmpty);
    expect(c.isLoading, isFalse);
  });

  test('a quiet refresh that fails keeps the list', () async {
    final c = make(10);
    await c.load();
    repo.error = const NetworkException();
    await c.refresh();
    expect(c.entries.length, 10);
    expect(c.failure, isNull);
  });

  test('two loadMore calls at once make only one request', () async {
    final c = make(45);
    await c.load();
    final before = repo.calls;
    await Future.wait([c.loadMore(), c.loadMore()]);
    expect(repo.calls, before + 1);
    expect(c.entries.length, 40);
  });

  test('no duplicate entries when new data shifts the pages', () async {
    final c = make(45);
    await c.load();
    repo.all.insert(0, entry(100)); // a new reflection arrives
    await c.loadMore();
    final ids = c.entries.map((e) => e.id).toList();
    expect(ids.toSet().length, ids.length);
    expect(ids.length, 39);
  });

  test('DataEvents reloads the list', () async {
    final c = make(10);
    await c.load();
    repo.all.insert(0, entry(100));
    DataEvents.instance.changed();
    await pumpEventQueue();
    expect(c.entries.length, 11);
  });

  test('after dispose, DataEvents is ignored', () async {
    repo = FakeRepo(10);
    ReflectionRepository.instance = repo;
    final c = ReflectionsController();
    await c.load();
    c.dispose();
    final before = repo.calls;
    DataEvents.instance.changed();
    await pumpEventQueue();
    expect(repo.calls, before);
  });
}