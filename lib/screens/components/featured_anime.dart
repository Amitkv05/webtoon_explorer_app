// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/models/anime.dart';
import 'package:webtoon_explorer_app/screens/detail_screen.dart';
import 'package:webtoon_explorer_app/server/ranking_api.dart';

class FeaturedAnime extends StatelessWidget {
  const FeaturedAnime({
    Key? key,
    required this.label,
    required this.rankingType,
    required this.animes,
    // required this.animeData,
  }) : super(key: key);
  final String label;
  final String rankingType;
  final Iterable<Anime> animes;
  // final Iterable<Anime> animeData;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Title Part...
        Container(
          padding: const EdgeInsets.all(16),
          // color: Colors.yellow,
          height: myHeight * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.arrow_right_rounded,
              )
            ],
          ),
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: FutureBuilder(
            future:
                getAnimeByRankingTypeApi(rankingType: rankingType, limit: 8),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data != null) {
                final animesData = snapshot.data!.toList();
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: animesData.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: myWidth * 0.01);
                  },
                  itemBuilder: (context, index) {
                    final animes = animesData[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => AnimeDetailsScreen(
                                  id: animes.node!.id!,
                                  animes: animes,
                                )));
                      },
                      child: Container(
                        height: myHeight * 0.40,
                        width: myWidth * 0.40,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                animes.node!.mainPicture!.medium!,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            ),
                            SizedBox(height: myHeight * 0.01),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                animes.node!.title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                                maxLines: 3,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Text("Error.. No Data Found");
            },
          ),
        ),
      ],
    );
  }
}
