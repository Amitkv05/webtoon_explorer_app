import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/local_storage/fav_storage.dart';
import 'package:webtoon_explorer_app/models/anime.dart';
import 'package:webtoon_explorer_app/server/ranking_api.dart';

class RankingProvider with ChangeNotifier {
  List<Anime> animesData = [];
  bool isLoading = true;

  RankingProvider() {
    fetchRankingData('all', 10);
  }

  Future<void> fetchRankingData(String rankingType, int limit) async {
    Iterable<Anime> _animeApi =
        await getAnimeByRankingTypeApi(rankingType: rankingType, limit: limit);
    List<String> favorite = await LocalStorage.fetchFavorite();
    List<Anime> temp = []; //Temporary list to avoid duplicate data....
    for (var anime in _animeApi) {
      Anime newAnime = anime;
      temp.add(newAnime);
      if (favorite.contains(newAnime.node!.id!)) {
        newAnime.isFavorite = true;
      }
    }
    animesData = temp;
    isLoading = false;
    notifyListeners();
  }

  Anime fetchDatabyId(String id) {
    Anime anime =
        animesData.where((element) => element.node!.id! == id).toList()[0];
    return anime;
  }

  void addFavorite(Anime fav) async {
    int indexOfAnime = animesData.indexOf(fav);
    animesData[indexOfAnime].isFavorite = true;
    await LocalStorage.addFavorite(fav.node!.id!.toString());
    notifyListeners();
  }

  void removeFavorite(Anime fav) async {
    int indexOfAnime = animesData.indexOf(fav);
    animesData[indexOfAnime].isFavorite = false;
    await LocalStorage.removeFavorite(fav.node!.id!.toString());
    notifyListeners();
  }
}
