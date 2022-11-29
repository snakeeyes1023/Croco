import 'package:croco/src/components/custom_button.dart';
import 'package:croco/src/components/custom_input.dart';
import 'package:croco/src/components/custom_plain_button.dart';
import 'package:flutter/material.dart';

import '../../components/movie_scroll.dart';
import '../../services/movie_service.dart';
import '../home/movie_info.dart';

class Favorite extends StatefulWidget {
  Favorite({super.key});

  MovieService movieService = MovieService();

  @override
  State<Favorite> createState() => _Favorite();
}

class _Favorite extends State<Favorite> {
  var textStyle = const TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 8.0, top: 40.0, bottom: 40),
            child: const Text("Favoris",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ),
        FutureBuilder(
          future: widget.movieService.getFavoriteMovies(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Image.asset('assets/images/loading.gif'),
              );
            } else {
              // grid view with favorite movies 3 columns
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return Card(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return MovieInfo(snapshot.data[index]);
                          },
                        ),
                      );
                    },
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: snapshot.data[index].poster,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/no-image-icon-4.png');
                      },
                    ),
                  ));
                },
              );
            }
          },
        ),
      ],
    ));
  }
}
