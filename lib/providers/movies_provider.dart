import 'dart:async';

import 'package:app_peli/helpers/debouncer.dart';
import 'package:app_peli/models/models.dart';
import 'package:app_peli/models/search_response.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "f8bc1c30f49e11fb67af22e8d20dc59e";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";

  int _popularPage = 0;

  Map<int, List<Cast>> moviesCast = {};

  List<Movie> onDisplayMovie = [];
  List<Movie> onPopularMovie = [];
  List<Cast> onCastMovie = [];

  final StreamController<List<Movie>> _streamController =
      StreamController.broadcast();

  Stream<List<Movie>> get listMovies => _streamController.stream;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  MoviesProvider() {
    getOnDisplayMovies();
    getOnPoularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(
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

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final response = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromRawJson(response);
    onCastMovie = creditsResponse.cast;
    moviesCast[movieId] = onCastMovie;
    return onCastMovie;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(
      _baseUrl,
      '3/search/movie',
      {'api_key': _apiKey, 'language': _language, 'query': query},
    );

    final response = await http.get(url);
    final movieSearch = SearchMovieResponse.fromRawJson(response.body);
    return movieSearch.results;
  }

  void getSuggestionsByQuery(String searchQuery) {
    //debouncer.value = '';
    debouncer.value = searchQuery;
    debouncer.onValue = (value) async {
      debugPrint("a buscar $searchQuery");

      final result = await searchMovie(searchQuery);
      _streamController.add(result);
    };

    /*
    debouncer.value = searchQuery;
    final timer = Timer.periodic(const Duration(milliseconds: 300), (value) {
      debouncer.value = searchQuery;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((value) => timer.cancel());
    */
  }
}
