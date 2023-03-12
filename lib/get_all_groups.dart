import 'get_courses.dart';
import 'get_facults.dart';
import 'get_groups.dart';

/// ### Получить список групп, в формате
/// ```dart
/// {
///   "Группа": [
///     0 // номер факультета
///     1 // номер курса
///     2 // номер группа
///   ]
/// }
/// ```
Future<Map<String, List<int>>?> getAllGroups() async {
  Map<int, String>? facults = await getFacults();
  facults!.remove(0);

  Map<String, List<int>> allGroups = {};

  for (var faculty in facults.keys) {
    Map<int, String>? courses = await getCourses(faculty);
    for (var course in courses!.keys) {
      Map<int, String>? groups = await getGroups(faculty, course);
      for (var entry in groups!.entries) {
        allGroups[(entry.value)] = [faculty, course, entry.key];
      }
    }
  }
  return allGroups;
}
