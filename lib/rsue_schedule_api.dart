import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:dio/dio.dart';

part '_urls.dart';
part '_faculty.dart';
part '_courses.dart';
part '_groups.dart';
part '_schedule.dart';

// INFO: В методах отсчёт начинается с 1, т.к. в формочках самого ринха,
// они тоже начинаются с 1

/// Общение с API расписания РИНХа
class ScheduleAPI {
  /// Получить список факультетов
  static Future<Map<int, String>?> getFacults() => _getFaculty();

  /// Получить список курсов
  static Future<Map<int, String>?> getCourses(int faculty) =>
      _getCourses(faculty);

  /// Получить список групп
  static Future<Map<int, String>?> getGroups(int faculty, int course) =>
      _getGroups(faculty, course);

  /// Получить готовое расписание в формате
  /// ```json
  /// {
  ///   "Чётная/Нечётная": {
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
  static Future<Map<String, Map<String, List<Map<String, String>>>>?>
      getSchedule(int faculty, int course, int group) =>
          _getSchedule(faculty, course, group);
}
