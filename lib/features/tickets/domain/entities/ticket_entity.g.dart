// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketEntityAdapter extends TypeAdapter<TicketEntity> {
  @override
  final int typeId = 0;

  @override
  TicketEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketEntity(
      movieId: fields[0] as int,
      name: fields[1] as String,
      dateTime: fields[2] as DateTime,
      image: fields[3] as String,
      smallImage: fields[4] as String,
      seatIndex: fields[5] as int,
      rowIndex: fields[6] as int,
      roomName: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TicketEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.movieId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.smallImage)
      ..writeByte(5)
      ..write(obj.seatIndex)
      ..writeByte(6)
      ..write(obj.rowIndex)
      ..writeByte(7)
      ..write(obj.roomName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
