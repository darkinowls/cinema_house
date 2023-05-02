import '../../domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {

  CommentModel({
    required super.id,
    required super.isMy,
    required super.author,
    required super.content,
    required super.rating,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      isMy: json['isMy'],
      author: json['author'],
      content: json['content'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['isMy'] = isMy;
    data['author'] = author;
    data['content'] = content;
    data['rating'] = rating;
    return data;
  }
}
