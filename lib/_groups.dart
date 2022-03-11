part of 'rsue_schedule_api.dart';

Future<Map<int, String>?> _getGroups(int faculty, int course) async {
  var response = await Dio().post(
    queryUrl,
    data: FormData.fromMap({
      "query": "getCategories",
      "type_id": faculty.toString(),
      "kind_id": course.toString()
    }),
  );

  if (response.statusCode == 200) {
    Map<int, String> groups = {};
    List date = jsonDecode(response.data.toString());

    for (var el in date) {
      groups[el["category_id"]] = el["category"];
    }

    return groups;
  }

  return null;
}
