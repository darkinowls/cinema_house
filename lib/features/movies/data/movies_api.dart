import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../core/dio_client.dart';
import 'models/movie.dart';

class MoviesApi {
  final DioClient _dioClient;
  final String _moviesUrl = '/movies';

  MoviesApi(this._dioClient);

  Future<List<Movie>> getMovies() async {
    final Response response = await _dioClient.dio.get(_moviesUrl);
    return (response.data['data'] as List)
        .map((json) => Movie.fromJson(json))
        .toList();
  }

  Future<Iterable<Movie>> getMoviesByDate(DateTime date) async {
    Map<String, dynamic> queryParameters = {
      "date": DateFormat('yyyy-MM-dd').format(date)
    };
    final Response response =
        await _dioClient.dio.get(_moviesUrl, queryParameters: queryParameters);
    return (response.data['data'] as List).map((json) => Movie.fromJson(json));
  }

  Future<Iterable<Movie>> getMoviesByPlot(String plot) async {
    Map<String, dynamic> queryParameters = {"query": plot};
    final Response response =
        await _dioClient.dio.get(_moviesUrl, queryParameters: queryParameters);
    return (response.data['data'] as List).map((json) => Movie.fromJson(json));
  }
}
