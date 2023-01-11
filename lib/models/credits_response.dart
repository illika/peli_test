import 'dart:convert';

import 'package:app_peli/models/models.dart';

class CreditsResponse {
  CreditsResponse({required this.id, required this.cast});

  int? id;
  List<Cast> cast;

  factory CreditsResponse.fromRawJson(String str) =>
      CreditsResponse.fromJson(json.decode(str));

  factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
      CreditsResponse(
        id: json["id"],
        cast: json["cast"] == null
            ? []
            : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
      );
}
