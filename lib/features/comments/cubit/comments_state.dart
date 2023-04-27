part of 'comments_cubit.dart';

enum CommentsStatus { waiting, loading, loaded }

@immutable
class CommentsState extends Equatable {
  final CommentsStatus status;
  final Iterable<CommentEntity> comments;

  const CommentsState({
    this.status = CommentsStatus.waiting,
    this.comments = const [],
  });

  @override
  List<Object> get props => [status, comments];

  CommentsState copyWith({
    CommentsStatus? status,
    Iterable<CommentEntity>? comments,
  }) {
    return CommentsState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
    );
  }
}
