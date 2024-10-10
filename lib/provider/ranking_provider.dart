import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/models/anime.dart';
import 'package:webtoon_explorer_app/server/ranking_api.dart';

class RankingProvider with ChangeNotifier {
  List<Anime> animesData = [];
  bool isLoading = true;

  RankingProvider(String rankingType, int limit) {
    fetchRankingData(rankingType, limit);
  }

  Future<void> fetchRankingData(String rankingType, int limit) async {
    Iterable<Anime> _animeApi =
        await getAnimeByRankingTypeApi(rankingType: rankingType, limit: limit);
    List<Anime> temp = []; //Temporary list to avoid duplicate data....
    for (var anime in _animeApi) {
      Anime newAnime = anime;
      temp.add(newAnime);
    }
    animesData = temp;
    isLoading = false;
    notifyListeners();
  }
}
