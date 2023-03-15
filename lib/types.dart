import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:week_of_year/week_of_year.dart';
part 'types.freezed.dart';
part 'types.g.dart';

typedef DayOfWeek = int;

@JsonSerializable()
class ScheduleService {
  const ScheduleService(this.evenWeek, this.oddWeek);
  final Map<DayOfWeek, List<AbstractLesson>> evenWeek;
  final Map<DayOfWeek, List<AbstractLesson>> oddWeek;

  factory ScheduleService.fromJson(Map<String, dynamic> json) =>
      _$ScheduleServiceFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ScheduleServiceToJson(this);

  Map<DayOfWeek, List<AbstractLesson>> _getAbstractWeekByDateTime(
      DateTime date) {
    bool weekIsOdd = (date.weekOfYear % 2) != 0;
    return weekIsOdd ? oddWeek : evenWeek;
  }

  List<ConcreteLesson> generateConcreteDay(
      DateTime date, List<AbstractLesson> lessons) {
    return lessons
        .map((e) => generateConcreteLessonFromAbstract(date, e))
        .toList();
  }

  List<ConcreteLesson> getLessonsOnDay(DateTime date) {
    return generateConcreteDay(
        date, _getAbstractWeekByDateTime(date)[date.weekday] ?? []);
  }
}

@freezed
class AbstractLesson with _$AbstractLesson {
  const factory AbstractLesson(
      {required String name,
      required String teachersname,
      required String room,
      required LessonType type,
      required String time,
      String? subgroup}) = _AbstractLesson;
  factory AbstractLesson.fromJson(Map<String, Object?> json) =>
      _$AbstractLessonFromJson(json);
}

@freezed
class ConcreteLesson with _$ConcreteLesson {
  const factory ConcreteLesson(
      {required String name,
      required String teachersname,
      required DateTime startTime,
      required DateTime endTime,
      required String room,
      required LessonType type,
      String? subgroup}) = _ConcreteLesson;
  factory ConcreteLesson.fromJson(Map<String, Object?> json) =>
      _$ConcreteLessonFromJson(json);
}

enum LessonType { lab, lection, practice }

ConcreteLesson generateConcreteLessonFromAbstract(
    DateTime date, AbstractLesson abstractLesson) {
  DateTime end, start;
  switch (abstractLesson.time) {
    case "8:30 — 10:00 ":
      start = DateTime(date.year, date.month, date.day, 8, 30);
      end = DateTime(date.year, date.month, date.day, 10, 00);
      break;
    case "10:10 — 11:40 ":
      start = DateTime(date.year, date.month, date.day, 10, 10);
      end = DateTime(date.year, date.month, date.day, 11, 40);
      break;
    case "11:50 — 13:20 ":
      start = DateTime(date.year, date.month, date.day, 11, 50);
      end = DateTime(date.year, date.month, date.day, 13, 20);
      break;
    case "13:50 — 15:20 ":
      start = DateTime(date.year, date.month, date.day, 13, 50);
      end = DateTime(date.year, date.month, date.day, 15, 20);
      break;
    case "15:30 — 17:00 ":
      start = DateTime(date.year, date.month, date.day, 15, 30);
      end = DateTime(date.year, date.month, date.day, 17, 00);
      break;
    default:
      start = DateTime(date.year, date.month, date.day, 0, 0);
      end = DateTime(date.year, date.month, date.day, 0, 0);
  }
  return ConcreteLesson(
      name: abstractLesson.name,
      teachersname: abstractLesson.teachersname,
      startTime: start,
      endTime: end,
      room: abstractLesson.room,
      type: abstractLesson.type);
}
