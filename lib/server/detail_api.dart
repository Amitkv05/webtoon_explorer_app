import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:webtoon_explorer_app/models/animeDetail.dart';

Future<AnimeDetails> getAnimeByDetailTypeApi({
  required int? id,
}) async {
  final Url =
      'https://api.myanimelist.net/v2/anime/$id?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics';

  final response = await http.get(Uri.parse(Url), headers: {
    'X-MAL-CLIENT-ID': "c3dcf0c7928fdc08b1454d31208f9feb",
  });
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final animeDetail = AnimeDetails.fromJson(data);
    // print('getting data');
    return animeDetail;
  } else {
    debugPrint("Error:${response.statusCode}");
    debugPrint("Body:${response.statusCode}");
    throw Exception("Failed to get Data!");
  }
}
