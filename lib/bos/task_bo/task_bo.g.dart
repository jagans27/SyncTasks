// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_bo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskItemAdapter extends TypeAdapter<TaskItem> {
  @override
  final int typeId = 0;

  @override
  TaskItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskItem(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      color: fields[3] as String,
      fromTime: fields[4] as String,
      toTime: fields[5] as String,
      image: fields[6] as String?,
      completed: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.fromTime)
      ..writeByte(5)
      ..write(obj.toTime)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskBOAdapter extends TypeAdapter<TaskBO> {
  @override
  final int typeId = 1;

  @override
  TaskBO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskBO(
      date: fields[0] as String,
      tasks: (fields[1] as List).cast<TaskItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskBO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskBOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
