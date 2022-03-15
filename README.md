# Библиотека для удобного общения с API расписания РГЭУ (РИНХ)

Единственный класс ScheduleAPI имеет несколько статичных методов:

## Получить список факультетов
```dart
  static Future<Map<int, String>?> getFacults()
```
## Получить список курсов на факультете
```dart
  static Future<Map<int, String>?> getCourses(int faculty)
```
## Получить список групп курса факультета
```dart
  static Future<Map<int, String>?> getGroups(int faculty, int course)
```
### Получить расписание по факультету, курсу группе
```dart
  static Future<Map<String, Map<String, List<Map<String, String>>>>?>
      getSchedule(int faculty, int course, int group)
```
Формат расписания:
```json
{
"Чётная/Нечётная": {
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
