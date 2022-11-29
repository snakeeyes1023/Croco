import 'dart:io';
import 'package:m3u/m3u.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mysql1/mysql1.dart';
import '../models/movie.dart';
import 'enums/content_type_enum.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieService {
  late ConnectionSettings connectionSettings;
  Future<Database>? database;
  static const String databasePath = 'wack-a-mole.db';
  static const String tableFavoriteMovie = 'Movie';

  MovieService() {
    WidgetsFlutterBinding.ensureInitialized();

    connectionSettings = ConnectionSettings(
        host: '70.32.23.53',
        port: 3306,
        user: 'jonath37_CrocoBeta',
        password: '~B~_5@qtzW==',
        db: 'jonath37_CrocoBeta');
  }

  Future<Database> getDatabaseInstance() async {
    database ??= openDatabase(
      join(await getDatabasesPath(), databasePath),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS $tableFavoriteMovie(id INTEGER PRIMARY KEY,name TEXT, score INTEGER, creation_date TEXT)",
        );
      },
      version: 2,
    );

    return database!;
  }

  Future<void> updateFavorite(Movie movie, bool enable) async {
    // Get a reference to the database.
    final Database db = await getDatabaseInstance();

    // check if the movie is already in the db
    final List<Map<String, dynamic>> maps = await db
        .query(tableFavoriteMovie, where: 'id = ?', whereArgs: [movie.id]);

    if (maps.isNotEmpty) {
      // update the movie
      await db.update(
        tableFavoriteMovie,
        movie.toMap(),
        where: "id = ?",
        whereArgs: [movie.id],
      );
    } else {
      // insert the movie
      await db.insert(
        tableFavoriteMovie,
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

/*
  Future<List<Movie>> getFavorites() async {
    // Get a reference to the database.
    final Database db = await getDatabaseInstance();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(tableFavoriteMovie);

    return List.generate(maps.length, (i) {
      return Movie(
        id: maps[i]['id'],
        title: maps[i]['title'],
        link: maps[i]['link'],
        poster: maps[i]['poster'],
      );
    });
  }
*/
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

  Future<List<Movie>> getFavoriteMovies() async {
    return getRandomMovies();
  }

  Future<void> addMovieToFavorite(Movie movie) async {
    var conn = await MySqlConnection.connect(connectionSettings);

    await conn
        .query('INSERT INTO FavoriteMovie (movieId) VALUES (?)', [movie.id]);
  }

  Future<void> deleteAllFavoriteMovies() async {
    var conn = await MySqlConnection.connect(connectionSettings);

    await conn.query('DELETE FROM FavoriteMovie');
  }
}
