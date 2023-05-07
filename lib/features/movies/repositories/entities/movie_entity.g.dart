// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieEntityAdapter extends TypeAdapter<MovieEntity> {
  @override
  final int typeId = 1;

  @override
  MovieEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      age: fields[2] as int,
      trailer: fields[3] as String,
      image: fields[4] as String,
      smallImage: fields[5] as String,
      originalName: fields[6] as String,
      duration: fields[7] as int,
      language: fields[8] as String,
      rating: fields[9] as String,
      year: fields[10] as int,
      country: fields[11] as String,
      genre: fields[12] as String,
      plot: fields[13] as String,
      starring: fields[14] as String,
      director: fields[15] as String,
      screenwriter: fields[16] as String,
      studio: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovieEntity obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.trailer)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.smallImage)
      ..writeByte(6)
      ..write(obj.originalName)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.language)
      ..writeByte(9)
      ..write(obj.rating)
      ..writeByte(10)
      ..write(obj.year)
      ..writeByte(11)
      ..write(obj.country)
      ..writeByte(12)
      ..write(obj.genre)
      ..writeByte(13)
      ..write(obj.plot)
      ..writeByte(14)
      ..write(obj.starring)
      ..writeByte(15)
      ..write(obj.director)
      ..writeByte(16)
      ..write(obj.screenwriter)
      ..writeByte(17)
      ..write(obj.studio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
