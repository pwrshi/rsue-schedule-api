part of 'rsue_schedule_api.dart';

Future<Map<int, String>?> _getFacults() async {
  var response = await Dio().get(htmlUrl);

  if (response.statusCode == 200) {
    Map<int, String> faculty = {};

    List<Element> selects =
        parse(response.data.toString()).getElementsByTagName("select");
    Element elem = selects.first;

    elem.children.asMap().forEach(((idx, el) {
      int id = int?.tryParse(el.attributes["value"] ?? "") ?? idx;
      var value = el.text;
      faculty[id] = value;
    }));

    return faculty;
  }

  return null;
}
