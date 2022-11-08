import 'package:tmdb_api/tmdb_api.dart';

class Movie {
  final String title;
  final String link;
  final String poster;
  final int id;

  Future<void> searchOnTheMovieDatabase() async {
    final tmdb = TMDB(ApiKeys('b41cf1ce06b0bf7826e538951a966a49',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNDFjZjFjZTA2YjBiZjc4MjZlNTM4OTUxYTk2NmE0OSIsInN1YiI6IjYwZDc1OGU1ODgwNTUxMDAyZDE0YjRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pcGak6uUikgOsOU61ev2JKzg3X8mpjsF4CdQWElu0-8'));
    var foundedMovies = await tmdb.v3.search.queryMovies(splittedTitle);

    var bestMatch = foundedMovies["results"][0];
  }

  //get movie name split FR| Bobby, seul contre tous
  String get splittedTitle {
    var split = title.split("|");
    return split.last.trim();
  }

  Movie(this.id, this.title, this.link, this.poster);

  @override
  String toString() {
    return 'Movie{title: $title, link: $link, poster: $poster}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          link == other.link &&
          poster == other.poster;

  @override
  int get hashCode => title.hashCode ^ link.hashCode ^ poster.hashCode;
}
