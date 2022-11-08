import 'package:tmdb_api/tmdb_api.dart';

class Movie {
  final String title;
  final String link;
  final String poster;
  final int id;
  dynamic tmdbMovie;
  String previewLink = "";

  Future<void> searchOnTheMovieDatabase() async {
    final tmdb = TMDB(ApiKeys('b41cf1ce06b0bf7826e538951a966a49',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNDFjZjFjZTA2YjBiZjc4MjZlNTM4OTUxYTk2NmE0OSIsInN1YiI6IjYwZDc1OGU1ODgwNTUxMDAyZDE0YjRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pcGak6uUikgOsOU61ev2JKzg3X8mpjsF4CdQWElu0-8'));
    var foundedMovies = await tmdb.v3.search.queryMovies(splittedTitle);

    var results = foundedMovies["results"] as List<dynamic>;
    if (results.isNotEmpty) {
      var bestMatch = results[0];
      tmdbMovie = bestMatch;
    }
  }

  Future<void> searchMoviePreviewLink() async {
    if (tmdbMovie == null) {
      await searchOnTheMovieDatabase();
    }

    if (tmdbMovie != null) {
      var id = tmdbMovie["id"];
      final tmdb = TMDB(ApiKeys('b41cf1ce06b0bf7826e538951a966a49',
          'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNDFjZjFjZTA2YjBiZjc4MjZlNTM4OTUxYTk2NmE0OSIsInN1YiI6IjYwZDc1OGU1ODgwNTUxMDAyZDE0YjRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pcGak6uUikgOsOU61ev2JKzg3X8mpjsF4CdQWElu0-8'));
      var videos = await tmdb.v3.movies.getVideos(id);
      var results = videos["results"] as List<dynamic>;
      if (results.isNotEmpty) {
        var bestMatch = results[0];
        previewLink = "https://www.youtube.com/watch?v=" + bestMatch["key"];
      }
    }
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
