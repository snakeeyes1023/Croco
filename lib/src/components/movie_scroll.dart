import 'package:croco/src/models/movie.dart';
import 'package:flutter/material.dart';

import '../screens/home/movie_info.dart';

class HorizontalCards extends StatelessWidget {
  final List<Movie> movieData;
  final String title;

  HorizontalCards(this.movieData, this.title);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movieData.length,
          itemBuilder: (context, index) {
            final String posterPath = movieData[index].poster;
            return Container(
              // width: MediaQuery.of(context).size.width * 0.6,
              child: Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return MovieInfo(movieData[index]);
                        },
                      ),
                    );
                  },
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: '$posterPath'),
                ),
              ),
            );
          },
        ),
      )
    ]);
  }
}
