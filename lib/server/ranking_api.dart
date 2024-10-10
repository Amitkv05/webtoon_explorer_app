import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webtoon_explorer_app/models/anime.dart';
import "package:http/http.dart" as http;

Future<Iterable<Anime>> getAnimeByRankingTypeApi({
  required String rankingType,
  required int limit,
}) async {
  final Url =
      'https://api.myanimelist.net/v2/anime/ranking?ranking_type=$rankingType&limit=$limit';

  final response = await http.get(Uri.parse(Url), headers: {
    'X-MAL-CLIENT-ID': "c3dcf0c7928fdc08b1454d31208f9feb",
  });
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> animeNodeList = data['data'];
    final animes = animeNodeList
        .where((animeNode) => animeNode['node']['main_picture'] != null)
        .map((node) => Anime.fromJson(node));
    // print('getting data');
    return animes;
  } else {
    debugPrint("Error:${response.statusCode}");
    debugPrint("Body:${response.statusCode}");
    throw Exception("Failed to get Data!");
  }
}
