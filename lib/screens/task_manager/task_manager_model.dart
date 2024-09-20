import 'package:mobx/mobx.dart';
import 'package:sync_tasks/bos/task_bo/task_bo.dart';
part 'task_manager_model.g.dart';

class TaskManagerModel = _TaskManagerModelBase with _$TaskManagerModel;

abstract class _TaskManagerModelBase with Store {
  @observable
  List<TaskBO> tasks = [];

  @action
  void setTasks({required List<TaskBO> tasks}) {
    this.tasks = tasks;
  }
}
