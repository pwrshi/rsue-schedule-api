part of 'rsue_schedule_api.dart';

Future<Map<int, String>?> _getCourses(int faculty) async {
  var response = await Dio().post(
    queryUrl,
    data:
        FormData.fromMap({"query": "getKinds", "type_id": faculty.toString()}),
  );

  if (response.statusCode == 200) {
    Map<int, String> courses = {};
    List date = jsonDecode(response.data.toString());

    for (var el in date) {
      courses[el["kind_id"]] = el["kind"];
    }

    return courses;
  }

  return null;
}
