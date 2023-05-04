import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/status.dart';
import '../data/repositories/i_comments_repository.dart';
import '../domain/entities/comment_entity.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final ICommentsRepository _commentsRepository;

  CommentsCubit(this._commentsRepository) : super(const CommentsState());

  void loadComments(int movieId) async {
    emit(state.copyWith(status: Status.loading));
    Iterable<CommentEntity> comments =
        await _commentsRepository.getCommentsByMovieId(movieId);
    emit(state.copyWith(status: Status.loaded, comments: comments));
  }

  void addComment(
      {required String content,
      required int rating,
      required int movieId}) async {
    final CommentEntity commentEntity =
        CommentEntity(content: content, rating: rating);
    bool success =
        await _commentsRepository.addCommentToMovie(commentEntity, movieId);
    if (success) {
      loadComments(movieId);
    }
  }

  void removeComment(CommentEntity comment) async {
    bool success = await _commentsRepository.removeComment(comment);
    if (success) {
      emit(state.copyWith(
          comments:
              state.comments.where((element) => element.id != comment.id)));
    }
  }
}
