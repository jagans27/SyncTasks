class TaskBO {
  String date;
  List<TaskItem> tasks;
  TaskBO({required this.date, required this.tasks});
}

class TaskItem {
  String title;
  String description;
  String color;
  String fromTime;
  String toTime;
  String image;
  bool completed;
  TaskItem(
      {required this.title,
      required this.description,
      required this.color,
      required this.fromTime,
      required this.toTime,
      required this.image,
      required this.completed});
}

// Extension to create a deep copy of TaskItem
extension TaskItemCopy on TaskItem {
  TaskItem deepCopy() {
    return TaskItem(
      title: title,
      description: description,
      color: color,
      fromTime: fromTime,
      toTime: toTime,
      image: image,
      completed: completed,
    );
  }
}
