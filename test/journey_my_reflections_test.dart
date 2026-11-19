import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lib/core/constants/app_strings.dart';
import '../lib/core/routing/app_routes.dart';
import '../lib/core/storage/local_storage.dart';
import '../lib/features/journey/data/journey_repository.dart';
import '../lib/features/journey/data/mock_journey_repository.dart';
import '../lib/features/journey/models/journey_data.dart';
import '../lib/features/journey/pages/journey_page.dart';
import '../lib/features/reflections/data/reflection_repository.dart';
import '../lib/features/reflections/models/reflection_entry.dart';
import '../lib/features/reflections/pages/reflections_page.dart';

class FakeReflections implements ReflectionRepository {
  final all = List.generate(
    3,
        (i) => ReflectionEntry(
      kind: ReflectionKind.situation,
      id: 'id$i',
      createdAt: DateTime.now().subtract(Duration(minutes: i)),
      whatHappened: 'Entry $i',
    ),
  );

  @override
  Future<List<ReflectionEntry>> getEntries({int limit = 20, int offset = 0}) async =>
      offset >= all.length ? [] : all.sublist(offset, math.min(offset + limit, all.length));
}

class EmptyJourney implements JourneyRepository {
  @override
  Future<JourneyData> fetchJourney() async => const JourneyData(
    day: 1,
    reflections: 0,
    situations: 0,
    scenarios: 0,
    entries: [],
  );
}

Widget app() => MaterialApp.router(
  routerConfig: GoRouter(
    initialLocation: AppRoutes.journey,
    routes: [
      GoRoute(
        path: AppRoutes.journey,
        builder: (_, __) => const JourneyPage(),
        routes: [
          GoRoute(path: 'reflections', builder: (_, __) => const ReflectionsPage()),
        ],
      ),
    ],
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorage.init();
  });

  testWidgets('the tile opens My Reflections', (tester) async {
    JourneyRepository.instance = MockJourneyRepository();
    ReflectionRepository.instance = FakeReflections();
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.myReflections));
    await tester.pumpAndSettle();

    expect(find.byType(ReflectionsPage), findsOneWidget);
    expect(find.text('Entry 0'), findsOneWidget);
  });

  testWidgets('the tile is hidden when there are no reflections', (tester) async {
    JourneyRepository.instance = EmptyJourney();
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.journeyEmptyTitle), findsOneWidget);
    expect(find.text(AppStrings.myReflections), findsNothing);
  });
}