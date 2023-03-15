import 'package:rsue_schedule_api/rsue_schedule_api.dart';

/// Получить **готовое** расписание в формате
/// ```dart
/// {
///   "Четная/Нечетная неделя": {
///     "День недели": [
///       {
///         "name": "Дисциплина",
///         "teacher": "Преподаватель",
///         "time": "Время занятия",
///         "room": "Кабинет",
///         "type": "Лабораторная/Практика/Лекция",
///       }
///     ]
///   }
/// }
/// ```
///
///
DayOfWeek _nameToDayOfWeek(String weekdayName) {
  switch (weekdayName) {
    case "Понедельник":
      return 1;
    case "Вторник":
      return 2;
    case "Среда":
      return 3;
    case "Четверг":
      return 4;
    case "Пятница":
      return 5;
    case "Суббота":
      return 6;
    case "Воскресенье":
      return 7;
    default:
      return -1;
  }
}

Map<DayOfWeek, List<AbstractLesson>> _parseWeek(
    Map<String, List<Map<String, String>>> weekRaw) {
  Map<DayOfWeek, List<AbstractLesson>> result = {};
  for (var dayRaw in weekRaw.entries) {
    result[_nameToDayOfWeek(dayRaw.key)] = dayRaw.value.map((element) {
      LessonType type;
      switch (element["type"]) {
        case "Лекция":
          type = LessonType.lection;
          break;
        case "Практика":
          type = LessonType.practice;
          break;
        default:
          type = LessonType.lab;
      }
      return AbstractLesson(
          name: element["name"] ?? "",
          teachersname: element["teacher"] ?? "",
          room: element["room"] ?? "",
          type: type,
          time: element["time"] ?? "");
    }).toList();
  }
  return result;
}

Future<ScheduleService?> getSchedule(int faculty, int course, int group) async {
  var raw = await getScheduleRawData(faculty, course, group);
  Map<String, List<Map<String, String>>> evenRaw;
  Map<String, List<Map<String, String>>> oddRaw;
  try {
    oddRaw = raw!["Нечетная неделя"]!;
  } catch (e) {
    throw Exception('"Нечетная неделя" не найдена');
  }
  try {
    evenRaw = raw["Четная неделя"]!;
  } catch (e) {
    throw Exception('"Четная неделя" не найдена');
  }
  return ScheduleService(_parseWeek(evenRaw), _parseWeek(oddRaw));
}
