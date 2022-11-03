import 'package:croco/src/views/shared/carouselMovies.dart';
import 'package:croco/src/views/shared/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../settings/settings_view.dart';
import 'package:m3u/m3u.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  List<M3uGenericEntry> topMovies = [];
  List<M3uGenericEntry> newMovies = [];
  List<M3uGenericEntry> fourKMovies = [];

  Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

/// Displays a list of SampleItems.
class HomeState extends State<Home> {
  final CarouselController buttonCarouselController = CarouselController();

  void getMovies() {
    /*widget.commonCache.getGroup("top 25").then((value) => {
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
        });*/
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
/*
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<>(
      future: widget.commonCache.fillCache(forceRefresh: true),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          getMovies();

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
              drawer: Sidebar(),
              body: ListView(
                children: [
                  Column(
                    children: [
                      CarouselMovies(
                          content: widget.topMovies,
                          sectionName: "Derniers ajouts"),
                      /*CarouselMovies(
                          content: widget.newMovies, sectionName: "Nouveautés"),
                      CarouselMovies(
                          content: widget.fourKMovies,
                          sectionName: "Film en 4k"),*/
                    ],
                  ),
                ],
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }*/
}
