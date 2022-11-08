import 'package:flutter/material.dart';

import '../../components/movie_scroll.dart';
import '../../services/movie_service.dart';

class Configuration extends StatefulWidget {
  Configuration({super.key});

  MovieService movieService = MovieService();

  @override
  State<Configuration> createState() => _Configuration();
}

class _Configuration extends State<Configuration> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 8.0, top: 40.0, bottom: 40),
            child: const Text("Configuration",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ),
        //text + input + button to add a new link to the database
        Container(
          child: Column(
            children: [
              const Text("Ajouter un nouveau lien"),
              const TextField(),
              const ElevatedButton(onPressed: null, child: Text("Ajouter"))
            ],
          ),
        ),
      ],
    ));
  }
}
