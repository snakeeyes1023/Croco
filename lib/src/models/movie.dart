import '../services/connection.dart';

class Movie {
  final String title;
  final String link;
  final String poster;
  final int id;

  dynamic tmdbMovie;
  String previewLink = "";

  Movie(this.id, this.title, this.link, this.poster);

  // Bind the Movie from the movie database
  Future<void> searchOnTheMovieDatabase() async {
    final tmdb = Connection.getTmdbInstance();
    var foundedMovies = await tmdb.v3.search.queryMovies(splittedTitle);

    var results = foundedMovies["results"] as List<dynamic>;
    if (results.isNotEmpty) {
      var bestMatch = results[0];
      tmdbMovie = bestMatch;
    }
  }

  // Search for the movie preview link on the movie database
  Future<void> searchMoviePreviewLink() async {
    if (tmdbMovie == null) {
      await searchOnTheMovieDatabase();
    }

    if (tmdbMovie != null) {
      var id = tmdbMovie["id"];
      final tmdb = Connection.getTmdbInstance();
      var videos = await tmdb.v3.movies.getVideos(id);
      var results = videos["results"] as List<dynamic>;
      if (results.isNotEmpty) {
        var bestMatch = results[0];
        previewLink = "https://www.youtube.com/watch?v=" + bestMatch["key"];
      }
    }
  }

  String get splittedTitle {
    var split = title.split("|");
    return split.last.trim();
  }

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
