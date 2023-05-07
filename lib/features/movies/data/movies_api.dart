import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../core/dio_client.dart';
import 'models/movie_model.dart';

class MoviesApi {
  final DioClient _dioClient;
  final String _moviesUrl = '/movies';

  MoviesApi(this._dioClient);

  Future<List<MovieModel>> getMovies() async {
    final Response response = await _dioClient.dio.get(_moviesUrl);
    return (response.data['data'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  Future<Iterable<MovieModel>> getMoviesByDate(DateTime date) async {
    Map<String, dynamic> queryParameters = {
      "date": DateFormat('yyyy-MM-dd').format(date)
    };
    final Response response =
        await _dioClient.dio.get(_moviesUrl, queryParameters: queryParameters);
    return (response.data['data'] as List).map((json) => MovieModel.fromJson(json));
  }

  Future<MovieModel> getMoviesById(int id) async {
    final Response response =
    await _dioClient.dio.get("$_moviesUrl/$id");
    return MovieModel.fromJson(response.data['data']);
  }

  Future<Iterable<MovieModel>> getMoviesByPlot(String plot) async {
    Map<String, dynamic> queryParameters = {"query": plot};
    final Response response =
        await _dioClient.dio.get(_moviesUrl, queryParameters: queryParameters);
    return (response.data['data'] as List).map((json) => MovieModel.fromJson(json));
  }
}
