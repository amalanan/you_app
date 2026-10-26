import '../models/journey_entry.dart';

/// TODO: replace with the real activity history.
const mockDay = 12;
const mockReflections = 12;
const mockSituations = 4;
const mockScenarios = 8;

const mockJourney = [
  JourneyEntry(
    dayLabel: 'Today',
    text: 'Added a new situation',
    type: JourneyEntryType.situation,
  ),
  JourneyEntry(
    dayLabel: 'Yesterday',
    text: 'Completed a scenario',
    type: JourneyEntryType.scenario,
  ),
  JourneyEntry(
    dayLabel: 'Day 9',
    text: 'Added a reflection',
    type: JourneyEntryType.reflection,
  ),
  JourneyEntry(
    dayLabel: 'Day 7',
    text: 'Completed a scenario',
    type: JourneyEntryType.scenario,
  ),
];
