import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sync_tasks/bos/task_bo/task_bo.dart';
import 'package:sync_tasks/services/device/camera_service/icamera_service.dart';
import 'package:sync_tasks/services/device/local_push_notification_service/ilocal_push_notification_service.dart';
import 'package:sync_tasks/services/platform/hive_service/ihive_service.dart';
import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/util.dart';

class TaskNotifier extends ChangeNotifier {
  List<TaskBO> tasks = [];
  TaskItem task = TaskItem(
      id: 0,
      title: "",
      description: "",
      color: TaskColor.bubblegumBlush.name,
      fromTime: "",
      toTime: "",
      image: null,
      completed: false);
  String titleError = "";
  String descriptionError = "";
  String fromTimeError = "";
  String toTimeError = "";
  bool isLoading = true;
  ICameraService cameraService;
  ILocalPushNotificationService localPushNotificationService;
  IHiveService hiveService;

  TaskNotifier(
      {required this.cameraService,
      required this.hiveService,
      required this.localPushNotificationService});

  void updateTitle({required String title}) {
    try {
      task.title = title;
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void updateDescription({required String description}) {
    try {
      task.description = description;
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void updateColor({required String color}) {
    try {
      task.color = color;
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void updateFromTime({required String fromTime}) {
    try {
      task.fromTime = fromTime;
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void updateToTime({required String toTime}) {
    try {
      task.toTime = toTime;
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void updateImage({required String image}) {
    try {
      task.image = image;
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void isTitleValid() {
    try {
      if (task.title.length < 4) {
        titleError = ErrorMessage.titleErrorMessage;
      } else {
        titleError = "";
      }
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void clearTitleErrorMessage() {
    try {
      titleError = "";
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void isDescriptionValid() {
    try {
      if (task.description.length < 7) {
        descriptionError = ErrorMessage.descriptionErrorMessage;
      } else {
        descriptionError = "";
      }
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void clearDescriptionErrorMessage() {
    try {
      descriptionError = "";
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void isToTimeValid() {
    try {
      if (task.toTime.isEmpty) {
        toTimeError = ErrorMessage.toTimeEmptyErrorMessage;
      } else {
        toTimeError = "";
      }
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void isFromTimeValid() {
    try {
      if (task.fromTime.isEmpty) {
        fromTimeError = ErrorMessage.fromTimeEmptyErrorMessage;
      } else {
        fromTimeError = "";
      }
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> init() async {
    try {
      await loadAllTasks();
      startListening();
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> loadAllTasks() async {
    try {
      isLoading = true;
      notifyListeners();
      tasks = await hiveService.loadAllItems<TaskBO>(HiveBoxes.taskBox.name);
      sortBasedOnDateTime();
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      ex.logError();
      isLoading = false;
      notifyListeners();
    }
  }

  void startListening() {
    hiveService.listenToHive<TaskBO>(HiveBoxes.taskBox.name).listen((_) {
      loadAllTasks();
    });
  }

  void sortBasedOnDate() {
    try {
      tasks.sort(
          (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
    } catch (ex) {
      ex.logError();
    }
  }

  void sortBasedOnDateTime() {
    try {
      sortBasedOnDate();
      for (TaskBO taskBO in tasks) {
        taskBO.sortTasksByTime();
      }
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> addTask() async {
    try {
      isTitleValid();
      isDescriptionValid();
      isFromTimeValid();
      isToTimeValid();

      if (titleError.isEmpty &&
          descriptionError.isEmpty &&
          fromTimeError.isEmpty &&
          toTimeError.isEmpty) {
        String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

        task.id = DateTime.now().millisecondsSinceEpoch.remainder(1000000000);

        TaskBO? taskBO = await hiveService.loadItem<TaskBO>(
            HiveBoxes.taskBox.name, currentDate);

        taskBO ??= TaskBO(date: currentDate, tasks: []);

        taskBO.tasks.add(task);
        await hiveService.addItem<TaskBO>(
            HiveBoxes.taskBox.name, currentDate, taskBO);

        await localPushNotificationService.scheduleNotification(
            id: task.id,
            title: task.title,
            description: task.description,
            time: Util.parseTimeOfDayFormatedToDateTime(task.fromTime),
            image: task.image);
      }
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> updateTaskStatus({required int taskId}) async {
    try {
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      TaskBO? taskBO = await hiveService.loadItem<TaskBO>(
          HiveBoxes.taskBox.name, currentDate);

      if (taskBO != null) {
        for (int i = 0; i < taskBO.tasks.length; i++) {
          if (taskBO.tasks[i].id == taskId) {
            taskBO.tasks[i].completed = !taskBO.tasks[i].completed;

            if (taskBO.tasks[i].completed) {
              await localPushNotificationService.deleteNotification(
                  id: taskBO.tasks[i].id);
            } else {
              await localPushNotificationService.deleteNotification(
                  id: taskBO.tasks[i].id);

              await localPushNotificationService.scheduleNotification(
                  id: taskBO.tasks[i].id,
                  title: taskBO.tasks[i].title,
                  description: taskBO.tasks[i].description,
                  time: Util.parseTimeOfDayFormatedToDateTime(
                      taskBO.tasks[i].fromTime),
                  image: taskBO.tasks[i].image);
            }
            break;
          }
        }

        await hiveService.addItem<TaskBO>(
            HiveBoxes.taskBox.name, currentDate, taskBO);
      }
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> deleteTask({required int taskId}) async {
    try {
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      TaskBO? taskBO = await hiveService.loadItem<TaskBO>(
          HiveBoxes.taskBox.name, currentDate);

      if (taskBO != null) {
        for (int i = 0; i < taskBO.tasks.length; i++) {
          if (taskBO.tasks[i].id == taskId) {
            await localPushNotificationService.deleteNotification(
                id: taskBO.tasks[i].id);
            taskBO.tasks.removeAt(i);
            break;
          }
        }

        if (taskBO.tasks.isEmpty) {
          await hiveService.deleteItem<TaskBO>(
              HiveBoxes.taskBox.name, currentDate);
        } else {
          await hiveService.addItem<TaskBO>(
              HiveBoxes.taskBox.name, currentDate, taskBO);
        }
      }
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      File? image = await cameraService.launchCamera();
      if (image != null) {
        task.image = await convertImageFileToBase64(image);
        notifyListeners();
      }
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      File? image = await cameraService.launchSingleImagePicker();
      if (image != null) {
        task.image = await convertImageFileToBase64(image);
        notifyListeners();
      }
    } catch (ex) {
      ex.logError();
    }
  }

  Future<String?> convertImageFileToBase64(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      return base64Encode(bytes);
    } catch (ex) {
      ex.logError();
      return null;
    }
  }

  void deleteImage() {
    try {
      task.image = null;
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void setTaskData({required TaskItem taskItem}) {
    try {
      task = TaskItem(
          id: taskItem.id,
          title: taskItem.title,
          description: taskItem.description,
          color: taskItem.color,
          fromTime: taskItem.fromTime,
          toTime: taskItem.toTime,
          image: taskItem.image,
          completed: taskItem.completed);
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> updateTask() async {
    try {
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      TaskBO? taskBO = await hiveService.loadItem<TaskBO>(
          HiveBoxes.taskBox.name, currentDate);

      if (taskBO != null) {
        for (int i = 0; i < taskBO.tasks.length; i++) {
          if (taskBO.tasks[i].id == task.id) {
            taskBO.tasks[i] = task;

            if (taskBO.tasks[i].completed) {
              await localPushNotificationService.deleteNotification(
                  id: taskBO.tasks[i].id);
            } else {
              await localPushNotificationService.deleteNotification(
                  id: taskBO.tasks[i].id);

              await localPushNotificationService.scheduleNotification(
                  id: taskBO.tasks[i].id,
                  title: taskBO.tasks[i].title,
                  description: taskBO.tasks[i].description,
                  time: Util.parseTimeOfDayFormatedToDateTime(
                      taskBO.tasks[i].fromTime),
                  image: taskBO.tasks[i].image);
            }

            break;
          }
        }

        await hiveService.addItem<TaskBO>(
            HiveBoxes.taskBox.name, currentDate, taskBO);
      }
    } catch (ex) {
      ex.logError();
    }
  }

  void clearAddTaskScreenData() {
    try {
      task = TaskItem(
          id: 0,
          title: "",
          description: "",
          color: TaskColor.bubblegumBlush.name,
          fromTime: "",
          toTime: "",
          image: null,
          completed: false);
      titleError = "";
      descriptionError = "";
      fromTimeError = "";
      toTimeError = "";
    } catch (ex) {
      ex.logError();
    }
  }
}
