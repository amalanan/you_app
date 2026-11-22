// import '../models/reflection_entry.dart';
//
// /// Where past reflections (situations and scenario answers) are read from.
// /// Screens only use this class. Saving stays in the Situation and Scenario repositories.
// abstract class ReflectionRepository {
//   /// Set once in main().
//   static late ReflectionRepository instance;
//
//   /// Newest first. Pass a bigger [offset] to load the next page.
//   Future<List<ReflectionEntry>> getEntries({int limit = 20, int offset = 0});
// }
import '../models/reflection_entry.dart';

/// Where past reflections (situations and scenario answers) are read from.
abstract class ReflectionRepository {
  /// Set once in main().
  static late ReflectionRepository instance;

  /// Newest first. Pass a bigger [offset] to load the next page.
  Future<List<ReflectionEntry>> getEntries({int limit = 20, int offset = 0});

  /// Deletes a saved reflection and its related growth points.
  Future<void> deleteEntry(ReflectionEntry entry);
}
