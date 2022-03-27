part of 'rsue_schedule_api.dart';

class Subject {
  Subject(Map<String, String> raw) {
    room = raw["room"] ?? ":(";
    teacher = raw["teacher"] ?? ":(";
    time = raw["time"] ?? ":(";
    name = raw["name"] ?? ":(";
    type = raw["type"] ?? ":(";
  }
  late final String name;
  late final String teacher;
  late final String time;
  late final String room;
  late final String type;
}

class Day {
  late final String weekdayName;
  late final int ofWeek;
  late final List<Subject> subjects;
  Day(this.weekdayName, List<Map<String, String>> raw) {
    subjects = raw.map((e) => Subject(e)).toList();
    switch (weekdayName) {
      case "Понедельник":
        ofWeek = 1;
        break;
      case "Вторник":
        ofWeek = 2;
        break;
      case "Среда":
        ofWeek = 3;
        break;
      case "Четверг":
        ofWeek = 4;
        break;
      case "Пятница":
        ofWeek = 5;
        break;
      case "Суббота":
        ofWeek = 6;
        break;
      case "Воскресенье":
        ofWeek = 7;
        break;
      default:
        ofWeek = -1;
        break;
    }
  }
}

class Schedule {
  late final String json;
  String toJSON() {
    return json;
  }

  Schedule(Map<String, Map<String, List<Map<String, String>>>> raw) {
    json = jsonEncode(raw);
    schedule = raw.map((key, value) {
      return MapEntry(key, value.map(((keyday, valueday) {
        var day = Day(keyday, valueday);
        return MapEntry(day.ofWeek, day);
      })));
    });
  }

  late final Map<String, Map<int, Day>> schedule;

  /// Возвращает расписание на неделю, учитывая какая сейчас неделя,
  /// чётная или нечетная
  Day? onDay(DateTime date) {
    return ((date.weekOfYear % 2) != 0
        ? schedule["Нечетная неделя"]![date.weekday]
        : schedule["Четная неделя"]![date.weekday]);
  }

  onDayByISO8106(String name) {}
}
