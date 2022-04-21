# Библиотека для удобного общения с API расписания РГЭУ (РИНХ)
## Как начать использовать
Так как этот пакет отсутсвует в pub-е то его нужно подключать прямо с git. Просто допишите в pubspec.yaml следущее:
```yaml
dependencies:
  ...
  rsue_schedule_api:
    git:
      url: https://github.com/pwrshi/rsue-schedule-api.git
  ...
```
и теперь можете смело писать в заголовках
```dart
import 'package:rsue_schedule_api/rsue_schedule_api.dart';
```
## Получить инстанс расписания
```dart
Future<Schedule?> getSchedule(int faculty, int course, int group)
```
Структура **Schedule** на примере ПРИ-312:

![Структура класса Schedule](https://github.com/pwrshi/rsue-schedule-api/raw/main/assets/schedule.jpg)

В этой структуре имеется поле `Map schedule`, оно содержит два расписания: на четную и нечетную неделю. По этим ключам мы получим Массив с ключами Дней (**Day**) со следущей структурой:
![Структура классов Day и Subject](https://github.com/pwrshi/rsue-schedule-api/raw/main/assets/day_and_subject.jpg)

Здесь же можно и увидеть структуру ещё одного класса **Subject**

Классы **Schedule**, **Day** и **Subject** могут спокойно преобразовываться в json, и создоваться из него. Пример:

```dart
Schedule? sch = await getSchedule(3, 1, 8);

String str = sch.toJson();

Schedule? schRestored = Schedule.fromJson(str);
```

## Получить список факультетов, курсов, групп
Здесь всё просто, просто вызываем соответствующию функцию для получения по иерархии:
Факультет->Курс->Группа
```dart
Map<int, String>? fs = await getFacults();

// Переменная f - это id вашего факультета
Map<int, String>? cs = await getCourses(f);

// Переменные f и g - это id вашего факультета
// и курса соответственно
Map<int, String>? gs = await getGroups(f, c);
```
Пример исполнения:
```dart
await getGroups(3, 1)
```
![Вывод групп первого курс КТиИБ](https://github.com/pwrshi/rsue-schedule-api/raw/main/assets/groups.jpg)

## А если я хочу получить все группы всех курсов всех факультетов
Для этого существует функция *getAllGroups*
Она выдаеёт нечто подобное:

![Вывод всевозможных групп](https://github.com/pwrshi/rsue-schedule-api/raw/main/assets/all_groups.jpg)

где *f*, *c* и *g* - id факультета, курса и группы соответственно