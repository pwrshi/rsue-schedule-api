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
Future<ScheduleService?> getSchedule(int faculty, int course, int group) async {
  var scheduleRaw = await getScheduleRawData(faculty, course, group);
  if (scheduleRaw != null) {
    return ScheduleService.fromJson(scheduleRaw);
  }
  return null;
}
