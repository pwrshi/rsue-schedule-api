// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleService _$ScheduleServiceFromJson(Map<String, dynamic> json) =>
    ScheduleService(
      (json['evenWeek'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k),
            (e as List<dynamic>)
                .map((e) => AbstractLesson.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      (json['oddWeek'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k),
            (e as List<dynamic>)
                .map((e) => AbstractLesson.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$ScheduleServiceToJson(ScheduleService instance) =>
    <String, dynamic>{
      'evenWeek': instance.evenWeek.map((k, e) => MapEntry(k.toString(), e)),
      'oddWeek': instance.oddWeek.map((k, e) => MapEntry(k.toString(), e)),
    };

_$_AbstractLesson _$$_AbstractLessonFromJson(Map<String, dynamic> json) =>
    _$_AbstractLesson(
      name: json['name'] as String,
      teachersname: json['teachersname'] as String,
      room: json['room'] as String,
      type: $enumDecode(_$LessonTypeEnumMap, json['type']),
      time: json['time'] as String,
      subgroup: json['subgroup'] as String?,
    );

Map<String, dynamic> _$$_AbstractLessonToJson(_$_AbstractLesson instance) =>
    <String, dynamic>{
      'name': instance.name,
      'teachersname': instance.teachersname,
      'room': instance.room,
      'type': _$LessonTypeEnumMap[instance.type]!,
      'time': instance.time,
      'subgroup': instance.subgroup,
    };

const _$LessonTypeEnumMap = {
  LessonType.lab: 'lab',
  LessonType.lection: 'lection',
  LessonType.practice: 'practice',
};

_$_ConcreteLesson _$$_ConcreteLessonFromJson(Map<String, dynamic> json) =>
    _$_ConcreteLesson(
      name: json['name'] as String,
      teachersname: json['teachersname'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      room: json['room'] as String,
      type: $enumDecode(_$LessonTypeEnumMap, json['type']),
      subgroup: json['subgroup'] as String?,
    );

Map<String, dynamic> _$$_ConcreteLessonToJson(_$_ConcreteLesson instance) =>
    <String, dynamic>{
      'name': instance.name,
      'teachersname': instance.teachersname,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'room': instance.room,
      'type': _$LessonTypeEnumMap[instance.type]!,
      'subgroup': instance.subgroup,
    };
