import '../../domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {

  CommentModel({
    required super.id,
    required super.author,
    required super.content,
    required super.rating,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      author: json['author'],
      content: json['content'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author;
    data['content'] = content;
    data['rating'] = rating;
    return data;
  }
}
