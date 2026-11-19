import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lib/core/constants/app_strings.dart';
import '../lib/core/errors/exceptions.dart';
import '../lib/core/storage/local_storage.dart';
import '../lib/core/widgets/status_view.dart';
import '../lib/features/reflections/data/reflection_repository.dart';
import '../lib/features/reflections/models/reflection_entry.dart';
import '../lib/features/reflections/pages/reflections_page.dart';
import '../lib/features/reflections/widgets/reflection_card.dart';

ReflectionEntry entry(int i) => ReflectionEntry(
  kind: ReflectionKind.situation,
  id: 'id$i',
  createdAt: DateTime.now().subtract(Duration(minutes: i)),
  whatHappened: 'Entry $i',
);

class FakeRepo implements ReflectionRepository {
  FakeRepo(int count) : all = List.generate(count, entry);
  final List<ReflectionEntry> all;
  Object? error;
  Completer<void>? gate; // when set, getEntries waits for it
  int calls = 0;

  @override
  Future<List<ReflectionEntry>> getEntries({int limit = 20, int offset = 0}) async {
    calls++;
    if (gate != null) await gate!.future;
    if (error != null) throw error!;
    if (offset >= all.length) return [];
    return all.sublist(offset, math.min(offset + limit, all.length));
  }
}

FakeRepo useRepo(int count) {
  final repo = FakeRepo(count);
  ReflectionRepository.instance = repo;
  return repo;
}

Future<void> pumpPage(
    WidgetTester tester, {
      ValueChanged<ReflectionEntry>? onOpen,
    }) {
  return tester.pumpWidget(
    MaterialApp(home: ReflectionsPage(onOpenEntry: onOpen)),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Same first step as main(): the app texts read AppLocale, which reads LocalStorage.
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorage.init();
  });

  testWidgets('shows a spinner while the first page loads', (tester) async {
    final repo = useRepo(3)..gate = Completer<void>();
    await pumpPage(tester);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ReflectionCard), findsNothing);

    repo.gate!.complete();
    await tester.pumpAndSettle();
    expect(find.byType(ReflectionCard), findsNWidgets(3));
  });

  testWidgets('shows the empty state when there are no reflections', (tester) async {
    useRepo(0);
    await pumpPage(tester);
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.reflectionsEmptyTitle), findsOneWidget);
    expect(find.text(AppStrings.reflectionsEmptyBody), findsOneWidget);
    expect(find.byType(ReflectionCard), findsNothing);
  });

  testWidgets('shows a card for each reflection', (tester) async {
    useRepo(3);
    await pumpPage(tester);
    await tester.pumpAndSettle();

    expect(find.byType(ReflectionCard), findsNWidgets(3));
    expect(find.text('Entry 0'), findsOneWidget);
    expect(find.text('Entry 2'), findsOneWidget);
  });

  testWidgets('shows an error, and Retry loads the list', (tester) async {
    final repo = useRepo(3)..error = const NetworkException();
    await pumpPage(tester);
    await tester.pumpAndSettle();

    expect(find.byType(StatusView), findsOneWidget);
    expect(find.byType(ReflectionCard), findsNothing);

    repo.error = null;
    await tester.tap(find.text(AppStrings.retry));
    await tester.pumpAndSettle();

    expect(find.byType(StatusView), findsNothing);
    expect(find.byType(ReflectionCard), findsNWidgets(3));
  });

  testWidgets('loads the next page when the user scrolls down', (tester) async {
    final repo = useRepo(45);
    await pumpPage(tester);
    await tester.pumpAndSettle();
    expect(repo.calls, 1);
    expect(find.text('Entry 25'), findsNothing); // not loaded yet

    await tester.scrollUntilVisible(find.text('Entry 25'), 400, maxScrolls: 100);

    expect(repo.calls, greaterThanOrEqualTo(2));
    expect(find.text('Entry 25'), findsOneWidget);
  });

  testWidgets('tapping a card calls onOpenEntry with that reflection', (tester) async {
    useRepo(3);
    ReflectionEntry? opened;
    await pumpPage(tester, onOpen: (e) => opened = e);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entry 1'));
    expect(opened?.id, 'id1');
  });
}