import 'package:croco/src/models/movie.dart';
import 'package:croco/src/screens/player/player.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../components/movie_info_desc.dart';

class MovieInfo extends StatefulWidget {
  MovieInfo(this.movie, {super.key});

  final Movie movie;

  @override
  _MovieInfo createState() => _MovieInfo();
}

class _MovieInfo extends State<MovieInfo> {
  Future<Color> getBgColor() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.network(widget.movie.poster).image,
    );

    //return best color background with a dark filter
    return darken(
        paletteGenerator.dominantColor?.color ?? Colors.black.withOpacity(0.7),
        0.1);
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Future<void> fetchMoviePreview() async {
    if (widget.movie.previewLink == "") {
      await widget.movie.searchMoviePreviewLink();
      setState(() {});
    }
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
                        child: ClipOval(
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              customBorder: const CircleBorder(
                                  side: BorderSide(
                                      color: Colors.black, width: 2)),
                              splashColor: Colors.black, // Splash color
                              onTap: () {
                                // show a popup
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: const Text('Preview'),
                                          content: Container(
                                              height: 300,
                                              width: 300,
                                              child: Column(children: [
                                                widget.movie.link == ""
                                                    ? const Text(
                                                        "Aucune preview trouvé pour ce film")
                                                    : MyPlayer(
                                                        widget.movie.link)
                                              ])));
                                    });
                              },
                              child: const SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Icon(Icons.play_arrow)),
                            ),
                          ),
                        )),
                    //button play
                  ]);
                }
              }),
          MovieInfoDesc(widget.movie),
        ])));
  }
}
