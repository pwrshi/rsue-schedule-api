import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:dio/dio.dart';

part '_urls.dart';
part '_facults.dart';
part '_courses.dart';
part '_groups.dart';
part '_all_groups.dart';
part '_schedule.dart';

// INFO: В методах отсчёт начинается с 1, т.к. в формочках самого ринха,
// они тоже начинаются с 1

/// Общение с API расписания РИНХа
class ScheduleAPI {
  /// Номер факультета
  //late final UnsignedInt faculty;

  /// Номер курса
  //late final UnsignedInt course;

  /// Номер курса
  //late final UnsignedInt group;

  /// Создаёт экземпляр API По факультету, курсу, группе
  // ScheduleAPI(
  //     {required this.faculty, required this.course, required this.group});

  /// Получить список факультетов
  static Future<Map<int, String>?> getFacults() => _getFacults();

  /// Получить список курсов ао факультету
  static Future<Map<int, String>?> getCourses(int faculty) =>
      _getCourses(faculty);

  /// Получить список групп, по факультету и курсу
  static Future<Map<int, String>?> getGroups(int faculty, int course) =>
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
  static Future<Map<String, Map<String, int>>?> getAllGroups() =>
      _getAllGroups();

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
  static Future<Map<String, Map<String, List<Map<String, String>>>>?>
      getSchedule(int faculty, int course, int group) =>
          _getSchedule(faculty, course, group);
}
