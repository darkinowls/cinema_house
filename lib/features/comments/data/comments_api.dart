import 'package:cinema_house/features/comments/data/models/comment_model.dart';
import 'package:dio/dio.dart';

import '../../../core/dio_client.dart';
import 'models/add_comment_model.dart';

class CommentsApi {
  final DioClient _dioClient;
  final String _commentsUrl = '/movies/comments';

  CommentsApi(this._dioClient);

  Future<Iterable<CommentModel>> getCommentsByMovieId(String movieId) async {
    final Response response = await _dioClient.dio
        .get(_commentsUrl, queryParameters: {"movieId": movieId});
    return (response.data['data'] as List)
        .map((json) => CommentModel.fromJson(json));
  }

  Future<bool> addComment(AddCommentModel addCommentModel) async {
    FormData formData = FormData.fromMap(addCommentModel.toJson()); // to Json
    final Response response =
        await _dioClient.dio.post(_commentsUrl, data: formData);
    return response.data['success'];
  }

  Future<bool> removeCommentById(String commentId) async {
    final Response response =
      await _dioClient.dio.delete("$_commentsUrl/$commentId");
    return response.data['success'];
  }

}
