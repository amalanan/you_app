import 'package:flutter_test/flutter_test.dart';

import '../lib/features/reflections/models/reflection_entry.dart';

void main() {
  test('maps a situation row and keeps every user-written field', () {
    final e = ReflectionEntry.fromMap({
      'kind': 'situation',
      'id': 'a1',
      'created_at': '2026-11-10T09:30:00+00:00',
      'confidence': 7,
      'what_happened': 'I had a hard conversation',
      'type': 'work',
      'feelings': ['nervous', 'hopeful'],
      'action': 'I stayed calm',
      'afterwards': 'It went better than expected',
      'lesson': 'Prepare first',
      'reason': null,
      'prompt': null,
    });
    expect(e.kind, ReflectionKind.situation);
    expect(e.type?.name, 'work');
    expect(e.feelings.map((f) => f.name), ['nervous', 'hopeful']);
    expect(e.whatHappened, 'I had a hard conversation');
    expect(e.action, 'I stayed calm');
    expect(e.afterwards, 'It went better than expected');
    expect(e.lesson, 'Prepare first');
    expect(e.prompt, isNull);
  });

  test('maps a scenario row with localized text', () {
    final e = ReflectionEntry.fromMap({
      'kind': 'scenario',
      'id': 'b1',
      'created_at': '2026-11-11T10:00:00+00:00',
      'confidence': 6,
      'feelings': [],
      'reason': 'Safety first',
      'matter': 'Security',
      'scenario_id': 's1',
      'option_id': 'o1',
      'scenario_title': {'ar': 'عنوان', 'en': 'Title'},
      'prompt': {'ar': 'سؤال', 'en': 'Prompt'},
      'chosen_option': {'en': 'Option'},
      'insight': {'ar': 'فكرة', 'en': 'Insight'},
    });
    expect(e.kind, ReflectionKind.scenario);
    expect(e.reason, 'Safety first');
    expect(e.scenarioTitle?.resolve('ar'), 'عنوان');
    expect(e.prompt?.resolve('en'), 'Prompt');
    expect(e.chosenOption?.resolve('ar'), 'Option'); // falls back to English
    expect(e.insight?.resolve('ar'), 'فكرة');
  });

  test('is tolerant of unknown or blank values', () {
    final e = ReflectionEntry.fromMap({
      'kind': 'situation',
      'id': 'c1',
      'created_at': '2026-11-12T08:00:00+00:00',
      'type': 'something_new',
      'feelings': ['calm', 'mystery'],
      'reason': '   ',
    });
    expect(e.type?.name, 'other');
    expect(e.feelings.map((f) => f.name), ['calm']);
    expect(e.reason, isNull);
    expect(e.confidence, isNull);
  });
}