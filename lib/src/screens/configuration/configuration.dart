import 'package:croco/src/components/custom_button.dart';
import 'package:croco/src/components/custom_input.dart';
import 'package:croco/src/components/custom_plain_button.dart';
import 'package:flutter/material.dart';

import '../../components/movie_scroll.dart';
import '../../services/movie_service.dart';

class Configuration extends StatefulWidget {
  Configuration({super.key});

  MovieService movieService = MovieService();
  TextEditingController m3uLinkController = TextEditingController();

  @override
  State<Configuration> createState() => _Configuration();
}

class _Configuration extends State<Configuration> {
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
            child: const Text("Configuration",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child:
              //text + input + button to add a new link to the database
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ajouter un nouveau lien", style: textStyle),
              const Padding(padding: EdgeInsets.only(top: 10)),
              CustomInput("Lien .m3u", widget.m3uLinkController),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const CustomPlainButton("Ajouter à la liste de lien", true)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child:
              //text + input + button to add a new link to the database
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Données utilisateur", style: textStyle),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const CustomButton(
                  "Supprimer l'historique de lecture", Colors.black, true),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const CustomButton("Supprimer le compte", Colors.red, true)
            ],
          ),
        ),
      ],
    ));
  }
}
