import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_explorer_app/constants/global_variables.dart';
import 'package:webtoon_explorer_app/provider/ranking_provider.dart';
import 'package:webtoon_explorer_app/screens/components/featured_anime.dart';
import 'package:webtoon_explorer_app/screens/components/img_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(89, 33, 149, 243),
        title: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AniManga',
                style: TextStyle(
                  fontSize: 22,
                  color: GlobalVariables.appBarColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' Zone...',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<RankingProvider>(
        builder: (context, rankingProvider, child) {
          if (rankingProvider.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }
          if (rankingProvider.animesData.isNotEmpty) {
            final animes = rankingProvider.animesData.toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  ImageSlider(animes: animes, rankingProvider: rankingProvider),
                  FeaturedAnime(
                    label: 'Top Anime Series',
                    rankingType: 'all',
                    animes: animes,
                    // animeData: animes,
                  ),
                  FeaturedAnime(
                    label: 'Top Anime by Popularity',
                    rankingType: 'bypopularity',
                    animes: animes,
                  ),
                  FeaturedAnime(
                    label: 'Top Movies',
                    rankingType: 'movie',
                    animes: animes,
                  ),
                  FeaturedAnime(
                    label: 'Upcoming Anime',
                    rankingType: 'upcoming',
                    animes: animes,
                  ),
                  FeaturedAnime(
                    label: 'Top Anime Specials',
                    rankingType: 'special',
                    animes: animes,
                  ),
                  FeaturedAnime(
                    label: 'Top Anime TV Series',
                    rankingType: 'tv',
                    animes: animes,
                  ),
                ],
              ),
            );
          }
          return const Text("Error.. No Data Found");
        },
      ),
    );
  }
}
