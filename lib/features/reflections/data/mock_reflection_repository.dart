//
// import '../../situations/models/situation_models.dart';
// import '../models/reflection_entry.dart';
// import 'reflection_repository.dart';
//
// /// Used while Supabase is not set up: returns two sample reflections.
// class MockReflectionRepository implements ReflectionRepository {
//   @override
//   Future<List<ReflectionEntry>> getEntries({
//     int limit = 20,
//     int offset = 0,
//   }) async {
//     final now = DateTime.now();
//     final all = <ReflectionEntry>[
//       ReflectionEntry(
//         kind: ReflectionKind.situation,
//         id: 'mock-1',
//         createdAt: now.subtract(const Duration(days: 1)),
//         confidence: 7,
//         whatHappened: 'I had to choose between two offers.',
//         type: SituationType.decision,
//         feelings: const [Feeling.nervous, Feeling.hopeful],
//         action: 'I wrote down the pros and cons.',
//         afterwards: 'I felt calmer once I decided.',
//         lesson: 'Writing things down helps me think.',
//       ),
//       ReflectionEntry(
//         kind: ReflectionKind.scenario,
//         id: 'mock-2',
//         createdAt: now.subtract(const Duration(days: 3)),
//         confidence: 6,
//         reason: 'Safety first.',
//         matter: 'Security',
//         scenarioId: 'mock-scenario',
//         optionId: 'mock-option',
//         scenarioTitle: const LocalizedValue({'en': 'A quick decision', 'ar': 'قرار سريع'}),
//         prompt: const LocalizedValue({
//           'en': 'You must decide quickly on a new project.',
//           'ar': 'عليك أن تتخذ قرارًا سريعًا بخصوص مشروع جديد.',
//         }),
//         chosenOption: const LocalizedValue({'en': 'Take a moment to think', 'ar': 'أمنح نفسي لحظة للتفكير'}),
//         insight: const LocalizedValue({
//           'en': 'Pausing can bring clarity.',
//           'ar': 'التوقف قد يجلب الوضوح.',
//         }),
//       ),
//     ];
//
//     if (offset >= all.length) return const [];
//     final end = offset + limit > all.length ? all.length : offset + limit;
//     return all.sublist(offset, end);
//   }
// }

import '../../situations/models/situation_models.dart';
import '../models/reflection_entry.dart';
import 'reflection_repository.dart';

/// Used while Supabase is not set up: returns two sample reflections.
class MockReflectionRepository implements ReflectionRepository {
  final List<ReflectionEntry> _entries = [];

  @override
  Future<List<ReflectionEntry>> getEntries({
    int limit = 20,
    int offset = 0,
  }) async {
    if (_entries.isEmpty) {
      final now = DateTime.now();

      _entries.addAll([
        ReflectionEntry(
          kind: ReflectionKind.situation,
          id: 'mock-1',
          createdAt: now.subtract(const Duration(days: 1)),
          confidence: 7,
          whatHappened: 'I had to choose between two offers.',
          type: SituationType.decision,
          feelings: const [Feeling.nervous, Feeling.hopeful],
          action: 'I wrote down the pros and cons.',
          afterwards: 'I felt calmer once I decided.',
          lesson: 'Writing things down helps me think.',
        ),
        ReflectionEntry(
          kind: ReflectionKind.scenario,
          id: 'mock-2',
          createdAt: now.subtract(const Duration(days: 3)),
          confidence: 6,
          reason: 'Safety first.',
          matter: 'Security',
          scenarioId: 'mock-scenario',
          optionId: 'mock-option',
          scenarioTitle: const LocalizedValue({
            'en': 'A quick decision',
            'ar': 'قرار سريع',
          }),
          prompt: const LocalizedValue({
            'en': 'You must decide quickly on a new project.',
            'ar': 'عليك أن تتخذ قرارًا سريعًا بخصوص مشروع جديد.',
          }),
          chosenOption: const LocalizedValue({
            'en': 'Take a moment to think',
            'ar': 'أمنح نفسي لحظة للتفكير',
          }),
          insight: const LocalizedValue({
            'en': 'Pausing can bring clarity.',
            'ar': 'التوقف قد يجلب الوضوح.',
          }),
        ),
      ]);
    }

    if (offset >= _entries.length) return const [];

    final end =
        offset + limit > _entries.length ? _entries.length : offset + limit;

    return _entries.sublist(offset, end);
  }

  @override
  Future<void> deleteEntry(ReflectionEntry entry) async {
    _entries.removeWhere(
      (item) => item.kind == entry.kind && item.id == entry.id,
    );
  }
}
