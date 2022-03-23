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

  for (var faculty in facults.keys) {
    Map<int, String>? courses = await _getCourses(faculty);
    for (var course in courses!.keys) {
      Map<int, String>? groups = await _getGroups(faculty, course);
      for (var group in groups!.keys) {
        allGroups.addEntries({
          // Пояснение за groups[group]: в случае с .forEach запросы не
          // успевают обрабатываться и потому возвращает null, а в конструкции
          // for in нет возможности обработки map
          (groups[group] ?? (faculty * (course + 1) * (group + 1)).toString()):
              {"f": faculty, "c": course, "g": group}
        }.entries);
      }
    }
  }

  // facults.forEach((keyFaculty, nameFaculty) async {
  //   Map<int, String>? courses = await _getCourses(keyFaculty);
  //   courses?.forEach((keyCourse, nameCourse) async {
  //     Map<int, String>? groups = await _getGroups(keyFaculty, keyCourse);
  //     groups?.forEach((keyGroup, nameGroup) {
  //       allGroups.addEntries({
  //         nameGroup: {"f": keyFaculty, "c": keyCourse, "g": keyGroup}
  //       }.entries);
  //     });
  //   });
  // });

  return allGroups;
}
