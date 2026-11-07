import 'journey_entry.dart';

/// Everything the Journey tab shows.
class JourneyData {
  const JourneyData({
    required this.day,
    required this.reflections,
    required this.situations,
    required this.scenarios,
    required this.entries,
  });

  final int day;
  final int reflections;
  final int situations;
  final int scenarios;
  final List<JourneyEntry> entries;
}
