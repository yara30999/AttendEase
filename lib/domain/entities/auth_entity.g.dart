// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthenticationEntityAdapter extends TypeAdapter<AuthenticationEntity> {
  @override
  final int typeId = 0;

  @override
  AuthenticationEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthenticationEntity(
      id: fields[3] as String,
      name: fields[0] as String,
      email: fields[1] as String,
      role: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthenticationEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
