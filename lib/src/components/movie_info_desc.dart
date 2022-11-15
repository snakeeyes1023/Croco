import 'package:croco/src/services/movie_service.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'custom_button.dart';

class MovieInfoDesc extends StatefulWidget {
  MovieInfoDesc(
    this.movie, {
    Key? key,
  }) : super(key: key);

  final Movie movie;
  final MovieService movieService = MovieService();

  @override
  State<MovieInfoDesc> createState() => _MovieInfoDesc();
}

class _MovieInfoDesc extends State<MovieInfoDesc> {
  Future<void> fetchMovieInfo() async {
    if (widget.movie.tmdbMovie == null) {
      await widget.movie.searchOnTheMovieDatabase();

      if (widget.movie.tmdbMovie != null) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMovieInfo();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.grey);

    const textStyleTitle = TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.w900, color: Colors.black);

    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //NOTE - title
            Text(widget.movie.splittedTitle, style: textStyleTitle),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            //NOTE - Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Description", style: textStyle),
                Text(
                    widget.movie.tmdbMovie?["overview"] ??
                        "Aucune description trouvé pour ce film",
                    style: textStyle),
              ],
            ),

            const Padding(padding: EdgeInsets.only(top: 20.0)),
            //NOTE - Button to add to favorites ( outline button black )
            CustomButton("+ Add to favorites", Colors.black, false,
                () => {widget.movieService.addMovieToFavorite(widget.movie)}),
          ],
        ));
  }
}
