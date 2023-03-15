import 'package:rsue_schedule_api/rsue_schedule_api.dart';

Future<Map<String, ScheduleService?>?> getAllSchedules() async {
  Map<String, List<int>>? allGroups = await getAllGroups();
  if (allGroups == null) {
    throw Exception('All groups is null');
  }

  Map<String, ScheduleService?>? allSchedules = {};

  for (var entry in allGroups.entries) {
    ScheduleService? schedule;
    try {
      schedule =
          await getSchedule(entry.value[0], entry.value[1], entry.value[2]);
    } catch (e) {
      schedule = null;
    }

    // if (schedule == null) {
    //   throw Exception('Schedule for "' + entry.key + '" is null');
    // }
    allSchedules[entry.key] = schedule;
  }
  return allSchedules;
}
