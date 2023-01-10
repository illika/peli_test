import 'package:app_peli/models/models.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "f8bc1c30f49e11fb67af22e8d20dc59e";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";

  List<Movie> onDisplayMovie = [];
  List<Movie> onPopularMovie = [];

  MoviesProvider() {
    getOnDisplayMovies();
    getOnPoularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(
      _baseUrl,
      '3/movie/now_playing',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '1',
      },
    );

    final response = await http.get(url);
    final nowPayingResponse = NowPlayingResponse.fromRawJson(response.body);
    onDisplayMovie = nowPayingResponse.results;

    notifyListeners();
  }

  getOnPoularMovies() async {
    var url = Uri.https(
      _baseUrl,
      '3/movie/popular',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '1',
      },
    );

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromRawJson(response.body);
    onPopularMovie = [...onPopularMovie, ...popularResponse.results];

    notifyListeners();
  }
}
