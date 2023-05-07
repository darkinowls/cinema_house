import '../../repositories/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.name,
    required super.age,
    required super.trailer,
    required super.image,
    required super.smallImage,
    required super.originalName,
    required super.duration,
    required super.language,
    required super.rating,
    required super.year,
    required super.country,
    required super.genre,
    required super.plot,
    required super.starring,
    required super.director,
    required super.screenwriter,
    required super.studio,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json){
    return MovieModel(
    id : json['id'],
    name : json['name'],
    age : json['age'],
    trailer : json['trailer'],
    image : json['image'],
    smallImage : json['smallImage'],
    originalName : json['originalName'],
    duration : json['duration'],
    language : json['language'],
    rating : json['rating'],
    year : json['year'],
    country : json['country'],
    genre : json['genre'],
    plot : json['plot'],
    starring : json['starring'],
    director : json['director'],
    screenwriter : json['screenwriter'],
    studio : json['studio'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['age'] = age;
    _data['trailer'] = trailer;
    _data['image'] = image;
    _data['smallImage'] = smallImage;
    _data['originalName'] = originalName;
    _data['duration'] = duration;
    _data['language'] = language;
    _data['rating'] = rating;
    _data['year'] = year;
    _data['country'] = country;
    _data['genre'] = genre;
    _data['plot'] = plot;
    _data['starring'] = starring;
    _data['director'] = director;
    _data['screenwriter'] = screenwriter;
    _data['studio'] = studio;
    return _data;
  }
}