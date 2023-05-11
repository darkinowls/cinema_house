class CommentEntity {
  final int? id;
  final String? content;
  final bool? isMy;
  final int rating;
  final String? author;

  CommentEntity({
    this.isMy,
    this.id,
    this.author,
    required this.content,
    required this.rating,
  });
}
