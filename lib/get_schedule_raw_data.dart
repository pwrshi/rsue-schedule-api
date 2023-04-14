import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '_urls.dart';
import 'dio.dart';

// Дальше бога нет
/// Получить **сырое** расписание в формате
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
Future<Map<String, Map<String, List<Map<String, String>>>>?> getScheduleRawData(
    int faculty, int course, int group) async {
  var response = await getDio().post(htmlUrl,
      options: Options(headers: {
        "user-agent":
            "Mozilla/5.0 (X11; Linux x86_64; rv:99.0) Gecko/20100101 Firefox/99.0"
      }),
      data: FormData.fromMap({
        "f": faculty.toString(),
        "k": course.toString(),
        "g": group.toString()
      }));

  if (response.statusCode == 200) {
    Map<String, Map<String, List<Map<String, String>>>> schedule = {};

    try {
      List<Element>? content =
          parse(response.data.toString()).getElementById("content")?.children;
      Element? containerWeeks = content![content.length - 1];
      containerWeeks.children.asMap().forEach((idx, el) {
        if (el.className == "week") {
          String currentWeek = el.innerHtml;

          List<Element>? week;
          if (containerWeeks.children.length > (idx + 1)) {
            week = containerWeeks.children[idx + 1].children;
          }
          Map<String, List<Map<String, String>>> weekResult = {};

          if (week != null) {
            for (var day in week) {
              if (day.text != " ") {
                String dayName = day.children.first.innerHtml;
                List<Map<String, String>> lessonsResult = [];

                day.children.asMap().forEach((idx, lesson) {
                  if (idx != 0) {
                    String name = lesson.children[1].children[0].innerHtml;
                    String teacherName =
                        lesson.children[2].children[0].innerHtml;
                    String time = lesson.children[0].children[0].innerHtml;
                    Element subgroup =
                        lesson.children[0].children[0].children[0];
                    time = time.replaceAll(subgroup.outerHtml, "");
                    String room =
                        lesson.children[3].children[0].children[0].innerHtml;
                    String type =
                        lesson.children[3].children[1].children[0].innerHtml;
                    lessonsResult.add({
                      "subgroup": subgroup.text,
                      "name": name,
                      "teacher": teacherName,
                      "time": time,
                      "room": room,
                      "type": type,
                    });
                  }
                });
                weekResult[dayName] = lessonsResult;
              }
            }
          }
          schedule[currentWeek] = weekResult;
        }
      });
    } catch (e) {
      throw Exception("Ошибка парсинга расписания + $e");
    }

    return schedule;
  }
  throw Exception(
      "Ошибка получения расписания, код сайта: ${response.statusCode}");
}
