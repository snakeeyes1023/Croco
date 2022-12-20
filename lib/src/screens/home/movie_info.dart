import 'package:croco/src/components/play_button.dart';
import 'package:croco/src/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../components/movie_info_desc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../../services/favorite_service.dart';
import '../player/player.dart';

class MovieInfo extends StatefulWidget {
  MovieInfo(this.movie, {super.key});

  final Movie movie;
  final FavoriteService favoriteService = FavoriteService();
  bool? isFavorite;

  @override
  _MovieInfo createState() => _MovieInfo();
}

class _MovieInfo extends State<MovieInfo> {
  /// Get the dominant color of the image then put it as the background color
  Future<Color> getBgColor() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.network(widget.movie.poster).image,
    );

    //return best color background with a dark filter
    return darken(
        paletteGenerator.dominantColor?.color ?? Colors.black.withOpacity(0.7),
        0.1);
  }

  /// Darken a color
  /// [color] is the color to darken
  /// [amount] is the amount to darken the color
  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  /// Search all principal informations about the movie on the movie database TMDB
  Future<void> fetchMoviePreview() async {
    if (widget.movie.previewLink == "") {
      await widget.movie.searchMoviePreviewLink();
      setState(() {});
    }
  }

  /// Open the preview link in the browser
  Future<void> _launchURL() async {
    // Mettre a false pour ouvrir le vrai film hihi
    bool showPreview = true;

    var movieUrl = widget.movie.previewLink;

    if (!showPreview) {
      movieUrl = widget.movie.link;
    }

    //open player.dart
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return Player(movieUrl);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchMoviePreview();
  }

  @override
  Widget build(BuildContext context) {
    final String posterPath = widget.movie.poster;
    return Scaffold(
        // back button
        appBar: AppBar(
          foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          shadowColor: const Color.fromRGBO(255, 255, 255, 1),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          FutureBuilder<Color>(
              future: getBgColor(), // async work
              builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.7));
                } else {
                  return Stack(children: [
                    Container(
                      alignment: Alignment.center,
                      height: 300.0,
                      decoration: BoxDecoration(color: snapshot.data),
                      padding: const EdgeInsets.all(16.0),
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: posterPath),
                    ),
                    Positioned(
                        top: 220,
                        left: 12,
                        child: PlayButton(
                            _launchURL, widget.movie.previewLink == "")),
                  ]);
                }
              }),
          MovieInfoDesc(widget.movie),
        ])));
  }
}
