import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webtoon_explorer_app/models/anime.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    super.key,
    required this.animes,
  });
  final Iterable<Anime> animes;
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentPageIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  Widget build(BuildContext context) {
    var myHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.blue,
      height: myHeight * 0.3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            itemCount: widget.animes.length,
            itemBuilder: (context, index, realIndex) {
              final anime = widget.animes.elementAt(index);
              return TopAnimePicture(anime: anime);
            },
            options: CarouselOptions(
              enlargeFactor: 0.22,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              aspectRatio: 16 / 9,
              viewportFraction: 0.88,
              autoPlay: true,
              enlargeCenterPage: true,
              initialPage: _currentPageIndex,
            ),
          ),
          const SizedBox(height: 20),

          // Page Indicator
          AnimatedSmoothIndicator(
            activeIndex: _currentPageIndex,
            count: widget.animes.length,
            effect: CustomizableEffect(
              dotDecoration: DotDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.green,
                width: 28.0,
                height: 8.0,
              ),
              activeDotDecoration: DotDecoration(
                rotationAngle: 180,
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
                width: 28.0,
                height: 8.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TopAnimePicture extends StatelessWidget {
  const TopAnimePicture({super.key, required this.anime});
  final Anime anime;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
    );
  }
}
