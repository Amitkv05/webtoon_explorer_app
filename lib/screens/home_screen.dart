import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_explorer_app/constants/global_variables.dart';
import 'package:webtoon_explorer_app/provider/ranking_provider.dart';
import 'package:webtoon_explorer_app/screens/components/img_slider.dart';
import 'package:webtoon_explorer_app/server/ranking_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
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
        // body: FutureBuilder(
        //   future: getAnimeByRankingTypeApi(rankingType: "all", limit: 4),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //     if (snapshot.data != null) {
        //       final animes = snapshot.data!.toList();
        //       return Column(
        //         children: [
        //           ImageSlider(animes: animes),
        //         ],
        //       );
        //     }
        //     return Text("Error.. No Data Found");
        //   },
        // ),
        body: Consumer<RankingProvider>(
          builder: (context, rankingProvider, child) {
            if (rankingProvider.isLoading == true) {
              return const Center(child: CircularProgressIndicator());
            }
            if (rankingProvider.animesData.length > 0) {
              final animes = rankingProvider.animesData!.toList();
              return Column(
                children: [
                  ImageSlider(animes: animes),
                ],
              );
            }
            return Text("Error.. No Data Found");
          },
        ),
      ),
    );
  }
}
