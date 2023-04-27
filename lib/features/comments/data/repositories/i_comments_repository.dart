import 'package:cinema_house/features/comments/data/comments_api.dart';
import 'package:cinema_house/features/comments/domain/entities/comment_entity.dart';

abstract class ICommentsRepository {
  final CommentsApi commentsApi;

  ICommentsRepository(this.commentsApi);

  Future<Iterable<CommentEntity>> getCommentsByMovieId(int movieId);

  Future<bool> addCommentToMovie(CommentEntity commentEntity, int movieId);

  Future<bool> removeComment(CommentEntity commentEntity);
}
