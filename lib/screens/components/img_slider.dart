import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:webtoon_explorer_app/models/anime.dart';
import 'package:webtoon_explorer_app/provider/ranking_provider.dart';
import 'package:webtoon_explorer_app/screens/detail_screen.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    super.key,
    required this.animes,
    required this.rankingProvider,
  });
  final Iterable<Anime> animes;
  final RankingProvider rankingProvider;
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentPageIndex = 0;
  // final CarouselSliderController _controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    var myHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(8),
      height: myHeight * 0.26,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            itemCount: widget.animes.length,
            itemBuilder: (context, index, realIndex) {
              final anime = widget.animes.elementAt(index);
              return TopAnimePicture(
                anime: anime,
                rankingProvider: widget.rankingProvider,
              );
            },
            options: CarouselOptions(
              enlargeFactor: 0.22,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              aspectRatio: 16 / 9,
              viewportFraction: 0.90,
              autoPlay: true,
              enlargeCenterPage: true,
              initialPage: _currentPageIndex,
            ),
          ),
        ],
      ),
    );
  }
}

class TopAnimePicture extends StatelessWidget {
  const TopAnimePicture(
      {super.key, required this.anime, required this.rankingProvider});
  final Anime anime;
  final RankingProvider rankingProvider;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AnimeDetailsScreen(
                      id: anime.node!.id!,
                      animes: anime,
                    )));
          },
          splashColor: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                anime.node!.mainPicture!.medium!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 10,
          child: Builder(builder: (context) {
            return Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                // color: Colors.grey.shade300,
                color: const Color.fromARGB(114, 158, 158, 158),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 285,
                    child: Text(
                      anime.node!.title!,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  (anime.isFavorite == false)
                      ? GestureDetector(
                          onTap: () {
                            rankingProvider.addFavorite(anime);
                          },
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            rankingProvider.removeFavorite(anime);
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
