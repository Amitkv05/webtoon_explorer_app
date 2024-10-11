import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_explorer_app/models/anime.dart';
import 'package:webtoon_explorer_app/provider/ranking_provider.dart';
import 'package:webtoon_explorer_app/screens/detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    // double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(89, 33, 149, 243),
        title: const Text('Favorited Anime'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<RankingProvider>(
            builder: (context, rankingProvider, child) {
              List<Anime> favorite = rankingProvider.animesData
                  .where((element) => element.isFavorite == true)
                  .toList();
              if (favorite.length > 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: favorite.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 10 / 15,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      Anime favAnime = favorite[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AnimeDetailsScreen(
                                    id: favAnime.node!.id!,
                                    animes: favAnime,
                                  )));
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                favAnime.node!.mainPicture!.medium!,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            ),
                            SizedBox(height: myHeight * 0.01),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 120,
                                    child: Text(
                                      favAnime.node!.title!,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  (favAnime.isFavorite == false)
                                      ? GestureDetector(
                                          onTap: () {
                                            rankingProvider
                                                .addFavorite(favAnime);
                                          },
                                          child: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.black,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            rankingProvider
                                                .removeFavorite(favAnime);
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'No favourite yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
