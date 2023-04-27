class Movie {
  Movie({
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
  late final int id;
  late final String name;
  late final int age;
  late final String trailer;
  late final String image;
  late final String smallImage;
  late final String originalName;
  late final int duration;
  late final String language;
  late final String rating;
  late final int year;
  late final String country;
  late final String genre;
  late final String plot;
  late final String starring;
  late final String director;
  late final String screenwriter;
  late final String studio;

  Movie.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    age = json['age'];
    trailer = json['trailer'];
    image = json['image'];
    smallImage = json['smallImage'];
    originalName = json['originalName'];
    duration = json['duration'];
    language = json['language'];
    rating = json['rating'];
    year = json['year'];
    country = json['country'];
    genre = json['genre'];
    plot = json['plot'];
    starring = json['starring'];
    director = json['director'];
    screenwriter = json['screenwriter'];
    studio = json['studio'];
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