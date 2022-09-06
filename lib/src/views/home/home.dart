import 'package:croco/src/services/commonCache.dart';
import 'package:croco/src/views/shared/carouselMovies.dart';
import 'package:croco/src/views/shared/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../settings/settings_view.dart';
import 'package:m3u/m3u.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  CommonCache commonCache;
  List<M3uGenericEntry> topMovies = [];
  List<M3uGenericEntry> newMovies = [];
  List<M3uGenericEntry> fourKMovies = [];

  Home({Key? key, required this.commonCache}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

/// Displays a list of SampleItems.
class HomeState extends State<Home> {
  final CarouselController buttonCarouselController = CarouselController();

  void getMovies() {
    widget.commonCache.getGroup("top 25").then((value) => {
          setState(() {
            widget.topMovies = value.take(10).toList();
          })
        });

    widget.commonCache.getGroup("nouveautés").then((value) => {
          setState(() {
            widget.newMovies = value.take(10).toList();
          })
        });

    widget.commonCache.getGroup("4k").then((value) => {
          setState(() {
            widget.fourKMovies = value.take(10).toList();
          })
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getMovies();

    return FutureBuilder<CommonCache>(
      future: widget.commonCache.fillCache(forceRefresh: true),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Croco'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.pushNamed(context, SettingsView.routeName);
                    },
                  )
                ],
              ),
              drawer: Sidebar(commonCache: widget.commonCache),
              body: ListView(
                children: [
                  Column(
                    children: [
                      CarouselMovies(
                          content: widget.topMovies,
                          sectionName: "Derniers ajouts"),
                      CarouselMovies(
                          content: widget.newMovies, sectionName: "Nouveautés"),
                      CarouselMovies(
                          content: widget.fourKMovies,
                          sectionName: "Film en 4k"),
                    ],
                  ),
                ],
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
