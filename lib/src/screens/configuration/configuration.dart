import 'package:croco/src/components/custom_button.dart';
import 'package:croco/src/components/custom_input.dart';
import 'package:croco/src/components/custom_plain_button.dart';
import 'package:croco/src/models/favorite_movie.dart';
import 'package:croco/src/services/favorite_service.dart';
import 'package:croco/src/services/synchronizer.dart';
import 'package:flutter/material.dart';
import '../../services/movie_service.dart';

class Configuration extends StatefulWidget {
  Configuration({super.key});

  FavoriteService movieService = FavoriteService();
  Synchronizer synchronizer = Synchronizer();
  TextEditingController m3uLinkController = TextEditingController();

  bool isSynchronizing = false;

  @override
  State<Configuration> createState() => _Configuration();
}

class _Configuration extends State<Configuration> {
  var textStyle = const TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);

  void removeAllFavorite() async {
    widget.movieService
        .deleteAllFavoriteMovies()
        .then((value) => showDeleteFavoriteMoviesPopup(value));
  }

  void showDeleteFavoriteMoviesPopup(bool succeeded) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(succeeded ? "Suppression réussie" : "Erreur"),
            content: Text(succeeded
                ? "Tous les films favoris ont été supprimés"
                : "Une erreur est survenue lors de la suppression"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"))
            ],
          );
        });
  }

  /// Add a new m3u link to the database
  Future<void> addNewM3uLink() async {
    widget.synchronizer
        .addNewLink(widget.m3uLinkController.text)
        .then((value) => showSyncResultPopup(value));

    setState(() => widget.isSynchronizing = true);
  }

  /// Show a popup to inform the user about the result of the synchronization
  void showSyncResultPopup(bool succeeded) {
    setState(() => widget.isSynchronizing = false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(succeeded ? "Synchronisation réussie" : "Erreur"),
            content: Text(succeeded
                ? "La synchronisation a été effectuée avec succès"
                : "Une erreur est survenue lors de la synchronisation"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSynchronizing
        ? Container(
            color: Colors.grey[300],
            alignment: Alignment.center,
            width: 70.0,
            height: 70.0,
            child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Center(child: CircularProgressIndicator())))
        : SingleChildScrollView(
            child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 40.0, bottom: 40),
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
                    CustomPlainButton("Ajouter à la liste de lien", true,
                        () => {addNewM3uLink()})
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
                    CustomButton("Supprimer le compte", Colors.red, true,
                        () => {removeAllFavorite()})
                  ],
                ),
              ),
            ],
          ));
  }
}
