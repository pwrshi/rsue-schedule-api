part of 'rsue_schedule_api.dart';

Future<Map<String, Map<String, List<Map<String, String>>>>?> _getSchedule(
    int faculty, int course, int group) async {
  try {
    var response = await Dio().post(htmlUrl,
        data: FormData.fromMap({
          "f": faculty.toString(),
          "k": course.toString(),
          "g": group.toString()
        }));

    if (response.statusCode == 200) {
      Map<String, Map<String, List<Map<String, String>>>> schedule = {};

      List<Element>? content =
          parse(response.data.toString()).getElementById("content")?.children;

      Element? containerWeeks = content![content.length - 1];

      containerWeeks.children.asMap().forEach((idx, el) {
        if (el.className == "ned") {
          String currentWeek = el.innerHtml;

          List<Element>? week = containerWeeks.children[idx + 1].children;
          Map<String, List<Map<String, String>>> weekResult = {};

          for (var day in week) {
            String dayName = day.children[0].text;

            if (dayName != " ") {
              List<Map<String, String>> lessonsResult = [];

              day.children.asMap().forEach((idx, lesson) {
                if (idx != 0) {
                  String name = lesson.children[1].children[0].innerHtml;
                  String teacherName = lesson.children[2].children[0].innerHtml;
                  String time = lesson.children[0].children[0].text;
                  String room =
                      lesson.children[3].children[0].children[0].innerHtml;
                  String type =
                      lesson.children[3].children[1].children[0].innerHtml;
                  print("there is god");
                  lessonsResult.add({
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
          schedule[currentWeek] = weekResult;
          print("there are in ned");
        }
        print("there is outside of the");
      });
      return schedule;
    }
  } on DioError catch (error) {
    var statusCode = error.response?.statusCode;
    print(statusCode);
  }

  return null;
}
