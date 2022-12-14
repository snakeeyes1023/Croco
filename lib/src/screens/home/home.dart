import 'package:flutter/material.dart';

import '../../components/movie_scroll.dart';
import '../../services/movie_service.dart';

class Home extends StatefulWidget {
  Home({super.key});

  MovieService movieService = MovieService();

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 8.0, top: 40.0, bottom: 40),
            child: const Text("Croco",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ),
        FutureBuilder(
          future: widget.movieService.getLastMovies(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Image.asset('assets/images/loading.gif'),
              );
            } else {
              return HorizontalCards(snapshot.data, "Derniés ajoutés");
            }
          },
        ),
        FutureBuilder(
          future: widget.movieService.getRandomMovies(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Image.asset('assets/images/loading.gif'),
              );
            } else {
              return HorizontalCards(snapshot.data, "Films aléatoires");
            }
          },
        ),
      ],
    ));
  }
}
