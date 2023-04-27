import 'package:cinema_house/features/comments/data/models/add_comment_model.dart';
import 'package:cinema_house/features/comments/domain/entities/comment_entity.dart';

import '../../data/repositories/i_comments_repository.dart';

class CommentsRepository extends ICommentsRepository {
  CommentsRepository(super.commentsApi);

  @override
  Future<bool> addCommentToMovie(
      CommentEntity commentEntity, int movieId) async {
    AddCommentModel addCommentModel = AddCommentModel(
        content: commentEntity.content,
        rating: commentEntity.rating,
        movieId: movieId);
    return await super.commentsApi.addComment(addCommentModel);
  }

  @override
  Future<Iterable<CommentEntity>> getCommentsByMovieId(int movieId) async {
    return await super.commentsApi.getCommentsByMovieId(movieId.toString());
  }

  @override
  Future<bool> removeComment(CommentEntity commentEntity) async {
    return await super
        .commentsApi
        .removeCommentById(commentEntity.id.toString());
  }
}
