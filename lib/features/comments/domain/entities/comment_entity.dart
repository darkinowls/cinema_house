class CommentEntity {
  final int? id;
  final String content;
  final int rating;
  final String? author;

  CommentEntity({
    this.id,
    this.author,
    required this.content,
    required this.rating,
  });



}
