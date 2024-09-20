// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddTaskModel on _AddTaskModelBase, Store {
  late final _$taskAtom =
      Atom(name: '_AddTaskModelBase.task', context: context);

  @override
  TaskItem get task {
    _$taskAtom.reportRead();
    return super.task;
  }

  @override
  set task(TaskItem value) {
    _$taskAtom.reportWrite(value, super.task, () {
      super.task = value;
    });
  }

  late final _$titleErrorAtom =
      Atom(name: '_AddTaskModelBase.titleError', context: context);

  @override
  String get titleError {
    _$titleErrorAtom.reportRead();
    return super.titleError;
  }

  @override
  set titleError(String value) {
    _$titleErrorAtom.reportWrite(value, super.titleError, () {
      super.titleError = value;
    });
  }

  late final _$descriptionErrorAtom =
      Atom(name: '_AddTaskModelBase.descriptionError', context: context);

  @override
  String get descriptionError {
    _$descriptionErrorAtom.reportRead();
    return super.descriptionError;
  }

  @override
  set descriptionError(String value) {
    _$descriptionErrorAtom.reportWrite(value, super.descriptionError, () {
      super.descriptionError = value;
    });
  }

  late final _$fromTimeErrorAtom =
      Atom(name: '_AddTaskModelBase.fromTimeError', context: context);

  @override
  String get fromTimeError {
    _$fromTimeErrorAtom.reportRead();
    return super.fromTimeError;
  }

  @override
  set fromTimeError(String value) {
    _$fromTimeErrorAtom.reportWrite(value, super.fromTimeError, () {
      super.fromTimeError = value;
    });
  }

  late final _$toTimeErrorAtom =
      Atom(name: '_AddTaskModelBase.toTimeError', context: context);

  @override
  String get toTimeError {
    _$toTimeErrorAtom.reportRead();
    return super.toTimeError;
  }

  @override
  set toTimeError(String value) {
    _$toTimeErrorAtom.reportWrite(value, super.toTimeError, () {
      super.toTimeError = value;
    });
  }

  late final _$_AddTaskModelBaseActionController =
      ActionController(name: '_AddTaskModelBase', context: context);

  @override
  void setTask({required TaskItem task}) {
    final _$actionInfo = _$_AddTaskModelBaseActionController.startAction(
        name: '_AddTaskModelBase.setTask');
    try {
      return super.setTask(task: task);
    } finally {
      _$_AddTaskModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitleError({required String titleError}) {
    final _$actionInfo = _$_AddTaskModelBaseActionController.startAction(
        name: '_AddTaskModelBase.setTitleError');
    try {
      return super.setTitleError(titleError: titleError);
    } finally {
      _$_AddTaskModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescriptionError({required String descriptionError}) {
    final _$actionInfo = _$_AddTaskModelBaseActionController.startAction(
        name: '_AddTaskModelBase.setDescriptionError');
    try {
      return super.setDescriptionError(descriptionError: descriptionError);
    } finally {
      _$_AddTaskModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFromTimeError({required String fromTimeError}) {
    final _$actionInfo = _$_AddTaskModelBaseActionController.startAction(
        name: '_AddTaskModelBase.setFromTimeError');
    try {
      return super.setFromTimeError(fromTimeError: fromTimeError);
    } finally {
      _$_AddTaskModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setToTimeError({required String toTimeError}) {
    final _$actionInfo = _$_AddTaskModelBaseActionController.startAction(
        name: '_AddTaskModelBase.setToTimeError');
    try {
      return super.setToTimeError(toTimeError: toTimeError);
    } finally {
      _$_AddTaskModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
task: ${task},
titleError: ${titleError},
descriptionError: ${descriptionError},
fromTimeError: ${fromTimeError},
toTimeError: ${toTimeError}
    ''';
  }
}
