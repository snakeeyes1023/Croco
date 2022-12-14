import 'package:croco/src/services/favorite_service.dart';
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
  final FavoriteService favoriteService = FavoriteService();
  bool? isFavorite;

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

  Future<void> fetchIsFavorite() async {
    await widget.favoriteService
        .isFavorite(widget.movie)
        .then((value) => setState(() {
              widget.isFavorite = value;
            }));
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
                        "Aucune description trouv?? pour ce film",
                    style: textStyle),
              ],
            ),

            const Padding(padding: EdgeInsets.only(top: 20.0)),
            //NOTE - Button to add to favorites ( outline button black )
            FutureBuilder<bool>(
              future: widget.favoriteService.isFavorite(widget.movie),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  widget.isFavorite = snapshot.data;
                }
                return CustomButton(
                    widget.isFavorite == null
                        ? "Chargement..."
                        : widget.isFavorite!
                            ? "Retirer des favoris"
                            : "Ajouter aux favoris",
                    Colors.black,
                    false,
                    () => {
                          widget.isFavorite = !widget.isFavorite!,
                          widget.favoriteService
                              .updateFavorite(widget.movie, widget.isFavorite!),
                          setState(() {})
                        });
              },
            )
          ],
        ));
  }
}
