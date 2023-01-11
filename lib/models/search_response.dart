import 'dart:convert';

import 'package:app_peli/models/models.dart';

class SearchMovieResponse {
  SearchMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory SearchMovieResponse.fromRawJson(String str) =>
      SearchMovieResponse.fromJson(json.decode(str));

  factory SearchMovieResponse.fromJson(Map<String, dynamic> json) =>
      SearchMovieResponse(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<Movie>.from(json["results"]!.map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
