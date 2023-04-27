import '../../domain/entities/comment_entity.dart';

class AddCommentModel extends CommentEntity {
  final int? movieId;

  AddCommentModel(
      {required super.content, required super.rating, required this.movieId});

  factory AddCommentModel.fromJson(Map<String, dynamic> json) {
    return AddCommentModel(
      content: json['content'],
      rating: json['rating'],
      movieId: json['movieId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['rating'] = rating;
    data['movieId'] = movieId;
    return data;
  }
}
