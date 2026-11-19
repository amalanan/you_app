import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lib/core/constants/app_strings.dart';
import '../lib/core/storage/local_storage.dart';
import '../lib/features/reflections/models/reflection_entry.dart';
import '../lib/features/reflections/widgets/reflection_card.dart';
import '../lib/features/situations/models/situation_models.dart';

Future<void> pumpCard(WidgetTester tester, ReflectionEntry entry) {
  return tester.pumpWidget(
    MaterialApp(home: Scaffold(body: ReflectionCard(entry: entry))),
  );
}

ReflectionEntry situation({required DateTime createdAt, String text = 'Some text'}) {
  return ReflectionEntry(
    kind: ReflectionKind.situation,
    id: 'situation-1',
    createdAt: createdAt,
    whatHappened: text,
    type: SituationType.work,
  );
}

/// Noon on a local calendar day, [daysAgo] days before today. Noon and calendar
/// arithmetic keep these tests stable around midnight and daylight-saving changes.
DateTime localDay(int daysAgo) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day - daysAgo, 12);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Same first step as main(): the card reads AppLocale, which reads LocalStorage.
  // An empty fake store means no saved language choice.
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorage.init();
  });

  group('ReflectionCard content', () {
    testWidgets('a situation shows what the user wrote', (tester) async {
      await pumpCard(
        tester,
        situation(createdAt: localDay(0), text: 'I had a hard conversation'),
      );

      expect(find.text('I had a hard conversation'), findsOneWidget);
      expect(find.text(AppStrings.typeWork), findsOneWidget); // kind label
    });

    testWidgets('a scenario shows its localized title and the reason', (tester) async {
      await pumpCard(
        tester,
        ReflectionEntry(
          kind: ReflectionKind.scenario,
          id: 'scenario-1',
          createdAt: localDay(0),
          scenarioTitle: const LocalizedValue({
            'en': 'A quick decision',
            'ar': 'قرار سريع',
          }),
          prompt: const LocalizedValue({'en': 'The long scenario text'}),
          chosenOption: const LocalizedValue({'en': 'Take a moment to think'}),
          reason: 'Safety first',
        ),
      );

      expect(find.text('A quick decision'), findsOneWidget);
      expect(find.text('Safety first'), findsOneWidget);
      expect(find.text(AppStrings.reflectionScenario), findsOneWidget);
      // The title wins over the prompt, and the reason wins over the chosen answer.
      expect(find.text('The long scenario text'), findsNothing);
      expect(find.text('Take a moment to think'), findsNothing);
    });

    testWidgets('a scenario without title or prompt falls back to the chosen option',
            (tester) async {
          await pumpCard(
            tester,
            ReflectionEntry(
              kind: ReflectionKind.scenario,
              id: 'scenario-2',
              createdAt: localDay(0),
              chosenOption: const LocalizedValue({'en': 'Take a moment to think'}),
            ),
          );

          // Shown once, as the heading: it is not repeated as a second line.
          expect(find.text('Take a moment to think'), findsOneWidget);
        });
  });

  group('ReflectionCard date label', () {
    testWidgets('today', (tester) async {
      await pumpCard(tester, situation(createdAt: localDay(0)));

      expect(find.text(AppStrings.today), findsOneWidget);
      expect(find.text(AppStrings.yesterday), findsNothing);
    });

    testWidgets('a UTC time is read as the local day (today)', (tester) async {
      await pumpCard(tester, situation(createdAt: DateTime.now().toUtc()));

      expect(find.text(AppStrings.today), findsOneWidget);
    });

    testWidgets('yesterday', (tester) async {
      await pumpCard(tester, situation(createdAt: localDay(1)));

      expect(find.text(AppStrings.yesterday), findsOneWidget);
      expect(find.text(AppStrings.today), findsNothing);
    });

    testWidgets('an older entry shows a localized date', (tester) async {
      final date = localDay(5);
      await pumpCard(tester, situation(createdAt: date));

      final expected = MaterialLocalizations.of(
        tester.element(find.byType(ReflectionCard)),
      ).formatMediumDate(date);

      expect(find.text(expected), findsOneWidget);
      expect(find.text(AppStrings.today), findsNothing);
      expect(find.text(AppStrings.yesterday), findsNothing);
    });
  });
}