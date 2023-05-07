

import 'package:hive/hive.dart';

part 'movie_entity.g.dart';

@HiveType(typeId: 1)
class MovieEntity {

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final String trailer;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final String smallImage;
  @HiveField(6)
  final String originalName;
  @HiveField(7)
  final int duration;
  @HiveField(8)
  final String language;
  @HiveField(9)
  final String rating;
  @HiveField(10)
  final int year;
  @HiveField(11)
  final String country;
  @HiveField(12)
  final String genre;
  @HiveField(13)
  final String plot;
  @HiveField(14)
  final String starring;
  @HiveField(15)
  final String director;
  @HiveField(16)
  final String screenwriter;
  @HiveField(17)
  final String studio;

  const MovieEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.trailer,
    required this.image,
    required this.smallImage,
    required this.originalName,
    required this.duration,
    required this.language,
    required this.rating,
    required this.year,
    required this.country,
    required this.genre,
    required this.plot,
    required this.starring,
    required this.director,
    required this.screenwriter,
    required this.studio,
  });
}
