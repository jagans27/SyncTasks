import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sync_tasks/bos/task_bo/task_bo.dart';
import 'package:sync_tasks/services/device/icamera_service.dart';
import 'package:sync_tasks/util/constants.dart';
part 'add_task_model.g.dart';

class AddTaskModel = _AddTaskModelBase with _$AddTaskModel;

abstract class _AddTaskModelBase with Store {
  ICameraService cameraService = GetIt.I.get<ICameraService>();

  @observable
  TaskItem task = TaskItem(
      title: "",
      description: "",
      color: TaskColor.bubblegumBlush.name,
      fromTime: "",
      toTime: "",
      image: "",
      completed: false);

  @action
  void setTask({required TaskItem task}) {
    this.task = task;
  }

  @observable
  String titleError = "";

  @action
  void setTitleError({required String titleError}) {
    this.titleError = titleError;
  }

  @observable
  String descriptionError = "";

  @action
  void setDescriptionError({required String descriptionError}) {
    this.descriptionError = descriptionError;
  }

  @observable
  String fromTimeError = "";

  @action
  void setFromTimeError({required String fromTimeError}) {
    this.fromTimeError = fromTimeError;
  }

  @observable
  String toTimeError = "";

  @action
  void setToTimeError({required String toTimeError}) {
    this.toTimeError = toTimeError;
  }
}
