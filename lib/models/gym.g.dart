// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GymAdapter extends TypeAdapter<Gym> {
  @override
  final int typeId = 0;

  @override
  Gym read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Gym(
      id: fields[1] as int,
      fullname: fields[2] as String,
      monthType: fields[3] as int,
      registerdate: fields[4] as String,
      expiredate: fields[5] as String,
      price: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Gym obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.fullname)
      ..writeByte(3)
      ..write(obj.monthType)
      ..writeByte(4)
      ..write(obj.registerdate)
      ..writeByte(5)
      ..write(obj.expiredate)
      ..writeByte(6)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GymAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
