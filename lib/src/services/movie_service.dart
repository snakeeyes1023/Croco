import 'package:mysql1/mysql1.dart';
import '../models/movie.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'connection.dart';

class MovieService {
  late ConnectionSettings connectionSettings;

  MovieService() {
    WidgetsFlutterBinding.ensureInitialized();

    connectionSettings = Connection.getRemoteMysqlConnectionSettings();
  }

  /// Read the m3u files and return the all movies
  Future<List<Movie>> getLastMovies() async {
    var conn = await MySqlConnection.connect(connectionSettings);

    return await conn
        .query(
            'SELECT id, title, link, poster FROM Movie ORDER BY id DESC LIMIT 10 ')
        .then((value) =>
            value.map((e) => Movie(e[0], e[1], e[2], e[3])).toList());
  }

  Future<List<Movie>> getFirstMovies() async {
    var conn = await MySqlConnection.connect(connectionSettings);

    return await conn
        .query(
            'SELECT id, title, link, poster FROM Movie ORDER BY id ASC LIMIT 10 ')
        .then((value) =>
            value.map((e) => Movie(e[0], e[1], e[2], e[3])).toList());
  }

  Future<List<Movie>> getRandomMovies() async {
    var conn = await MySqlConnection.connect(connectionSettings);

    return await conn
        .query(
            'SELECT id, title, link, poster FROM Movie ORDER BY RAND() LIMIT 10')
        .then((value) =>
            value.map((e) => Movie(e[0], e[1], e[2], e[3])).toList());
  }

  Future<Movie> getMovieById(int id) async {
    var conn = await MySqlConnection.connect(connectionSettings);

    var movies = await conn.query(
        'SELECT id, title, link, poster FROM Movie WHERE id = ? LIMIT 1', [
      id
    ]).then(
        (value) => value.map((e) => Movie(e[0], e[1], e[2], e[3])).toList());

    return movies[0];
  }
}
