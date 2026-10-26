enum JourneyEntryType { situation, scenario, reflection }

class JourneyEntry {
  const JourneyEntry({
    required this.dayLabel,
    required this.text,
    required this.type,
  });

  final String dayLabel;
  final String text;
  final JourneyEntryType type;
}
