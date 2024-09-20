import 'package:sync_tasks/bos/task_bo/task_bo.dart';
import 'package:sync_tasks/screens/task_manager/task_manager_model.dart';
import 'package:sync_tasks/util/extensions.dart';

class TaskManagerVM extends TaskManagerModel {
  TaskManagerVM() {
    try {
        setTasks(tasks: [
        TaskBO(
          date: "2024-09-21",
          tasks: [
            TaskItem(
              title: "Meeting With Ramesh",
              description: "Sample Description of more than 100 words",
              color: "bubblegumBlush",
              fromTime: "10:30 AM",
              toTime: "12:00 AM",
              image: "",
              completed: false,
            ),
            TaskItem(
              title: "Meeting With Ramesh",
              description: "Sample Description of more than 100 words",
              color: "bubblegumBlush",
              fromTime: "10:30 AM",
              toTime: "12:00 AM",
              completed: false,
              image: "",
            ),
            TaskItem(
              completed: true,
              title: "Meeting With Ramesh",
              description: "Sample Description of more than 100 words",
              color: "bubblegumBlush",
              fromTime: "10:30 AM",
              toTime: "12:00 AM",
              image:
                  "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
            ),
          ],
        ),
        TaskBO(
          date: "2024-09-20",
          tasks: [
            TaskItem(
              completed: false,
              title: "Design Review",
              description: "Discuss UI mockups with the team",
              color: "lavenderMist",
              fromTime: "10:30 AM",
              toTime: "12:00 AM",
              image:
                  "https://fastly.picsum.photos/id/1/5000/3333.jpg?hmac=7Xr8lqZ2gWvPZ1YJqLsGQ1x2yK5b7vX9mZz9X5YQZzE",
            ),
            TaskItem(
              completed: false,
              title: "Design Review",
              description: "Discuss UI mockups with the team",
              color: "lavenderMist",
              fromTime: "10:30 AM",
              toTime: "12:00 AM",
              image:
                  "https://fastly.picsum.photos/id/1/5000/3333.jpg?hmac=7Xr8lqZ2gWvPZ1YJqLsGQ1x2yK5b7vX9mZz9X5YQZzE",
            ),
          ],
        ),
        TaskBO(
          date: "2024-09-16",
          tasks: [
            TaskItem(
              completed: true,
              title: "Design Review",
              description: "Discuss UI mockups with the team",
              color: "lavenderMist",
              fromTime: "10:30 AM",
              toTime: "12:00 AM",
              image:
                  "https://fastly.picsum.photos/id/1/5000/3333.jpg?hmac=7Xr8lqZ2gWvPZ1YJqLsGQ1x2yK5b7vX9mZz9X5YQZzE",
            ),
            TaskItem(
              completed: true,
              title: "Design Review",
              description: "Discuss UI mockups with the team",
              color: "lavenderMist",
              fromTime: "10:30 AM",
              toTime: "12:00 AM",
              image:
                  "https://fastly.picsum.photos/id/1/5000/3333.jpg?hmac=7Xr8lqZ2gWvPZ1YJqLsGQ1x2yK5b7vX9mZz9X5YQZzE",
            ),
            TaskItem(
              completed: true,
              title: "Design Review",
              description: "Discuss UI mockups with the team",
              color: "lavenderMist",
              fromTime: "10:30 AM",
              toTime: "12:00 AM",
              image:
                  "https://fastly.picsum.photos/id/1/5000/3333.jpg?hmac=7Xr8lqZ2gWvPZ1YJqLsGQ1x2yK5b7vX9mZz9X5YQZzE",
            ),
            TaskItem(
              completed: true,
              title: "Design Review",
              description: "Discuss UI mockups with the team",
              color: "lavenderMist",
              fromTime: "10:30 AM",
              toTime: "12:00 AM",
              image:
                  "https://fastly.picsum.photos/id/1/5000/3333.jpg?hmac=7Xr8lqZ2gWvPZ1YJqLsGQ1x2yK5b7vX9mZz9X5YQZzE",
            ),
            TaskItem(
              completed: true,
              title: "Design Review",
              description: "Discuss UI mockups with the team",
              color: "lavenderMist",
              fromTime: "10:30 AM",
              toTime: "12:00 AM",
              image: "",
            ),
          ],
        ),
      ]);
    } catch (ex) {
      ex.logError();
    }
  }
}
