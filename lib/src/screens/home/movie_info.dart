import 'package:croco/src/models/movie.dart';
import 'package:flutter/material.dart';

class MovieInfo extends StatefulWidget {
  MovieInfo(this.movie, {super.key});

  final Movie movie;

  @override
  _MovieInfo createState() => _MovieInfo();
}

class _MovieInfo extends State<MovieInfo> {
  @override
  Widget build(BuildContext context) {
    final String posterPath = widget.movie.poster;

    return Container(
        child: Scaffold(
      // back button
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
          child: Card(
              elevation: 4.0,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.movie.title),
                    subtitle: Text("Aucune description "),
                    trailing: Icon(Icons.favorite_outline),
                  ),
                  Container(
                    height: 200.0,
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading.gif',
                        image: posterPath),
                  ),
                  /*child: Ink.image(
                      image: NetworkImage(widget.movie.poster),
                      fit: BoxFit.cover,
                    ),*/

                  Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.centerLeft,
                    child: Text("Supporter"),
                  ),
                ],
              ))),
    ));
  }
}
