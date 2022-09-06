import 'package:croco/src/services/commonCache.dart';
import 'package:croco/src/views/shared/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../settings/settings_view.dart';
import 'package:m3u/m3u.dart';

/// Displays a list of SampleItems.
class CarouselMovies extends StatelessWidget {
  CarouselMovies({Key? key, required this.content, required this.sectionName})
      : super(key: key) {
    widgets = [];
    content.forEach((element) {
      widgets.add(toWidget(element));
    });
  }

  late List<Widget> widgets;
  final List<M3uGenericEntry> content;
  final String sectionName;

  final CarouselController buttonCarouselController = CarouselController();

  Widget toWidget(M3uGenericEntry entry) {
    return Container(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: Container(
            child: Stack(
          children: <Widget>[
            Image.network(entry.attributes['tvg-logo'] ?? "",
                fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ), /*
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),*/
              ),
            ),
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                sectionName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          CarouselSlider(
            items: widgets,
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: false,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              viewportFraction: 0.25,
            ),
          ),
        ],
      ),
    );
  }
}
