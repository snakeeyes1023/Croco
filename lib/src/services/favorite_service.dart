import 'dart:io';
import 'package:croco/src/models/favorite_movie.dart';
import 'package:croco/src/services/movie_service.dart';
import 'package:m3u/m3u.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mysql1/mysql1.dart';
import '../models/movie.dart';
import 'enums/content_type_enum.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteService {
  Future<Database>? database;
  static const String databasePath = 'croco.db';
  static const String tableFavoriteMovie = 'Movie';

  MovieService movieService = MovieService();

  FavoriteService() {
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<Database> getDatabaseInstance() async {
    database ??= openDatabase(
      join(await getDatabasesPath(), databasePath),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS $tableFavoriteMovie(id INTEGER PRIMARY KEY,remoteId INTEGER, isFavorite BIT)",
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

    if (await isFavorite(movie)) {
      // update the movie
      await db.update(
        tableFavoriteMovie,
        {'isFavorite': enable ? 1 : 0},
        where: 'remoteId = ?',
        whereArgs: [movie.id],
      );
    } else {
      // insert the movie
      await db.insert(
        tableFavoriteMovie,
        {'remoteId': movie.id, 'isFavorite': enable ? 1 : 0},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<bool> isFavorite(Movie movie) async {
    // Get a reference to the database.
    final Database db = await getDatabaseInstance();

    // check if the movie is already in the db
    final List<Map<String, dynamic>> maps = await db.query(tableFavoriteMovie,
        where: 'remoteId = ? AND isFavorite = 1', whereArgs: [movie.id]);

    return maps.isNotEmpty;
  }

  Future<List<Movie>> getFavorites() async {
    // Get a reference to the database.
    final Database db = await getDatabaseInstance();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps =
        await db.query(tableFavoriteMovie, where: 'isFavorite = 1');

    // Convert the List<Map<String, dynamic> into a List<FavoriteMovie> with the frommap.

    List<FavoriteMovie> likedMovies = List.generate(maps.length, (i) {
      return FavoriteMovie.fromMap(maps[i]);
    });

    List<Movie> movies = [];

    for (var movie in likedMovies) {
      movies.add(await movieService.getMovieById(movie.remoteId));
    }

    return movies;
  }

  Future<void> deleteAllFavoriteMovies() async {
    // Get a reference to the database.
    final Database db = await getDatabaseInstance();

    db.delete(tableFavoriteMovie);
  }
}
