import 'dart:convert';
import 'dart:io';
import 'package:sync_tasks/bos/task_bo/task_bo.dart';
import 'package:sync_tasks/screens/add_task/add_task_model.dart';
import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/util.dart';

class AddTaskVM extends AddTaskModel {
  void updateTitle({required String title}) {
    try {
      task.title = title;
    } catch (ex) {
      ex.logError();
    }
  }

  void updateDescription({required String description}) {
    try {
      task.description = description;
    } catch (ex) {
      ex.logError();
    }
  }

  void updateColor({required String color}) {
    try {
      setTask(task: task.deepCopy()..color = color);
    } catch (ex) {
      ex.logError();
    }
  }

  void updateFromTime({required String fromTime}) {
    try {
      task.fromTime = fromTime;
    } catch (ex) {
      ex.logError();
    }
  }

  void updateToTime({required String toTime}) {
    try {
      task.toTime = toTime;
    } catch (ex) {
      ex.logError();
    }
  }

  void updateImage({required String image}) {
    try {
      task.image = image;
    } catch (ex) {
      ex.logError();
    }
  }

  void isTitleValid() {
    try {
      if (task.title.length < 4) {
        setTitleError(titleError: ErrorMessage.titleErrorMessage);
      }
    } catch (ex) {
      ex.logError();
    }
  }

  void clearTitleErrorMesssage() {
    try {
      setTitleError(titleError: "");
    } catch (ex) {
      ex.logError();
    }
  }

  void isDescriptionValid() {
    try {
      if (task.description.length < 7) {
        setDescriptionError(
            descriptionError: ErrorMessage.descriptionErrorMessage);
      }
    } catch (ex) {
      ex.logError();
    }
  }

  void clearDescriptionErrorMesssage() {
    try {
      setDescriptionError(descriptionError: "");
    } catch (ex) {
      ex.logError();
    }
  }

  void isToTimeValid() {
    try {
      if (task.fromTime.isEmpty || task.toTime.isEmpty) {
        setToTimeError(toTimeError: ErrorMessage.toTimeEmptyErrorMessage);
        return;
      }

      DateTime fromTime = Util.parseTimeOfDayFormatedToDateTime(task.fromTime)
          .add(const Duration(minutes: 1));
      DateTime toTime = Util.parseTimeOfDayFormatedToDateTime(task.toTime);

      if (toTime.isBefore(fromTime)) {
        setToTimeError(toTimeError: ErrorMessage.toTimeErrorMessage);
      } else {
        setToTimeError(toTimeError: "");
      }
    } catch (ex) {
      ex.logError();
    }
  }

  void isFromTimeValid() {
    try {
      if (task.fromTime.isEmpty) {
        setFromTimeError(fromTimeError: ErrorMessage.fromTimeEmptyErrorMessage);
      } else {
        setFromTimeError(fromTimeError: "");
      }
    } catch (ex) {
      ex.logError();
    }
  }

  void addTask() {
    try {
      isTitleValid();
      isDescriptionValid();
      isFromTimeValid();
      isToTimeValid();

      if (titleError.isEmpty &&
          descriptionError.isEmpty &&
          fromTimeError.isEmpty &&
          toTimeError.isEmpty) {}
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      File? image = await cameraService.launchCamera();
      if (image != null) {
        setTask(
            task: task.deepCopy()
              ..image = await convertImageFileToBase64(image));
      }
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      File? image = await cameraService.launchSingleImagePicker();
      if (image != null) {
        setTask(
            task: task.deepCopy()
              ..image = await convertImageFileToBase64(image));
      }
    } catch (ex) {
      ex.logError();
    }
  }

  Future<String> convertImageFileToBase64(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      return base64Encode(bytes);
    } catch (ex) {
      ex.logError();
      return "";
    }
  }

  void deleteImage() {
    try {
      setTask(task: task.deepCopy()..image = "");
    } catch (ex) {
      ex.logError();
    }
  }
}
