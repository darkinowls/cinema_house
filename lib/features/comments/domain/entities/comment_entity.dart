class CommentEntity {
  final String content;
  final int? id;
  final int rating;
  final String? author;

  CommentEntity({
    this.id,
    this.author,
    required this.content,
    required this.rating,
  });

  CommentEntity.createInForm({
    this.id,
    required this.author,
    required this.content,
    required this.rating,
  });

}
