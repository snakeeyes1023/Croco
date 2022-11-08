import 'dart:io';
import 'package:m3u/m3u.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mysql1/mysql1.dart';
import '../models/movie.dart';
import 'enums/content_type_enum.dart';

class MovieService {
  late ConnectionSettings connectionSettings;

  MovieService() {
    connectionSettings = ConnectionSettings(
        host: '70.32.23.53',
        port: 3306,
        user: 'jonath37_CrocoBeta',
        password: '~B~_5@qtzW==',
        db: 'jonath37_CrocoBeta');
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
}
