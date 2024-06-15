// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeman_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemanDetaisAdapter extends TypeAdapter<PokemanDetais> {
  @override
  final int typeId = 1;

  @override
  PokemanDetais read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemanDetais(
      name: fields[0] as String,
      id: fields[6] as int,
      image: fields[1] as String,
      types: (fields[2] as List).cast<dynamic>(),
      height: fields[4] as int,
      weight: fields[5] as int,
      base_stats: (fields[3] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, PokemanDetais obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.types)
      ..writeByte(3)
      ..write(obj.base_stats)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemanDetaisAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
