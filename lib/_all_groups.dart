part of 'rsue_schedule_api.dart';

Future<Map<String, Map<String, int>>?> _getAllGroups() async {
  Map<int, String>? facults = await _getFacults();
  facults!.remove(0);

  /// ```dart
  /// {
  ///   "Группа": {
  ///     "f": номер факультета
  ///     "c": номер курса
  ///     "g": номер группа
  ///   }
  /// }
  /// ```
  Map<String, Map<String, int>> allGroups = {};
  facults.forEach((keyFaculty, nameFaculty) async {
    Map<int, String>? courses = await _getCourses(keyFaculty);
    courses?.forEach((keyCourse, nameCourse) async {
      Map<int, String>? groups = await _getGroups(keyFaculty, keyCourse);
      groups?.forEach((keyGroup, nameGroup) {
        allGroups.addEntries({
          nameGroup: {"f": keyFaculty, "c": keyCourse, "g": keyGroup}
        }.entries);
      });
    });
  });

  return allGroups;
}
