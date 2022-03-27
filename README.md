# Библиотека для удобного общения с API расписания РГЭУ (РИНХ)

ScheduleAPI имеет несколько методов:
## Получить расписание в удобном для работы виде
```dart
static Future<Schedule?> getSchedule(
      int faculty, int course, int group)
```

## Список факультетов
```dart
  static Future<Map<int, String>?> getFacults()
```
## Список курсов на факультете
```dart
  static Future<Map<int, String>?> getCourses(int faculty)
```
## Список групп курса факультета
```dart
  static Future<Map<int, String>?> getGroups(int faculty, int course)
```
## Список групп со всех факультетов, курсов
```dart
  static Future<Map<String, Map<String, int>>?> getAllGroups()
```
Список групп предоставляется в формате
```dart
  {
    "Группа": {
      "f": номер факультета
      "c": номер курса
      "g": номер группа
    }
  } 
```
## Расписание по факультету, курсу группе в чистом, структурном формате
```dart
  static Future<Map<String, Map<String, List<Map<String, String>>>>?>
      getScheduleRaw(int faculty, int course, int group)
```
Формат расписания:
```dart
{
"Четная/Нечетная неделя": {
    "День недели": [
        {
            "name": "Дисциплина",
            "teacher": "Преподаватель",
            "time": "Время занятия",
            "room": "Кабинет",
            "type": "Лабораторная/Практика/Лекция",
        }
    ]
    }
}
```
