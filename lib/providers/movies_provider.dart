import 'package:app_peli/models/models.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "f8bc1c30f49e11fb67af22e8d20dc59e";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";

  int _popularPage = 0;

  List<Movie> onDisplayMovie = [];
  List<Movie> onPopularMovie = [];

  MoviesProvider() {
    getOnDisplayMovies();
    getOnPoularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(
      _baseUrl,
      endpoint,
      {'api_key': _apiKey, 'language': _language, 'page': '$page'},
    );

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final response = await _getJsonData('3/movie/now_playing');
    final nowPayingResponse = NowPlayingResponse.fromRawJson(response);
    onDisplayMovie = nowPayingResponse.results;

    notifyListeners();
  }

  getOnPoularMovies() async {
    _popularPage++;
    final response = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromRawJson(response);
    onPopularMovie = [...onPopularMovie, ...popularResponse.results];

    notifyListeners();
  }
}
