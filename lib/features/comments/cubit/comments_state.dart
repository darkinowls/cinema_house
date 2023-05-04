part of 'comments_cubit.dart';


@immutable
class CommentsState extends Equatable {
  final Status status;
  final Iterable<CommentEntity> comments;

  const CommentsState({
    this.status = Status.loading,
    this.comments = const [],
  });

  @override
  List<Object> get props => [status, comments];

  CommentsState copyWith({
    Status? status,
    Iterable<CommentEntity>? comments,
  }) {
    return CommentsState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
    );
  }
}
