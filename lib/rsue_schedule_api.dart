import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:dio/dio.dart';

import 'schedule_type.dart';

part '_urls.dart';
part '_facults.dart';
part '_courses.dart';
part '_groups.dart';
part '_all_groups.dart';
part 'get_schedule.dart';

// INFO: В методе getFacults отсчёт начинается с 1, ибо он парсится с формочек

/// Общение с API расписания РИНХа
Future<Schedule?> getSchedule(int faculty, int course, int group) async {
  var scheduleRaw = await _getSchedule(faculty, course, group);
  if (scheduleRaw != null) {
    return Schedule(scheduleRaw,
        faculty: faculty, course: course, group: group);
  }
  return null;
}

/// Получить список факультетов
Future<Map<int, String>?> getFacults() => _getFacults();

/// Получить список курсов ао факультету
Future<Map<int, String>?> getCourses(int faculty) => _getCourses(faculty);

/// Получить список групп, по факультету и курсу
Future<Map<int, String>?> getGroups(int faculty, int course) =>
    _getGroups(faculty, course);

/// Получить список групп, в
/// формате
/// ```dart
/// {
///   "Группа": {
///     "f": номер факультета
///     "c": номер курса
///     "g": номер группа
///   }
/// }
/// ```
Future<Map<String, Map<String, int>>?> getAllGroups() => _getAllGroups();

/// Получить готовое расписание в формате
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
Future<Map<String, Map<String, List<Map<String, String>>>>?> getScheduleRaw(
        int faculty, int course, int group) =>
    _getSchedule(faculty, course, group);
