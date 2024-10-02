import 'package:hive/hive.dart';
import 'package:sync_tasks/util/util.dart';
part 'task_bo.g.dart';

@HiveType(typeId: 0)
class TaskItem {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String color;
  @HiveField(4)
  String fromTime;
  @HiveField(5)
  String toTime;
  @HiveField(6)
  String? image;
  @HiveField(7)
  bool completed;

  TaskItem({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.fromTime,
    required this.toTime,
    required this.image,
    required this.completed,
  });

  DateTime get fromTimeAsDateTime {
    return Util.parseTimeOfDayFormatedToDateTime(fromTime);
  }
}

@HiveType(typeId: 1)
class TaskBO {
  @HiveField(0)
  String date;
  @HiveField(1)
  List<TaskItem> tasks;

  TaskBO({
    required this.date,
    required this.tasks,
  });

  void sortTasksByTime() {
    tasks.sort((a, b) => b.fromTimeAsDateTime.compareTo(a.fromTimeAsDateTime));
  }
}
