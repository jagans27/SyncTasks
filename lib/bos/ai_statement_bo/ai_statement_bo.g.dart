// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_statement_bo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AIStatementBOAdapter extends TypeAdapter<AIStatementBO> {
  @override
  final int typeId = 2;

  @override
  AIStatementBO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AIStatementBO(
      date: fields[0] as String,
      statement: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AIStatementBO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.statement);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIStatementBOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
