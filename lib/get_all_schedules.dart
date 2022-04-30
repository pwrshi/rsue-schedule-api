import 'package:rsue_schedule_api/rsue_schedule_api.dart';
import 'package:rsue_schedule_api/schedule_type.dart';

import 'get_schedule.dart';
import 'get_all_groups.dart';

Future<Map<String, Schedule>?> getAllSchedules() async {
  Map<String, List<int>>? allGroups = await getAllGroups();
  if (allGroups == null) {
    throw Exception('All groups is null');
  }

  Map<String, Schedule>? allSchedules;

  for (var entry in allGroups.entries) {
    Schedule? schedule =
        await getSchedule(entry.value[0], entry.value[1], entry.value[2]);
    if (schedule == null) {
      throw Exception('Schedule for "' + entry.key + '" is null');
    }
    allSchedules![entry.key] = schedule;
  }
  return allSchedules;
}
