import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_explorer_app/models/anime.dart';
import 'package:webtoon_explorer_app/models/animeDetail.dart';
import 'package:webtoon_explorer_app/provider/ranking_provider.dart';
import 'package:webtoon_explorer_app/server/detail_api.dart';

class AnimeDetailsScreen extends StatefulWidget {
  const AnimeDetailsScreen({
    super.key,
    required this.id,
    required this.animes,
  });

  final int id;
  final Anime animes;

  @override
  State<AnimeDetailsScreen> createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RankingProvider>(
      builder: (context, rankingProvider, child) {
        return FutureBuilder(
          future: getAnimeByDetailTypeApi(id: widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data != null) {
              final anime = snapshot.data;
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            anime!.mainPicture.large,
                            fit: BoxFit.cover,
                            height: 400,
                            width: double.infinity,
                          ),
                          Positioned(
                            top: 30,
                            left: 10,
                            child: Builder(builder: (context) {
                              return CircleAvatar(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                  ),
                                  onPressed: Navigator.of(context).pop,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Rating bar
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(89, 33, 149, 243),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: RatingBar(
                                  itemSize: 26,
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  ratingWidget: RatingWidget(
                                    full: const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    half: const Icon(
                                      Icons.star_half,
                                      color: Colors.yellow,
                                    ),
                                    empty:
                                        const Icon(Icons.star_border_outlined),
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Title
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  anime.alternativeTitles.en,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                (widget.animes.isFavorite == false)
                                    ? GestureDetector(
                                        onTap: () {
                                          rankingProvider
                                              .addFavorite(widget.animes);
                                        },
                                        child: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.black,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          rankingProvider
                                              .removeFavorite(widget.animes);
                                        },
                                        child: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Description
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(89, 33, 149, 243),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Text(anime.synopsis),
                            ),

                            const SizedBox(height: 10),

                            _buildAnimeInfo(
                              anime: anime,
                            ),

                            const SizedBox(height: 20),

                            anime.background.isNotEmpty
                                ? _buildAnimeBackground(
                                    background: anime.background,
                                  )
                                : const SizedBox.shrink(),

                            const SizedBox(height: 20),

                            _buildAnimeImages(pictures: anime.pictures),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Text(
              "error:${snapshot.error}",
            );
          },
        );
      },
    );
  }

  Widget _buildAnimeInfo({
    required AnimeDetails anime,
  }) {
    String studios = anime.studios.map((studio) => studio.name).join(', ');
    String genres = anime.genres.map((genre) => genre.name).join(', ');
    String otherNames =
        anime.alternativeTitles.synonyms.map((title) => title).join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoText(label: 'Genres: ', info: genres),
        InfoText(label: 'Episodes: ', info: anime.numEpisodes.toString()),
        InfoText(label: 'Status: ', info: anime.status),
        InfoText(label: 'Rating: ', info: anime.rating),
        InfoText(label: 'Studios: ', info: studios),
        InfoText(label: 'Other Names: ', info: otherNames),
        InfoText(label: 'English Name: ', info: anime.alternativeTitles.en),
        InfoText(label: 'Japanese Name: ', info: anime.alternativeTitles.ja),
      ],
    );
  }

  Widget _buildAnimeBackground({
    required String background,
  }) {
    return WhiteContainer(
      child: Text(
        background,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildAnimeImages({
    required List<Picture> pictures,
  }) {
    return Column(
      children: [
        const Text(
          'Image Gallery',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        GridView.builder(
          itemCount: pictures.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 9 / 16,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final image = pictures[index].medium;
            // final largeImage = pictures[index].large;
            return SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {},
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class InfoText extends StatelessWidget {
  const InfoText({
    super.key,
    required this.label,
    required this.info,
  });

  final String label;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return RichText(
        text: TextSpan(
          text: label,
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: info,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    });
  }
}

class WhiteContainer extends StatelessWidget {
  const WhiteContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
