// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_manager_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskManagerModel on _TaskManagerModelBase, Store {
  late final _$tasksAtom =
      Atom(name: '_TaskManagerModelBase.tasks', context: context);

  @override
  List<TaskBO> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(List<TaskBO> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$_TaskManagerModelBaseActionController =
      ActionController(name: '_TaskManagerModelBase', context: context);

  @override
  void setTasks({required List<TaskBO> tasks}) {
    final _$actionInfo = _$_TaskManagerModelBaseActionController.startAction(
        name: '_TaskManagerModelBase.setTasks');
    try {
      return super.setTasks(tasks: tasks);
    } finally {
      _$_TaskManagerModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tasks: ${tasks}
    ''';
  }
}
