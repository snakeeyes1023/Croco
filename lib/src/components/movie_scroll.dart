import 'package:croco/src/models/movie.dart';
import 'package:flutter/material.dart';

import '../screens/home/movie_info.dart';

class HorizontalCards extends StatelessWidget {
  final List<Movie> movieData;
  final String title;

  const HorizontalCards(this.movieData, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.23,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movieData.length,
          itemBuilder: (context, index) {
            final String posterPath = movieData[index].poster;
            return Card(
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
                image: posterPath,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/no-image-icon-4.png');
                },
              ),
            ));
          },
        ),
      )
    ]);
  }
}
